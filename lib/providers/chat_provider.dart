
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_message/models/message_model.dart';
import 'package:my_message/models/room_model.dart';
import 'package:my_message/resources/strings.dart';

class ChatProvider {

  static User? get currentUser => FirebaseAuth.instance.currentUser;

  static void setRoomMessages({required String peerId}) {
    RoomModel _room = RoomModel(
      currentUserId: FirebaseAuth.instance.currentUser?.uid ?? "no_user",
      peerUserId: peerId
    );
    FirebaseFirestore.instance.collection(Strings.roomsCollection).add(
      RoomModel.toMap(_room)
    );
  }

  static Stream<QuerySnapshot<dynamic>> getRoomMessages({required String peerId}) {
    List<String> _ids = _sortIds(peerId);

   return FirebaseFirestore.instance
        .collection(Strings.roomsCollection)
        .doc(_ids[0]+":"+_ids[1])
        .collection(Strings.messagesCollection)
        .orderBy(Strings.messageModelTimestamp)
        .snapshots();
  }

  static void setMessage({required String peerId, required String message}) {
    List<String> _ids = _sortIds(peerId);

    MessageModel _messageModel = MessageModel(
        textMessage: message,
        timeMessage: DateTime.now(),
        userId: FirebaseAuth.instance.currentUser?.uid ?? UniqueKey().toString()
    );
    FirebaseFirestore.instance
        .collection(Strings.roomsCollection)
        .doc(_ids[0]+":"+_ids[1])
        .collection(Strings.messagesCollection)
        .add(MessageModel.toMap(_messageModel));
  }

  static Future<QuerySnapshot<Map<String, dynamic>>> getUsers({required String query}) {

    return FirebaseFirestore.instance
        .collection(Strings.usersCollection)
        .limit(50)
        .where(
          'userName',
          isGreaterThanOrEqualTo: query,
          isLessThan: query.substring(0, query.length-1) + String.fromCharCode(query.codeUnitAt(query.length - 1) + 1))
        .get();
  }

  static List<String> _sortIds(String peerId) {
    List<String> _ids = [];
    String _currentUser = FirebaseAuth.instance.currentUser?.uid ?? UniqueKey().toString();
    _ids..add(_currentUser)
      ..add(peerId);
    _ids.sort();
    return _ids;
  }


}