import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:twilio_dart/twilio.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //Twilio Credentials
  final String accountSid = '';
  final String authToken = '';
  final String twilioNumber = '';

  late Twilio twilio;

  @override
  void initState() {
    super.initState();

    //Creating Twilio Object
    twilio = Twilio(
      accountSid: accountSid,
      authToken: authToken,
      twilioNumber: twilioNumber,
    );
  }

  //Send Message to another number from twilio number
  Future<void> sendMessage(String anotherNumber) async {
    final message = await twilio.messages.sendMessage(
      anotherNumber,
      "Hi There I'm using Twilio Package from coderthemes",
    );

    log(message?.body ?? 'Empty Body');
  }

  //Get all message for this number
  Future<void> getAllMessages() async {
    final message = await twilio.messages.getMessageList(
      pageSize: 20,
    );
    message?.messages.map((e) => log(e.body));
  }

  //Change twilio number
  Future<void> changeNumber(String number) async {
    twilio.credential.changeNumber(number);
    log('Your twilio number changed to $number');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
