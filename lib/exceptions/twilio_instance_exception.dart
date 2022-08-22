import 'package:twilio_dart/exceptions/twilio_exception.dart';

class TwilioInstanceException extends TwilioException {
  @override
  String toString() {
    return 'TwilioInstanceException{Please create Twilio instance then use it}';
  }
}
