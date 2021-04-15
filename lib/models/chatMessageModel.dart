import 'package:flutter/cupertino.dart';

class ChatMessage{
  String messageContent;
  String messageType;
  int timestamp;
  Map<String, dynamic> user;

  ChatMessage({@required this.messageContent, @required this.messageType,  @required this.user , this.timestamp});
}


