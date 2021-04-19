import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tesis_brainstate/brainstate_trips.dart';
import 'package:tesis_brainstate/brainstate_trips_psico.dart';
import 'package:tesis_brainstate/User/model/User.dart';
import 'package:tesis_brainstate/admin/home_admin.dart';
import 'package:tesis_brainstate/Psico/verificado.dart';
import 'package:tesis_brainstate/User/ui/screens/Login_Screen.dart';

class ruta_rol extends StatelessWidget{

  ruta_rol(this.user);
  final User userr = new User();
  final FirebaseUser user;
  final auth = FirebaseAuth.instance;

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
              return CheckRole(snapshot.data, context);
          }
        },
      ),
    );
  }

  CheckRole(DocumentSnapshot snapshot, context){

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

    if(snapshot.data['rol'] == "Psicologo"){
      userr.rol = snapshot.data['rol'];
      userr.name = snapshot.data['nombre'];
      userr.email = snapshot.data['correo'];
      userr.telf = snapshot.data['telf'];
      userr.foto = snapshot.data['foto'];
      userr.des = snapshot.data['descripcion'];
      userr.dir = snapshot.data['direccion'];
      //userr.verificado = snapshot.data['verificado'];
      return verificado(user, userr);
      //return brainstate_trips_psico(user, userr);
    } else if (snapshot.data['rol'] == "Paciente"){
      userr.name = snapshot.data['nombre'];
      userr.email = snapshot.data['correo'];
      userr.telf = snapshot.data['telf'];
      userr.foto = snapshot.data['foto'];
      userr.soli = snapshot.data['Solicitud enviada'];
      userr.aceptado = snapshot.data['Aceptado'];
      userr.verificado = snapshot.data['verificado'];
      String a = snapshot.data['verificado'];
      if (userr.verificado == 'eliminado'){
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
      }
      return home_trips(userr);
    } else if (snapshot.data['rol'] == "admin"){
      return home_admin(userr);
    }
  }
}