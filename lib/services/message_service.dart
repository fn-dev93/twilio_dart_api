import 'dart:convert';
import 'package:twilio_dart/exceptions/message_failed_exception.dart';
import 'package:twilio_dart/models/credential.dart';
import 'package:twilio_dart/models/message.dart';
import 'package:twilio_dart/models/messages_data.dart';
import 'package:twilio_dart/services/network_service.dart';

class MessageService {
  static const int successCodeStart = 200;
  static const int successCodeEnd = 299;

  static bool statusInSuccess(int status) {
    return status >= successCodeStart && status <= successCodeEnd;
  }

  Future<MessagesData?> getMessageList({
    int pageSize = 10,
    String? toNumber,
    String? fromNumber,
  }) async {
    var url = '${NetworkService.instance.url}?PageSize=$pageSize';
    if (fromNumber != null) {
      url += '&From=$fromNumber';
    }
    if (toNumber != null) {
      url += '&To=$toNumber';
    }
    final response = await NetworkService.instance.get(url);
    if (response != null) {
      final responseMap = json.decode(response.body) as Map<String, dynamic>;

      final status = int.tryParse(responseMap['status'].toString());
      if (status != null && statusInSuccess(status)) {
        throw MessageFailedException(status, responseMap['message'].toString());
      }

      final messagesData = MessagesData.fromJSON(responseMap);

      return messagesData;
    } else {
      throw Exception('Response is null');
    }
  }

  Future<Message?> sendMessage(String toNumber, [String message = '']) async {
    final url = NetworkService.instance.url;

    final body = <String, String>{
      'From': Credential.instance.twilioNumber,
      'To': toNumber,
      'Body': message
    };
    final response = await NetworkService.instance.post(url, body);
    if (response != null) {
      final responseMap = json.decode(response.body) as Map<String, dynamic>;

      final status = int.tryParse(responseMap['status'].toString());
      if (status != null && statusInSuccess(status)) {
        throw MessageFailedException(status, responseMap['message'].toString());
      }

      final message = Message.fromJSON(responseMap);
      return message;
    } else {
      throw Exception('Response is null');
    }
  }
}
