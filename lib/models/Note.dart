import 'package:flutter/cupertino.dart';
import 'package:tesis_brainstate/User/model/User.dart';

class Note {
  String id;
  String title;
  String note;
  Map<String, dynamic> user;

  Note({this.id, @required this.title, @required this.note, this.user ,});
}