
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:my_message/models/message_model.dart';
import 'package:my_message/resources/strings.dart';
import 'package:my_message/utils/exception_utils.dart';
import 'package:my_message/utils/navigation_utils.dart';

class ChatProvider {

  static User? get currentUser => FirebaseAuth.instance.currentUser;

  static Stream<QuerySnapshot<Map<String, dynamic>>> getRoomsLastMessage() {
    return FirebaseFirestore.instance
      .collection(Strings.roomsCollection)
      .where(Strings.idsArrayFirestore, arrayContains: currentUser?.uid)
      .snapshots();
  }

  static Future<QuerySnapshot<Map<String, dynamic>>> getRoomFromSearch({required String peerId}) {
    List<String> _ids = sortIds(peerId);
    return FirebaseFirestore.instance
      .collection(Strings.roomsCollection)
      .where(Strings.idsArrayFirestore, isEqualTo: _ids)
      .get();
  }

  static Future<QuerySnapshot<Map<String, dynamic>>> getUsersFromId({required List<String> userIds}) {
    return FirebaseFirestore.instance
      .collection(Strings.usersCollection)
      .where(Strings.userModelId, whereIn: userIds)
      .get();
  }

  static Future<QuerySnapshot<Map<String, dynamic>>> getUsersFromName({required String query}) {
    return FirebaseFirestore.instance
      .collection(Strings.usersCollection)
      .limit(50)
      .where(
        Strings.userModelName,
        isGreaterThanOrEqualTo: query,
        isLessThan: query.substring(0, query.length-1) + String.fromCharCode(query.codeUnitAt(query.length - 1) + 1 ))
      .get();
  }

  static Stream<QuerySnapshot<dynamic>>? getRoomMessages({required String roomId}) {
    String _roomId = roomId;
    if(_roomId != "" ){
      return FirebaseFirestore.instance
          .collection(Strings.roomsCollection)
          .doc(_roomId)
          .collection(Strings.messagesCollection)
          .orderBy(Strings.messageModelTimestamp, descending: true)
          .snapshots();
    }
  }

  static Future<String?>? setMessage(BuildContext context, {required String peerId, required String message, required String? roomId}) async {
    List<String> _ids = sortIds(peerId);

    MessageModel _messageModel = MessageModel(
        textMessage: message,
        timeMessage: DateTime.now(),
        userId: currentUser?.uid ?? UniqueKey().toString()
    );

    //set the message
    DocumentReference<Map<String, dynamic>> _roomReference = await FirebaseFirestore.instance
      .collection(Strings.roomsCollection)
      .doc(roomId) //null to create new doc
      .collection(Strings.messagesCollection)
      .add(MessageModel.toMap(_messageModel)
    ).catchError((error, stackTrace) {
      ExceptionUtils.printCatchError(error: error, stackTrace: stackTrace);
      NavigationUtils.showMyDialog(
          context: context,
          bodyText: Strings.addMessageError
      );
    });
    String _roomId = _roomReference.parent.parent?.id ?? "";
    await FirebaseFirestore.instance
      .collection(Strings.roomsCollection)
      .doc(_roomId)
      .set({
      Strings.roomIdFirestore: _roomId,
      Strings.lastMessageFirestore: message,
      Strings.lastIdFirestore: _messageModel.userId,
      Strings.lastDateMessageFirestore: _messageModel.timeMessage,
      Strings.idsArrayFirestore: _ids,
    }).catchError((error, stackTrace) {
      ExceptionUtils.printCatchError(error: error, stackTrace: stackTrace);
      NavigationUtils.showMyDialog(
          context: context,
          bodyText: Strings.addMessageError
      );
    });
    return _roomId;
  }

    static List<String> sortIds(String peerId) {
     List<String> _ids = [];
      String _currentUser = currentUser?.uid ?? UniqueKey().toString();
      _ids..add(_currentUser)
          ..add(peerId);
      _ids.sort();
      return _ids;
  }

}