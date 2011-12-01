<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title>Untitled Document</title>
</head>

<body>
<?php 
$orig_string = "http://gnosticmedia.com.previewdns.com/podcast/GnosticMedia_PC_001_Ruck_Grove_Irvin.mp3 31554932 audio/mpeg a:1:{s:8:\"duration\";s:7:\"1:25:43\";}";
$pattern = '/\.previewdns\.com/';
$replace = '';

echo $newstring = preg_replace($pattern,$replace,$orig_string);

?>
</body>
</html>
