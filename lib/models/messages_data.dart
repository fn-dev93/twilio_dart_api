import 'package:twilio_dart/models/message.dart';

class MessagesData {
  const MessagesData(this.messages);

  factory MessagesData.fromJSON(Map<String, dynamic> json) {
    final messages = Message.fromJSONList(json['messages'] as List);
    return MessagesData(messages);
  }

  final List<Message> messages;

  @override
  String toString() {
    return 'MessagesData{messages: $messages}';
  }
}
