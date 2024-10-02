import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketClient {
  IO.Socket? socket;
  static SocketClient? _instance;

  SocketClient._internal() {
    debugPrint("connecting...");
    socket = IO.io( 'http://192.168.29.168:8000/' /*'https://socket-room-2h7f.onrender.com'*/ /*"http://hotel.delristech-projects.in"*//*'http://localhost:5000'*/,
        <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
       });
    try{
      socket!.connect();
    }
    catch(e){
      debugPrint("connection error --> $e");
    }
    socket!.on("connection", (data){
      debugPrint("connected $socket");
    });
  }

  static SocketClient get instance {
    _instance ??= SocketClient._internal();
    return _instance!;
  }
}