import 'package:twilio_dart/exceptions/twilio_exception.dart';

class TwilioCredentialException extends TwilioException {
  const TwilioCredentialException(this.message);

  final String message;

  @override
  String toString() {
    return 'TwilioCredentialException{message: $message}';
  }
}
