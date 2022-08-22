import 'package:intl/intl.dart';

class Message {
  Message(this.from, this.to, this.body, this.sendAt, this.direction);

  factory Message.fromJSON(Map<String, dynamic> json) {
    final from = json['from'].toString();
    final to = json['to'].toString();
    final body = json['body'].toString();
    final dateSent = (json['date_sent'] ?? json['date_created']).toString();
    final sendAt = DateFormat('dd MMM y HH:mm:ss').parse(
      ((dateSent.split(',')[1]).split('+')[0]).trim(),
    );
    final direction = json['direction'].toString();
    return Message(from, to, body, sendAt, direction);
  }

  final String from, to, body, direction;
  final DateTime sendAt;

  static List<Message> fromJSONList(List<dynamic> list) {
    final messages = <Message>[];
    for (final json in list) {
      messages.add(Message.fromJSON((json as Map).cast<String, dynamic>()));
    }
    return messages;
  }

  @override
  String toString() {
    return 'Message{from: $from, body: $body, direction: $direction}';
  }
}
