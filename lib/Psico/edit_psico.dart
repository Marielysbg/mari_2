import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tesis_brainstate/User/ui/screens/Login_Screen.dart';

class edit_psico extends StatelessWidget{

  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(
        child: RaisedButton(
          child: Text('Salir'),
          onPressed:() async{
            auth.signOut().whenComplete(() =>  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Login_Screen())));
          },
        ),
      ),
    );
  }

}
