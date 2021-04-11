import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tesis_brainstate/components/NoteCard.dart';
import 'package:tesis_brainstate/models/Note.dart';
import 'package:tesis_brainstate/User/ui/screens/NoteScreen.dart';
import 'package:tesis_brainstate/User/model/User.dart';

class NotesStreamPsicologo extends StatelessWidget {
  final Firestore _firestore;
  User user = new User();

  NotesStreamPsicologo({firestore, this.user}) : _firestore = firestore;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _firestore.collection('notes').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return CircularProgressIndicator(
            backgroundColor: Colors.limeAccent,
          );
        }


        final notes = snapshot.data.documents
            .where((DocumentSnapshot document)=> document['user']['correo'] == this.user.email)
            .where((DocumentSnapshot document)=> document['user']['paciente'] == this.user.idA)
            .toList();
        //
        List<NoteCard> noteCards = [];
        for (var note in notes) {
          Note noteObject =
          Note(id: note.documentID, title: note.data['title'], note: note.data['note']);
          noteCards.add(NoteCard(
            note: noteObject,
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => NoteScreen(this.user, noteObject)));

            },
          ));
        }

        return Column(
          children: noteCards,
        );
      },
    );
  }
}