import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tesis_brainstate/models/chatMessageModel.dart';
import 'package:tesis_brainstate/User/model/User.dart';

class ChatStream extends StatelessWidget {
  final Firestore _firestore;
  User user = new User();

  ChatStream({firestore, this.user}) : _firestore = firestore;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _firestore.collection('chat').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return CircularProgressIndicator(
            backgroundColor: Colors.limeAccent,
          );
        }


        final chat_user = snapshot.data.documents.where((DocumentSnapshot document)=> document['user']['correo'] == this.user.email)
            .toList();
        //
        List<ChatMessage> messages = [];
        for (var chat in chat_user) {

          messages.add( ChatMessage(messageContent: chat.data['messageContent'] , messageType: chat.data['messageType'],
              timestamp: chat.data['timestamp']));
        }
        return Column(
          children: noteCards,
        );

      },
    );
  }
}