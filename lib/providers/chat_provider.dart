
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatProvider {

  Stream<DocumentSnapshot> getMoney() {
    return FirebaseFirestore.instance.collection('money').doc('qR0EUHpQlxYoozuttNus').snapshots();
  }

  /*Stream<DocumentSnapshot> getRoomMessages() {
    return Firestore.instance
        .collection('messages')
        .where('users', arrayContains: userId)
        .snapshots();
  }

  String getConversationID(String userID, String peerID) {
    return userID.hashCode <= peerID.hashCode
        ? userID + '_' + peerID
        : peerID + '_' + userID;
  }*/

}