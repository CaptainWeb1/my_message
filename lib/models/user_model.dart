
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
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
      imagePath: jsonData[Strings.userModelImagePath]
    );
  }

  static Map<String, dynamic> toMap(UserModel userModel) => {
    Strings.userModelId: userModel.userId,
    Strings.userModelName: userModel.userName,
    Strings.userModelImagePath: userModel.imagePath
  };

  static String encodeUsers(List<UserModel?> users) {  //List<UserModel?>> => { "users": {"user1", {}, "user2 }
    return json.encode(
      users.map(
        (user) => UserModel.toMap(user!)).toList()
    );
  }

  static List<UserModel?> decodeUsers(List<QueryDocumentSnapshot<dynamic>> queryUsers) {
    return queryUsers.map(
            (user) => UserModel.fromJson(user.data())
    ).toList();
  }
}



Map<int, UserModel> users = {
   0 : UserModel(
    userId: UniqueKey().toString(),
    userName: "Jean-Michel",
    imagePath: "assets/images/user_images/Jean-Michel.png"
  ),
  1 : UserModel(
      userId: UniqueKey().toString(),
      userName: "Micheline",
      imagePath: "assets/images/user_images/Micheline.png"
  ),
  2 : UserModel(
      userId: UniqueKey().toString(),
      userName: "Brigitte Bardot",
      imagePath: "assets/images/user_images/Brigitte Bardot.png"
  ),
  3 : UserModel(
      userId: UniqueKey().toString(),
      userName: "Nekfeu",
      imagePath: "assets/images/user_images/Nekfeu.png"
  ),
  4 : UserModel(
      userId: UniqueKey().toString(),
      userName: "Inconnu",
      imagePath: "assets/images/user_images/Inconnu.png"
  )
};


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

