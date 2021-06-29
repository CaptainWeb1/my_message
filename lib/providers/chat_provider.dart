
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_message/models/message_model.dart';
import 'package:my_message/models/room_model.dart';

class ChatProvider {

  User? get currentUser => FirebaseAuth.instance.currentUser;

  void setRoomMessages({required String peerId}) {
    RoomModel _room = RoomModel(
      currentUserId: FirebaseAuth.instance.currentUser?.uid ?? "no_user",
      peerUserId: peerId
    );
    FirebaseFirestore.instance.collection('rooms').add(
      RoomModel.toMap(_room)
    );
  }

  Stream<QuerySnapshot<dynamic>> getRoomMessages({required String peerId}) {
    return FirebaseFirestore.instance
        .collection('rooms')
        .where('users', arrayContains: peerId)
        .where('users', arrayContains: FirebaseAuth.instance.currentUser?.uid)
        .snapshots();
  }

  void setMessage({required String peerId, required String message}) {
    MessageModel _messageModel = MessageModel(
        textMessage: message,
        timeMessage: DateTime.now(),
        userId: FirebaseAuth.instance.currentUser?.uid ?? "no_user"
    );
    FirebaseFirestore.instance
        .collection('rooms')
        .add(MessageModel.toMap(_messageModel));
  }

}