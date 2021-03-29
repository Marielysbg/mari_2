import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tesis_brainstate/components/NotesStream.dart';
import 'package:tesis_brainstate/components/NoteCard.dart';
import 'package:tesis_brainstate/models/Note.dart';
import 'package:tesis_brainstate/User/ui/screens/NoteScreen.dart';
import 'package:tesis_brainstate/User/model/User.dart';

const double kSmallMargin = 10.0;
const double kLargeMargin = 20.0;

class NotesScreen extends StatefulWidget {
  User user = new User();
  NotesScreen(this.user);
  //static final String routeName = '/';

  @override
  _NotesScreenState createState() => _NotesScreenState(this.user);

}

class _NotesScreenState extends State<NotesScreen> {
  User user = new User();
  _NotesScreenState(this.user);

  final Firestore _firestore = Firestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: Text('Diario Personal'),
      ),
      body: ListView(
        children: <Widget>[NotesStream(firestore: _firestore, user: this.user)],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {

          Navigator.push(context, MaterialPageRoute(builder: (context) => NoteScreen(this.user, null)));

        },
        backgroundColor: Colors.indigo,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}