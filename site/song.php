<?php
    $ch = curl_init();
    curl_setopt($ch, CURLOPT_URL, "s8.myradiostream.com:57132/7.html");
    curl_setopt($ch,CURLOPT_USERAGENT,'Mozilla');
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
    curl_setopt($ch, CURLOPT_CONNECTTIMEOUT, 5);
    $data = curl_exec($ch);
    curl_close($ch);
    $data = str_replace('</body></html>', "", $data);
    $split = explode(',', $data); 
    if (empty($split[6])) { 
        $title = "The current song is not available "; 
    } else { 
        $count = count($split); 
        $i = "6"; 
        while($i<=$count) { 
            if ($i > 6) { 
                $title .= "," . $split[$i]; 
            } else { 
                $title .= $split[$i]; 
            } 
            $i++; 
        }
    }
    $title = substr($title, 0, -1);
    echo $title;
?>