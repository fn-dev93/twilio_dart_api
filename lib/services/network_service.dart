import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:twilio_dart/exceptions/twilio_network_exception.dart';
import 'package:twilio_dart/models/credential.dart';

class NetworkResponse {
  NetworkResponse(this._body, this._statusCode, this._baseResponse) {
    _body = body;
    _statusCode = statusCode;
    _baseResponse = baseResponse;
  }

  late String _body;
  late int _statusCode;
  late http.Response _baseResponse;

  int get statusCode => _statusCode;

  String get body => _body;

  http.Response get baseResponse => _baseResponse;

  @override
  String toString() {
    return '''
    NetworkResponse{
      _body: $_body,
      _statusCode: $_statusCode,
      _baseResponse: $_baseResponse
    }
    ''';
  }
}

class NetworkService {
  NetworkService();
  static late NetworkService instance;

  static const String _baseUri = 'https://api.twilio.com';
  static const String _version = '2010-04-01';

  late String url;
  late Map<String, String> headers;

  void init() {
    instance = this;
    final credential = Credential.instance;
    url = '$_baseUri/$_version/Accounts/${credential.accountSid}/Messages.json';

    initHeader();
  }

  //Headers
  void initHeader() {
    final credential = Credential.instance.cred;
    final bytes = utf8.encode(credential);
    final base64Str = base64.encode(bytes);
    headers = {
      'Authorization': 'Basic $base64Str',
      'Accept': 'application/json'
    };
  }

  Future<NetworkResponse?> get(String url) async {
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: headers,
      );
      return NetworkResponse(response.body, response.statusCode, response);
    } catch (e) {
      throw TwilioNetworkException(e.toString());
    }
  }

  Future<NetworkResponse?> post(
    String url, [
    Map<String, dynamic>? body,
  ]) async {
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: body,
      );

      return NetworkResponse(response.body, response.statusCode, response);
    } catch (e) {
      throw TwilioNetworkException(e.toString());
    }
  }
}
