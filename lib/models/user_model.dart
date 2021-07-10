
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_message/resources/strings.dart';

class UserModel {
  final String? userId;
  final String? userName;
  final String? imagePath;

  UserModel({
    required this.userId,
    required this.userName,
    required this.imagePath}
    );

  factory UserModel.fromJson(Map<String, dynamic> jsonData) {
    return UserModel(
      userId: jsonData[Strings.userModelId],
      userName: jsonData[Strings.userModelName],
      imagePath: jsonData[Strings.userModelImagePath],
    );
  }

  static Map<String, dynamic> toMap(UserModel userModel) => {
    Strings.userModelId: userModel.userId,
    Strings.userModelName: userModel.userName,
    Strings.userModelImagePath: userModel.imagePath,
  };

  static String encodeUsers(List<UserModel?> users) {
    return json.encode(
      users.map((user) => UserModel.toMap(user!)).toList()
    );
  }

  static List<UserModel?> decodeUsers(List<QueryDocumentSnapshot<dynamic>> queryUsers) {
    return queryUsers.map(
      (e) => UserModel.fromJson(e.data())
    ).toList();
  }
}


/*
'text': '',
'text_0': 'Bonjour Florian, comment…',
'text': 'Micheline',
'text_0': 'Bonne année',
'text': 'Brigitte Bardot',
'text_0': 'La pêche mec, dis moi j’ai…',
'text': 'Nekfeu',
'text_0': 'Oui les spaghettis c’est…',
'text': 'Inconnu',
'text_0': 'Je suis un inconnu',
},
*/

