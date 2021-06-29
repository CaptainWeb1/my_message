
import 'package:flutter/cupertino.dart';

class UserModel {
  final UniqueKey? uniqueKey;
  final String? userName;
  final String? imagePath;

  UserModel({
    required this.uniqueKey,
    required this.userName,
    required this.imagePath}
    );
}

List<UserModel> users = [
   UserModel(
    uniqueKey: UniqueKey(),
    userName: "Jean-Michel",
    imagePath: "assets/images/user_images/Jean-Michel.png"
  ),
  UserModel(
      uniqueKey: UniqueKey(),
      userName: "Micheline",
      imagePath: "assets/images/user_images/Micheline.png"
  ),
  UserModel(
      uniqueKey: UniqueKey(),
      userName: "Brigitte Bardot",
      imagePath: "assets/images/user_images/Brigitte Bardot.png"
  ),
  UserModel(
      uniqueKey: UniqueKey(),
      userName: "Nekfeu",
      imagePath: "assets/images/user_images/Nekfeu.png"
  ),
  UserModel(
      uniqueKey: UniqueKey(),
      userName: "Inconnu",
      imagePath: "assets/images/user_images/Inconnu.png"
  )
];


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

