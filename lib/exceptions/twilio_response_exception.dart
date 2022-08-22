import 'package:twilio_dart/exceptions/twilio_network_exception.dart';

class TwilioResponseException extends TwilioNetworkException {
  const TwilioResponseException(this.status, String message) : super(message);

  final int status;

  @override
  String toString() {
    return 'TwilioResponseException{status: $status, message: $message}';
  }
}
