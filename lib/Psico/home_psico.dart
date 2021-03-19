import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tesis_brainstate/User/ui/widgets/header_home_user.dart';
import 'package:tesis_brainstate/User/model/User.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class home_psico extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    // TODO: implement build


    final text = Container(
      margin: EdgeInsets.only(
          left: 20.0,
          bottom: 20.0,
          top: 20.0
      ),
      child: Text(
       'Histórico de pacientes',
        style: TextStyle(
            color: Colors.black,
            fontSize: 20.0,
            fontWeight: FontWeight.bold
        ),
      ),
    );

    final data =  StreamBuilder(
        stream: Firestore.instance.collection('PACIENTES').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
          if(snapshot.hasData && snapshot.data != null){
            //final docs = snapshot.data.docs;
            return ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: snapshot.data.documents.length,
                itemBuilder: (BuildContext context, int index){
                  var docs = snapshot.data.documents[index].data;
                  //final user = docs[index].data();
                  return ListTile(
                    title: Text(docs['nombre']),
                    subtitle: Text(docs['correo']),
                  );
                }
            );
          }
          return Container();
        }
    );

    return Container(
      child: ListView(
        children: [
          headerHomeUser('¡Bienvenido!', ''),
          text,
          data
        ],
      ),
    );
  }
}
