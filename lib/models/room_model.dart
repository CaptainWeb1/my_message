
import 'package:my_message/models/message_model.dart';

class RoomModel {

  final String peerUserId;
  final String currentUserId;
  List<MessageModel>? messages;

  RoomModel({
    required this.currentUserId,
    required this.peerUserId
  });

  factory RoomModel.fromJson(Map<String, dynamic> jsonData) {
    return RoomModel(
      peerUserId: jsonData["peerUserId"],
      currentUserId: jsonData["currentUserId"]
    );
  }

  static Map<String, dynamic> toMap(RoomModel roomModel) => {
    "peerUserId" : roomModel.peerUserId,
    "currentUserId": roomModel.currentUserId
  };

}