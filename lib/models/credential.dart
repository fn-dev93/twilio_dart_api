import 'package:twilio_dart/exceptions/twilio_credential_exception.dart';

class Credential {
  Credential(String accountSid, String authToken, String twilioNumber) {
    _accountSid = accountSid;
    _authToken = authToken;

    if (isValidNumber(twilioNumber)) {
      throw TwilioCredentialException('$twilioNumber is not valid number');
    }

    _twilioNumber = twilioNumber;
    _cred = '$_accountSid:$_authToken';
    instance = this;
  }

  late final String _accountSid, _authToken;
  late String _twilioNumber, _cred;
  static late Credential instance;
  final regExp = RegExp(r'^\+[1-9]\d{1,14}$');

  String get accountSid => _accountSid;

  bool isValidNumber(String number) => regExp.hasMatch(number);

  void changeNumber(String number) {
    if (isValidNumber(number)) {
      throw TwilioCredentialException('$number is not valid number');
    }

    _twilioNumber = number;
  }

  String get authToken => _authToken;

  String get twilioNumber => _twilioNumber;

  String get cred => _cred;
}
