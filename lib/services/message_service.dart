import 'dart:convert';
import 'dart:io';
import 'package:twilio_dart/exceptions/message_failed_exception.dart';
import 'package:twilio_dart/models/credential.dart';
import 'package:twilio_dart/models/message.dart';
import 'package:twilio_dart/models/messages_data.dart';
import 'package:twilio_dart/services/network_service.dart';

/// This is the enum that manage the status from TwilioAPI
/// Only missing delivery_unknown due to the fact that it is not important.
enum TwilioStatus {
  queued,
  accepted,
  scheduled,
  sending,
  sent,
  delivered,
  undelivered,
  failed,
}

class MessageService {
  static const int successCodeStart = 200;
  static const int successCodeEnd = 299;

  TwilioStatus _getStatusFromResponse(String status) {
    return TwilioStatus.values.firstWhere(
      (element) => element.name == status,
    );
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

      final status = _getStatusFromResponse(responseMap['status'].toString());

      if (status == TwilioStatus.failed || status == TwilioStatus.undelivered) {
        throw MessageFailedException(
          HttpStatus.badRequest,
          responseMap['message'].toString(),
        );
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
      'Body': message,
    };

    final response = await NetworkService.instance.post(url, body);

    if (response != null) {
      final responseMap = json.decode(response.body) as Map<String, dynamic>;

      final status = _getStatusFromResponse(responseMap['status'].toString());

      if (status == TwilioStatus.failed || status == TwilioStatus.undelivered) {
        throw MessageFailedException(
          HttpStatus.badRequest,
          responseMap['message'].toString(),
        );
      }

      final message = Message.fromJSON(responseMap);

      return message;
    } else {
      throw Exception('Response is null');
    }
  }
}
