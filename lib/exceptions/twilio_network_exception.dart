import 'package:twilio_dart/exceptions/twilio_exception.dart';

class TwilioNetworkException extends TwilioException {
  const TwilioNetworkException(this.message);
  final String message;

  @override
  String toString() {
    return 'TwilioNetworkException{message: $message}';
  }
}
