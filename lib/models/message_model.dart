
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
        textMessage: jsonData["textMessage"],
        timeMessage: jsonData["timestamp"],
        userId: jsonData["userId"],
    );
  }

  static Map<String, dynamic> toMap(MessageModel roomModel) => {
    "textMessage": roomModel.textMessage,
    "timestamp": roomModel.timeMessage,
    "userId": roomModel.userId,
  };

}