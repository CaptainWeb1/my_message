
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_message/resources/strings.dart';

class ChatProvider {

  static Future<QuerySnapshot<Map<String, dynamic>>> getUsers({required String query}) {
    return FirebaseFirestore.instance
      .collection(Strings.usersCollection)
      .limit(50)
      .where(
        Strings.userModelName,
        isEqualTo: "nom"
      )
      .get();
  }

}