import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tesis_brainstate/brainstate_trips.dart';
import 'package:tesis_brainstate/brainstate_trips_psico.dart';
import 'package:tesis_brainstate/User/model/User.dart';

class ruta_rol extends StatelessWidget{

  ruta_rol(this.user);
  final User userr = new User();
  final FirebaseUser user;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: StreamBuilder<DocumentSnapshot>(
        stream: Firestore.instance.collection('USUARIOS').document(user.uid).snapshots(),
        builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot){
          if(snapshot.hasError){
            return Text('Error:  ${snapshot.error}');
          }
          switch(snapshot.connectionState){
            case ConnectionState.waiting: return Text('Cargando...');
            default:
              return CheckRole(snapshot.data);
          }
        },
      ),
    );
  }

  CheckRole(DocumentSnapshot snapshot){
    userr.name = snapshot.data['nombre'];
    userr.email = snapshot.data['correo'];
    userr.telf = snapshot.data['telf'];

    if(snapshot.data['rol'] == "Psicologo"){
      return brainstate_trips_psico(user, userr);
    } else{
      return home_trips(userr);
    }
  }
}