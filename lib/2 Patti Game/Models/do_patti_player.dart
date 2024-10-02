class DoPattiPlayer {
  final String? playerName;
  final String? socketID;
  final double? playerBalance;
  final double? betAmount;
  final String? userId;
  final bool? pack;
  final bool? show;

  DoPattiPlayer( {
    required this.playerName,
    required this.userId,
    required this.socketID,
    required this.playerBalance,
    required this.betAmount,
    required this.pack,
    required this.show,
  });

  Map<String, dynamic> toMap() {
    return {
      "userId" : userId,
      'playerName': playerName,
      'socketID': socketID,
      'playerBalance': playerBalance,
      'betAmount': betAmount,
      'pack': pack,
      'show': show,
    };
  }

  factory DoPattiPlayer.fromMap(Map<String, dynamic> map) {
    return DoPattiPlayer(
      playerName: map['nickname'],
      userId: map['userId'],
      socketID: map['socketID'],
      playerBalance: map['playerBalance']?.toDouble() ?? 0.0,
      betAmount: map['betAmount']?.toDouble()  ?? 0.0,
      pack: map['pack'],
      show: map['show'],
    );
  }

  DoPattiPlayer copyWith({
    String? playerName,
    String? userId,
    String? socketID,
    double? playerBalance,
    double? betAmount,
    bool? pack,
    bool? show,
  }) {
    return DoPattiPlayer(
      playerName: playerName ?? this.playerName,
      userId: userId ?? this.userId,
      socketID: socketID ?? this.socketID,
      playerBalance: playerBalance ?? this.playerBalance,
      betAmount: betAmount ?? this.betAmount,
      pack: pack ?? this.pack,
      show: show ?? this.show,
    );
  }
}
