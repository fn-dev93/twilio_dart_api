library twilio;

import 'package:twilio_dart/models/credential.dart';
import 'package:twilio_dart/services/message_service.dart';
import 'package:twilio_dart/services/network_service.dart';

class Twilio {
  Twilio({
    required String accountSid,
    required String authToken,
    required String twilioNumber,
  }) {
    credential = Credential(accountSid, authToken, twilioNumber);
    messages = MessageService();
    NetworkService().init();
    instance = this;
  }

  late MessageService messages;
  late Credential credential;
  static Twilio? instance;
}
