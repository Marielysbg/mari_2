import 'package:flutter/material.dart';

import 'package:tesis_brainstate/models/Note.dart';

const double kSmallMargin = 10.0;
const double kLargeMargin = 20.0;

class NoteCard extends StatelessWidget {
  final Note note;
  final Function onPressed;

  NoteCard({this.note, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: kLargeMargin, vertical: kSmallMargin),
        child: ListTile(
          title: Text(note.title),
          subtitle: Text(note.note),
        ),
      ),
    );
  }
}