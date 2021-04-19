import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tesis_brainstate/Psico/update_comprobante.dart';
import 'package:tesis_brainstate/User/model/User.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tesis_brainstate/brainstate_trips_psico.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tesis_brainstate/User/ui/screens/Login_Screen.dart';

class verificado extends StatelessWidget{

  User userr = new User();
  FirebaseUser user;
  verificado(this.user, this.userr);
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build




    return Scaffold(
      body: StreamBuilder<DocumentSnapshot>(
        stream: Firestore.instance.collection('PSICOLOGOS').document(user.uid).snapshots(),
        builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot){
          if(snapshot.hasError){
            return Text('Error:  ${snapshot.error}');
          }
          switch(snapshot.connectionState){
            case ConnectionState.waiting: return Text('Cargando...');
            default:
              return CheckVerificado(snapshot.data, context);
          }
        },
      ),
    );
  }

  CheckVerificado(DocumentSnapshot snapshot, context){

    void _showAlertDialog() {
      showDialog(
          context: context,
          builder: (buildcontext) {
            return AlertDialog(
              title: Text("¿Desea salir de la aplicación?"),
              content: Text("Presione cancelar para volver"),
              actions: <Widget>[
                FlatButton(
                  child:
                  Text("Cancelar",
                    style: TextStyle(
                        color: Colors.blue
                    ),
                  ),
                  onPressed: (){ Navigator.of(context).pop(); },
                ),
                FlatButton(
                  child:
                  Text("Salir",
                    style: TextStyle(
                        color: Colors.blue
                    ),
                  ),
                  onPressed: (){ auth.signOut().whenComplete(() =>  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => Login_Screen()))); },
                ),
              ],
            );
          }
      );
    }

    userr.uid = snapshot.data['uid'];

    if(snapshot.data['verificado'] == 'none'){
      return Container(
          padding: EdgeInsets.only(
              top: 100.0,
              left: 35.0
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 200.0,
                width: 200.0,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage('https://blush.design/api/download?shareUri=kJTUYQFtl&w=800&h=800&fm=png')
                    )
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                    top: 30.0
                ),
                child: Text(
                  'Su cuenta está en verificación',
                  style: TextStyle(
                      color: Color(0xFF212121),
                      fontSize: 17.0,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                    top: 5.0
                ),
                child: Text(
                  '¡El proceso no demorará nada!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Color(0xFFBDBDBD),
                      fontSize: 15.0,
                      fontWeight: FontWeight.w900
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                    top: 50.0
                ),
                width: 300.0,
                height: 50.0,
                child: RaisedButton(
                  child: Text('Salir',
                    style: TextStyle(
                        fontSize: 16.0
                    ),
                  ),
                  elevation: 5.0,
                  color: Colors.indigo,
                  textColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0)
                  ),
                  onPressed: (){
                    _showAlertDialog();
                  },
                ),
              ),
            ],
          )
      );
    } else if(snapshot.data['verificado'] == 'rechazado'){
      return update_comprobante(user, userr);
    }else if (snapshot.data['verificado'] == 'eliminado') {
      return Container(
        padding: EdgeInsets.only(
          top: 100.0,
          left: 35.0
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 200.0,
              width: 200.0,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage('https://blush.design/api/download?shareUri=mcja3zvoC&w=800&h=800&fm=png')
                )
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                top: 30.0
              ),
              child: Text(
                'Su cuenta ha sido eliminada',
                style: TextStyle(
                  color: Color(0xFF212121),
                  fontSize: 17.0,
                  fontWeight: FontWeight.bold
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                  top: 5.0
              ),
              child: Text(
                  'Contáctate con soporte si crees que es un error\nadmin@correo.com',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Color(0xFFBDBDBD),
                    fontSize: 15.0,
                    fontWeight: FontWeight.w900
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                  top: 50.0
              ),
              width: 300.0,
              height: 50.0,
              child: RaisedButton(
                child: Text('Salir',
                  style: TextStyle(
                      fontSize: 16.0
                  ),
                ),
                elevation: 5.0,
                color: Colors.indigo,
                textColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0)
                ),
                onPressed: (){
                  _showAlertDialog();
                },
              ),
            ),
          ],
        )
      );
    }else {
      userr.direccion = snapshot.data['direccion'];
      userr.descripcion = snapshot.data['descripcion'];
      return brainstate_trips_psico(user, userr);
    }
  }
}