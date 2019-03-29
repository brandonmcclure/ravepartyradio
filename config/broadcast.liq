#!/usr/bin/env liquidsoap


%include "utils.liq"


# CONFIGS
set("log.file", true)
set("log.stdout", true)
set("log.level", 4)
set("server.telnet", true)
set("server.telnet.port", 5000)
set("log.file.path", "/tmp/broadcast.log")
set("audio.converter.samplerate.libsamplerate.quality","best")
set("buffering.path","/tmp")
set("decoding.buffer_length",10.)


# FUNCTIONS
rpr_out = output.icecast(description="Rave Party Radio", genre="Electronica", url="http://ravepartyradio.org")
output_docker_env.icecast = rpr_out(
    host=my_getenv("ICECAST_PORT_8000_TCP_ADDR"),
    port=int_of_string(my_getenv("ICECAST_PORT_8000_TCP_PORT")),
    password=my_getenv("ICECAST_SOURCE_PASSWORD")
)
def outputs(encoder, ~mount, input)
    output_docker_env.icecast(encoder, mount=mount, input)
end


# MIXS
default = mksafe(
    rewrite_metadata(
        [
            ("artist", "Rave Party Radio"),
            ("title", "Back Soon!"),
            ("comment", "http://ravepartyradio.org")
            ],
        audio_to_stereo(
            playlist.safe(
                reload=60,
                "/playlists/shows",
                mode="random"
                )
            )
        )
    )

harbor_input = input.harbor("rpr.main", port=5001, password=my_getenv("HARBOR_PASSWORD"))
input = mksafe(fallback(track_sensitive=false, [ harbor_input, default ]))


# NORMALIZE
#input = audio_process(input)


# OUTPUTS
outputs(%mp3(bitrate=128), mount="/ravepartyradio-128.mp3", input)
outputs(%mp3(bitrate=192), mount="/ravepartyradio-192.mp3", input)
outputs(%aac(bitrate=128), mount="/ravepartyradio-128.aac", input)
outputs(%aac(bitrate=192), mount="/ravepartyradio-192.aac", input)
outputs(%vorbis, mount="/ravepartyradio.ogg", input)
