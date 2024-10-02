

import 'package:get/get.dart';
import 'package:roullet_app/2%20Patti%20Game/Models/do_patti_player.dart';
import 'package:roullet_app/Api%20Services/requests.dart';

import '../../Screens/Model/get_profile_model.dart';

class RoomDataController extends GetxController{

  RxMap<String, dynamic> _roomData = <String, dynamic>{}.obs;

  RxList<DoPattiPlayer> _players = <DoPattiPlayer>[].obs;

  DoPattiPlayer _player1 = DoPattiPlayer(
  playerName: '',
  socketID: '',
  playerBalance: 0,
  betAmount: 0,
    show: false,
    pack: false,
    userId: '',
  );

  DoPattiPlayer _player2 = DoPattiPlayer(
    playerName: '',
    socketID: '',
    playerBalance: 0,
    betAmount: 0,
    show: false,
    pack: false,
    userId: '',
  );

  DoPattiPlayer _player3 = DoPattiPlayer(
    playerName: '',
    socketID: '',
    playerBalance: 0,
    betAmount: 0,
    show: false,
    pack: false,
    userId: '',
  );

  DoPattiPlayer _player4 = DoPattiPlayer(
    playerName: '',
    socketID: '',
    playerBalance: 0,
    betAmount: 0,
    show: false,
    pack: false,
    userId: '',
  );

  RxMap<String, dynamic> get roomData => _roomData;
  RxList<DoPattiPlayer> get players => _players;
  DoPattiPlayer get player1 => _player1;
  DoPattiPlayer get player2 => _player2;
  DoPattiPlayer get player3 => _player3;
  DoPattiPlayer get player4 => _player4;

  void updateRoomData(Map<String, dynamic> data) {
  _roomData.value = data;
  }

  // void updatePlayers(data){
  //   players = DoPattiPlayer.fromMap(data);
  //
  // }

  void updatePlayer1(Map<String, dynamic> player1Data) {
  _player1 = DoPattiPlayer.fromMap(player1Data);
  }

  void updatePlayer2(Map<String, dynamic> player2Data) {
  _player2 = DoPattiPlayer.fromMap(player2Data);
  }

  void updatePlayer3(Map<String, dynamic> player3Data) {
    _player3 = DoPattiPlayer.fromMap(player3Data);
  }

  void updatePlayer4(Map<String, dynamic> player4Data) {
    _player4 = DoPattiPlayer.fromMap(player4Data);
  }

  void updateDisplayElements(int index, String choice) {

  }

  void resetCards() {

  }


  GetProfileModel? getProfileModel;
  Future<GetProfileModel?> getProfileData() async {
    GetProfileModel? getProfileData = await ApiRequests().getProfile();
    return getProfileData;
  }

}