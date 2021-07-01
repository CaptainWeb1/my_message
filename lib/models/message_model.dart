
import 'package:my_message/resources/strings.dart';

class MessageModel {
  final String textMessage;
  final DateTime timeMessage;
  final String userId;

  MessageModel({
    required this.textMessage,
    required this.timeMessage,
    required this.userId
  });

  factory MessageModel.fromJson(Map<String, dynamic> jsonData) {
    return MessageModel(
        textMessage: jsonData[Strings.messageModelTextMessage],
        timeMessage: jsonData[Strings.messageModelTimestamp],
        userId: jsonData[Strings.messageModelUserId],
    );
  }

  static Map<String, dynamic> toMap(MessageModel roomModel) => {
    Strings.messageModelTextMessage: roomModel.textMessage,
    Strings.messageModelTimestamp: roomModel.timeMessage,
    Strings.messageModelUserId: roomModel.userId,
  };

}