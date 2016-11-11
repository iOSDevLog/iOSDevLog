<?php

$deviceToken='215429c637b955dfec66811a338b6c3bd691995d565e74f7d21320e8bc792bf6';//这里填写设备的Token码
$passphrase = '123456'; //证书密码
//推送的消息 ;
$message = 'Hello'; //要发送的标题
////////////////////////////////////////////////////////////////////////////////
//如果在Windows的服务器上，寻找pem路径会有问题，路径修改成这样的方法：
//$pem = dirname(__FILE__) . '/' . 'apns-dev.pem';
//linux 的服务器直接写pem的路径即可
$ctx = stream_context_create();
stream_context_set_option($ctx, 'ssl', 'local_cert', 'apns-dis.pem');//ck文件
stream_context_set_option($ctx, 'ssl', 'passphrase', $passphrase);

// Open a connection to the APNS server
/*
/此处有两个服务器需要选择，如果是开发测试用，选择第二名sandbox的服务器并使用Dev的pem证书，
如果是正是发布，使用Product的pem并选用正式的服务器	
*/

//正式环境的地址
//$fp = stream_socket_client(
//    'ssl://gateway.push.apple.com:2195', $err,
//    $errstr, 60, STREAM_CLIENT_CONNECT|STREAM_CLIENT_PERSISTENT, $ctx);

//测试环境
 $fp = stream_socket_client(
     'ssl://gateway.sandbox.push.apple.com:2195', $err,
     $errstr, 60, STREAM_CLIENT_CONNECT|STREAM_CLIENT_PERSISTENT, $ctx);

if (!$fp)
    exit("Failed to connect: $err $errstr" . PHP_EOL);

echo 'Connected to APNS' . PHP_EOL;

// Create the payload body
$body['aps'] = array(
    'alert' => $message,
    'sound' => 'default',
    'badge' => '12',
    'url' => 'https://iosdevlog.com',
    );

// Encode the payload as JSON
$payload = json_encode($body);

// Build the binary notification
$msg = chr(0) . pack('n', 32) . pack('H*', $deviceToken) . pack('n', strlen($payload)) . $payload;

// Send it to the server
$result = fwrite($fp, $msg, strlen($msg));

if (!$result)
    echo 'Message not delivered' . PHP_EOL;
else
    echo 'Message successfully delivered' . PHP_EOL;

// Close the connection to the server
fclose($fp);
    
?>
