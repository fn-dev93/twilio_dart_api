# Twilio Dart

A Dart package which helps developers with Twilio API services.

## Features

* Send SMS programmatically;
* Get all SMS related to a Twilio account;


# Getting Started


Add the dependency to your pubspec.yaml file.

```yaml
dependencies:
  twilio_dart: ^0.0.1
```

## How to use


#### Create a new Object
```dart
Twilio twilio = Twilio(
    accountSid : '*************************', // replace *** with Account SID
    authToken : 'xxxxxxxxxxxxxxxxxx',  // replace xxx with Auth Token
    twilioNumber : '+...............'  // replace .... with Twilio Number
    );
```

#### Now you can use any instance of following
```dart
twilio.messages
twilio.credential
```

#### Send Message
```dart
twilio.messages.sendMessage(String toNumber, [String message = ""]); 
   //Use sendMessage with the recipient number and message body.
```

#### View Message List
```dart
//Returns list of SMS 
//pageSize defaults to 10
//Filter out numbers also

MessagesData messagesData = await twilio.getMessageList(
{int pageSize = 10, String? toNumber, String? fromNumber});
```


#### Change Twilio Number
```dart
twilio.credential.changeNumber('+.........'); // To change the twilio number
```


## Issues and feedback 💭

If you have any suggestion for including a feature or if something doesn't work, feel free to open a Github [issue](https://github.com/NazarenoCavazzon/AppSize/issues) for us to have a discussion on it.