import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tesis_brainstate/components/NotesStreamPsicologo.dart';
import 'package:tesis_brainstate/components/NoteCard.dart';
import 'package:tesis_brainstate/models/Note.dart';
import 'package:tesis_brainstate/User/ui/screens/NoteScreen.dart';
import 'package:tesis_brainstate/User/model/User.dart';

const double kSmallMargin = 10.0;
const double kLargeMargin = 20.0;

class NotesScreenPsicologo extends StatefulWidget {
  User user = new User();
  NotesScreenPsicologo(this.user);
  //static final String routeName = '/';

  @override
  _NotesScreenStatePsicologo createState() => _NotesScreenStatePsicologo(this.user);

}

class _NotesScreenStatePsicologo extends State<NotesScreenPsicologo> {
  User user = new User();
  _NotesScreenStatePsicologo(this.user);

  final Firestore _firestore = Firestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: Text('Notas del paciente'),
      ),
      body: ListView(
        children: <Widget>[NotesStreamPsicologo(firestore: _firestore, user: this.user)],
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