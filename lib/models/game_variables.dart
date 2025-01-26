class OpponentPlayerData {
  final String playerName;
  final String id;
  final String type;
  OpponentPlayerData(
      {required this.playerName, required this.id, required this.type});
}

OpponentPlayerData opponentPlayerData =
    OpponentPlayerData(playerName: "CPU", id: "CPU", type: "CPU");
String opponentID = "";
String roomId = "";
String createdBy = "";
String joinedBy = "";
String currentUser = "";
