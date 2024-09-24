import 'package:scholar_chat/widget/constant.dart';

class Message {
  final String message;
  final String id;
  final String time;
  // final String name;

  Message(this.message, this.id, this.time);

  factory Message.formJson(jsonData) {
    return Message(
      jsonData[kMessage] ?? '',
      jsonData['id'] ?? '',
      jsonData['message_time'] ?? '',
    );
  }
}
