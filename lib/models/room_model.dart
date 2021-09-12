
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_message/models/user_model.dart';
import 'package:my_message/resources/strings.dart';

class RoomModel {
  String? roomId;
  final List<String> userIds;
  final String? lastMessage;
  final String? lastId;
  final DateTime? lastDateMessage;
  UserModel? peerUser;

  RoomModel({
    required this.roomId,
    required this.userIds,
    this.lastMessage,
    this.lastId,
    this.lastDateMessage,
    this.peerUser
  });

  factory RoomModel.fromJson(Map<String, dynamic> jsonData) {
    return RoomModel(
      roomId: jsonData[Strings.roomIdFirestore] ?? "",
      userIds: jsonData[Strings.idsArrayFirestore].cast<String>() ?? ["",""],
      lastMessage: jsonData[Strings.lastMessageFirestore] ?? "",
      lastId: jsonData[Strings.lastIdFirestore] ?? "",
      lastDateMessage: jsonData[Strings.lastDateMessageFirestore].toDate() ?? DateTime.now(),
    );
  }

  static Map<String, dynamic> toMap(RoomModel roomModel) => {
    Strings.roomIdFirestore: roomModel.roomId,
    Strings.idsArrayFirestore: roomModel.userIds,
    Strings.lastMessageFirestore: roomModel.lastMessage,
    Strings.lastIdFirestore: roomModel.lastId,
    Strings.lastDateMessageFirestore: roomModel.lastDateMessage,
  };

  static String encodeRooms(List<RoomModel> rooms) {
    return json.encode(
        rooms.map(
          (room) => RoomModel.toMap(room)).toList()
    );
  }

  static List<RoomModel> decodeRooms(List<QueryDocumentSnapshot<dynamic>> queryRooms) {
    return queryRooms.map(
            (room) => RoomModel.fromJson(room.data())
    ).toList();
  }

}
