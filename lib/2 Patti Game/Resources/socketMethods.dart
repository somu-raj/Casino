


import 'package:flutter/material.dart';
import 'package:roullet_app/2%20Patti%20Game/Controller/roomDataController.dart';
import 'package:roullet_app/2%20Patti%20Game/Models/do_patti_player.dart';
import 'package:roullet_app/2%20Patti%20Game/Resources/socketClient.dart';
import 'package:roullet_app/utils.dart';
import 'package:socket_io_client/socket_io_client.dart';

class SocketMethods {
  final _socketClient = SocketClient.instance.socket!;

  Socket get socketClient => _socketClient;

  // EMITS
  // void createRoom(String playerName) {
  //   if (playerName.isNotEmpty) {
  //     debugPrint("playerName --> playerName");
  //     _socketClient.emit('createRoom', {
  //       'playerName': playerName,
  //     });
  //   }
  // }

  void joinRoom(String playerName, String tableAmount, String userId, String userBalance) {
    debugPrint("user data --> $playerName $tableAmount $userId $userBalance");

    if (playerName.isNotEmpty && tableAmount != null) {
      _socketClient.emit('joinRoom', {
        'playerName': playerName,
        'tableAmount': tableAmount,
        "userId" : "fbdgr554sgrss",
        "balance" : userBalance,
      });
    }
  }

  void placeBet(DoPattiPlayer player, roomId) {
    if ((player.betAmount??0) > 0) {
      _socketClient.emit('betPlaced', {
        "player" : player,
        'roomId': roomId,
      });
    }
  }

  // LISTENERS
  setConnectListener(Function onConnect) {
    _socketClient.onConnect((data) {

      onConnect(data);
    });
  }

  setOnConnectionErrorListener(Function onConnectError) {
    _socketClient.onConnectError((data) {
      onConnectError(data);
    });
  }

  setOnConnectionErrorTimeOutListener(Function onConnectTimeout) {
    _socketClient.onConnectTimeout((data) {
      onConnectTimeout(data);
    });
  }

  setOnErrorListener(Function onError) {
    _socketClient.onError((error) {
      onError(error);
    });
  }

  setOnDisconnectListener(Function onDisconnect) {
    _socketClient.onDisconnect((data) {
      debugPrint("onDisconnect $data");
      onDisconnect(data);
    });
  }

  void joinRoomSuccessListener(RoomDataController controller) {
    _socketClient.on('joinRoomSuccess', (room) {
      debugPrint("room data --> $room");
      controller
          .updateRoomData(room);
    });
  }

  void errorOccuredListener(RoomDataController controller) {
    _socketClient.on('errorOccurred', (data) {
      Utils.mySnackBar(title: data["message"],);
    });
  }

  void updatePlayersStateListener(RoomDataController controller) {
    _socketClient.on('updatePlayers', (playerData) {

    });
  }

  void updateRoomListener(RoomDataController controller) {
    _socketClient.on('updateRoom', (data) {
      controller.updateRoomData(data);
    });
  }

  void turnChangeListener(RoomDataController controller) {
    _socketClient.on('turnChange', (data) {

    });
  }

  void updateRoomData(RoomDataController controller) {
    _socketClient.on('turnChange', (data) {

    });
  }

  void resetCards(){
     _socketClient.emit("reset",(data){

     });
  }

  //close connection
 void closeConnection() {
      debugPrint("Close Connection");
      _socketClient.close();
  }
}
