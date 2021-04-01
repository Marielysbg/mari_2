import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tesis_brainstate/User/model/User.dart';
import 'package:fluttertoast/fluttertoast.dart';

class notificaciones_screen extends StatelessWidget{

    User user = new User();
    FirebaseUser userf;
    notificaciones_screen(this.user, this.userf);
    CollectionReference ref = Firestore.instance.collection('PSICOLOGOS');

    @override
    Widget build(BuildContext context) {
      // get the course document using a stream
      Stream<DocumentSnapshot> courseDocStream = Firestore.instance.collection('PSICOLOGOS').document(userf.uid).snapshots();
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          toolbarHeight: 70.0,
          title: Text('Solicitudes',
          style: TextStyle(
            color: Colors.white
          ),
          ),
          automaticallyImplyLeading: false,
          backgroundColor: Colors.indigo,
        ),
        body: StreamBuilder<DocumentSnapshot>(
            stream: courseDocStream,
            builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
              if(snapshot.data != null){
                var courseDocument = snapshot.data.data;
                // get sections from the document
                var sections = courseDocument['Solicitudes'];
                // build list using names from sections
                return ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: sections != null ? sections.length : 0,
                  itemBuilder: (_, int index) {
                    return Container(
                      margin: EdgeInsets.only(
                        top: 20.0
                      ),
                      child: GestureDetector(
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          elevation: 3,
                          child: Row(
                              children: [
                          FadeInImage(
                            image: NetworkImage(
                              //IMAGEN PRINCIPAL
                              sections[index]['fotoU']
                          ),
                          placeholder: AssetImage(
                              'assets/img/loading.gif'
                          ),
                          fit: BoxFit.cover,
                          height: 100.0,
                          width: 100.0,
                        ),
                                Container(
                                    padding: EdgeInsets.all(10),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          //TEXTO PRINCIPAL
                                          sections[index]['nombreU'],
                                          style: TextStyle(
                                            fontSize: 15.0,
                                            //fontWeight: FontWeight.bold
                                          ),
                                        ),
                                        Text(
                                          //TEXTO PRINCIPAL
                                          sections[index]['correoU'],
                                          style: TextStyle(
                                            fontSize: 10.0,
                                            //fontWeight: FontWeight.bold
                                          ),
                                        ),
                                      ],
                                    )
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                    left: 70.0
                                  ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    IconButton(
                                      icon: Icon(Icons.check,
                                        color: Colors.green,
                                      ),
                                      onPressed: () async{
                                        user.idA = sections[index]['solicitudU'];
                                        user.nombreA = sections[index]['nombreU'];
                                        user.correoA = sections[index]['correoU'];
                                        user.fotoA = sections[index]['fotoU'];

                                        //1. AÑADIR SOLICITUD ACEPTADA A MATRIZ "ACEPTADA" PSICOLOGO
                                        await ref.document(user.uid).updateData({
                                          'Aceptados': FieldValue.arrayUnion([{
                                            'aceptadoU': user.idA,
                                            'nombreU': user.nombreA,
                                            'correoU': user.correoA,
                                            'fotoU': user.fotoA
                                          }])
                                        }).then((value) async{
                                          //2. ELIMINAR SOLICITUD DE MATRIZ "SOLICITUD" PSICOLOGO
                                          await ref.document(user.uid).updateData({
                                            'Solicitudes': FieldValue.arrayRemove([{
                                              'solicitudU': user.idA,
                                              'nombreU': user.nombreA,
                                              'correoU': user.correoA,
                                              'fotoU': user.fotoA
                                            }])
                                          });
                                          DocumentReference ref2 = Firestore.instance.collection('PACIENTES').document(user.idA);
                                          //3. AÑADIR SOLICITUD ACEPTADA A VARIABLE ACEPTADA PACIENTE
                                          await ref2.updateData({
                                            'Aceptado': user.uid
                                          });
                                          //4. ELIMINAR SOLICITUD DE VARIABLE "SOLICITUD" PACIENTE
                                          await ref2.updateData({
                                            'Solicitud enviada': 'null'
                                          });
                                        });
                                      },
                                    ),
                                    IconButton(
                                      icon: Icon(Icons.delete,
                                        color: Colors.red),
                                      onPressed: () async{
                                        user.idA = sections[index]['solicitudU'];
                                        user.nombreA = sections[index]['nombreU'];
                                        user.correoA = sections[index]['correoU'];
                                        user.fotoA = sections[index]['fotoU'];

                                        DocumentReference ref2 = Firestore.instance.collection('PACIENTES').document(user.idA);
                                        //1. VOLVER "NULL" A SOLICITUD DE PACIENTE
                                        await ref2.updateData({
                                          'Solicitud enviada': 'null'
                                        }).then((value) async{
                                          //2. ELIMINAR SOLICITUD ENTRANTE A PSICOLOGO
                                          await ref.document(user.uid).updateData({
                                            'Solicitudes': FieldValue.arrayRemove([{
                                              'solicitudU': user.idA,
                                              'nombreU': user.nombreA,
                                              'correoU': user.correoA,
                                              'fotoU': user.fotoA
                                            }])
                                          });
                                          Fluttertoast.showToast(msg: 'Solicitud eliminada');
                                        });
                                      },
                                    ),
                                  ],
                                ),
                                ),
                        ]),
                      ),
                      )
                    );
                  },
                );
              } else{
                return Container();
              }
              return null;
            }),
      );
    }
  }
