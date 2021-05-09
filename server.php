<?php

$host = "127.0.0.1";
$port = 6000;

set_time_limit(0);

//create socket
$socket = socket_create(AF_INET, SOCK_STREAM, 0) or die('Could not create socket');

//bind socket to port
$result = socket_bind($socket, $host, $port) or die('Could not bind to the socket');

//listen to incomming connections
$result = socket_listen($socket, 3) or die('Could not setup socket listener');

while(true){
  //accept incoming connections
  $accept_socket = socket_accept($socket) or die('Could not accept incoming connections');

  //read the client data
  $client_data = socket_read($accept_socket, 1024) or die('Could not read data from client');

  echo "Message from client: $client_data";

  //write it to the server
  socket_write($accept_socket, $client_data, strlen($client_data)) or die('Could not write to the server');
}

socket_close($accept_socket);
socket_close($socket); 
?>