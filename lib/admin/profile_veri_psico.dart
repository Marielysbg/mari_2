import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pinch_zoom_image_last/pinch_zoom_image_last.dart';
import 'package:tesis_brainstate/User/model/User.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class profile_veri_psico extends StatelessWidget{

  User user = new User();
 profile_veri_psico(this.user);
  CollectionReference ver = Firestore.instance.collection('VERIFICACION');

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70.0,
        backgroundColor: Colors.indigo,
        title: Text('Perfil',
        style: TextStyle(
          color: Colors.white
        ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back,
          color: Colors.white,
          ),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(
              top: 30.0,
              left: 20.0
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(

                children: [
                  Container(
                    height: 140.0,
                    width: 120.0,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        image: DecorationImage(
                            image: NetworkImage(user.fotoA),
                            fit: BoxFit.cover
                        )
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        left: 20.0
                    ),
                    child:  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                              bottom: 5.0
                          ),
                          child: Text(
                            user.nombreA,
                            style: TextStyle(
                                fontSize: 25.0,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                        Text(
                          user.correoA,
                          style: TextStyle(
                            fontSize: 15.0,
                            color: Colors.black45,

                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              top: 48.0
                          ),
                          width: 200.0,
                          height: 40.0,
                          child:  RaisedButton(
                            shape:  RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0),
                                side: BorderSide(color: Colors.indigo)
                            ),
                            color: Colors.indigo,
                            onPressed: (){

                            },
                            child: Text('Solicitud',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 17.0
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.only(
                  top: 60.0
                ),
                child: Text(
                  'Comprobante',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17.0
                  ),
                ),
              ),
             Center(
               child: Container(
                 margin: EdgeInsets.only(
                   top: 20.0,
                   right: 17.0
                 ),

                 child: PinchZoomImage(
                   image: ClipRRect(
                     borderRadius: BorderRadius.all(Radius.circular(10)),
                     child: Image.network(
                       user.titulo,
                       width: 340.0,
                       height: 200.0,
                       fit: BoxFit.cover,
                     ),
                   ),
                   hideStatusBarWhileZooming: true,
                 ),
               ),
             ),
            Container(
              margin: EdgeInsets.only(
                top: 130.0
              ),
              child:   Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    child: CircleAvatar(
                      radius: 30.0,
                      backgroundColor: Color(0xFF303F9F),
                      child: IconButton(
                        icon: Icon(Icons.check,
                          color: Colors.white,
                          size: 30.0,
                        ),
                        onPressed: () async {

                          showDialog(
                              context: context,
                              builder: (buildcontext) {
                                return AlertDialog(
                                  title: Text("¿Seguro de que desea aceptar al psicólogo?"),
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
                                      Text("Aceptar",
                                        style: TextStyle(
                                            color: Colors.blue
                                        ),
                                      ),
                                      onPressed: ()async{
                                        DocumentReference psi = Firestore.instance.collection('PSICOLOGOS').document(user.idA);
                                        DocumentReference usu = Firestore.instance.collection('USUARIOS').document(user.idA);
                                        //1. Eliminar documento de VERIFICACION
                                        await ver.document(user.idA).delete().whenComplete(() async {
                                          //2. Actualizar verificado (psico) a verificado
                                          await psi.updateData({
                                            'verificado' : 'verificado'
                                          });
                                          //3. Actualizar verificado (usuario) a verificado
                                          await usu.updateData({
                                            'verificado' : 'verificado'
                                          });
                                          Fluttertoast.showToast(msg: 'Psicologo aceptado');
                                          Navigator.pop(context);
                                        });
                                      },
                                    ),
                                  ],
                                );
                              }
                          );
                        },
                      ),
                    ),
                  ),
                  CircleAvatar(
                    backgroundColor: Color(0xFFFF5252),
                    radius: 30.0,
                    child: IconButton(
                      icon: Icon(Icons.delete,
                        color: Colors.white,
                      ),
                      onPressed: () async {

                        showDialog(
                            context: context,
                            builder: (buildcontext) {
                              return AlertDialog(
                                title: Text("¿Seguro de que desea rechazar al psicólogo?"),
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
                                    Text("Eliminar",
                                      style: TextStyle(
                                          color: Colors.blue
                                      ),
                                    ),
                                    onPressed: ()async{
                                      DocumentReference psi = Firestore.instance.collection('PSICOLOGOS').document(user.idA);
                                      DocumentReference usu = Firestore.instance.collection('USUARIOS').document(user.idA);
                                      DocumentReference verf = Firestore.instance.collection('VERIFICACION').document(user.idA);
                                      //1. Actualizar titulo a NULL
                                      await verf.updateData({
                                        'titulo': null
                                      }).whenComplete(() async {
                                        //2. Actualizar verificado (psico) a rechazado
                                        await psi.updateData({
                                          'verificado' : 'rechazado'
                                        });
                                        //3. Actualizar verificado (usuario) a rechazado
                                        await usu.updateData({
                                          'verificado' : 'rechazado'
                                        });
                                      });
                                    },
                                  ),
                                ],
                              );
                            }
                        );
                      },
                    ),
                  ),
                ],
              ),
            )
            ],
          ),
        ),
      )
    );
  }
}