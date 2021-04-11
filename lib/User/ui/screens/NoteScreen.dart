import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tesis_brainstate/models/Note.dart';
import 'package:tesis_brainstate/User/ui/screens/NoteScreen.dart';
import 'package:tesis_brainstate/User/model/User.dart';

const double kSmallMargin = 10.0;
const double kLargeMargin = 20.0;

class NoteScreen extends StatefulWidget {

  User user = new User();
  Note note = new Note();

  NoteScreen(this.user, this.note);




  @override
  _NoteScreenState createState() => _NoteScreenState(this.user, this.note);
}

class _NoteScreenState extends State<NoteScreen> {
  User user = new User();
  Note note = new Note();
  _NoteScreenState(this.user, this.note);

  String titleString = '';
  String noteString = '';

  Firestore _firestore = Firestore.instance;

  TextEditingController controllerTitle;
  TextEditingController controllerNote;
  TextEditingController controllerUser;
  TextEditingController controllerID;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    note = widget.note;
    if (note != null) {
      titleString = note.title;
      noteString = note.note;
    }

    controllerTitle = TextEditingController(text: note != null ? note.title : '');
    controllerNote = TextEditingController(text: note != null ? note.note : '');
    controllerUser = TextEditingController(text: note != null ? note.user : '');
    controllerID = TextEditingController(text: note != null ? note.id : '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        //title: Text(
       // note != null ? 'Edit note' : 'Add note',
      //),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.save,
              color: Colors.white,
            ),
            onPressed: () {
              saveClicked();
              Navigator.pop(context);
            },
          ),
          IconButton(
            icon: Icon(
              Icons.delete,
              color: Colors.white,
            ),
            onPressed: () {
              _firestore.collection('notes').document(note.id).delete();
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: kSmallMargin),
            child: TextField(
              controller: controllerTitle,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                hintText: 'Titulo',
              ),
              onChanged: (value) {
                titleString = value;
              },
            ),
          ),
          SizedBox(
            height: kSmallMargin,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(kLargeMargin),
              child: TextField(
                controller: controllerNote,
                maxLines: null,
                expands: true,
                decoration: InputDecoration(hintText: 'Descripción'),
                onChanged: (value) {
                  noteString = value;
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  void saveClicked() {

    if (titleString.isEmpty || noteString.isEmpty ) return;


    if (note == null) {
      _firestore
          .collection('notes').add({'title': titleString, 'note': noteString, 'user': this.user.toJsonPaciente(),
      });
    } else {
      _firestore
          .collection('notes')
          .document(note.id)
          .updateData({'title': titleString, 'note': noteString,  });
    }
  }
}