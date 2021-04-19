import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tesis_brainstate/User/model/Resena_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tesis_brainstate/User/model/User.dart';
import 'package:fluttertoast/fluttertoast.dart';

class resena_completa_psico extends StatelessWidget{

  Resena_model resena = new Resena_model();
  User user = new User();
  resena_completa_psico(this.resena, this.user);

  @override


  Widget build(BuildContext context) {

    String clave = resena.clave;

    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () async {
                showDialog(
                    context: context,
                    builder: (buildcontext) {
                      return AlertDialog(
                        title: Text("¿Desea eliminar la reseña?"),
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
                            onPressed: () async {
                              DocumentReference ref2 = Firestore.instance.collection('PSICOLOGOS').document(user.uid);
                              await ref2.updateData({
                                'resena': FieldValue.arrayRemove([{
                                  'clave': resena.clave,
                                  'description': resena.descripcion,
                                  'fecha': resena.fecha,
                                  'foto': resena.foto,
                                  'hora': resena.hora,
                                  'psico': resena.psico,
                                  'title': resena.title
                                }])
                              }).whenComplete(() async {
                                DocumentReference ref = Firestore.instance.collection('RESENA').document('resena');
                                await ref.updateData({
                                  'resena': FieldValue.arrayRemove([{
                                    'clave': resena.clave,
                                    'description': resena.descripcion,
                                    'fecha': resena.fecha,
                                    'foto': resena.foto,
                                    'hora': resena.hora,
                                    'psico': resena.psico,
                                    'title': resena.title
                                  }])
                                });
                                Navigator.pop(context);
                                Fluttertoast.showToast(msg: 'Eliminado con éxito');
                              });
                              Navigator.pop(context);
                              },
                          ),
                        ],
                      );
                    }
                );
              },
            )
          ],
          backgroundColor: Colors.indigo,
          title: Text('Reseña'),
          centerTitle: true,
          toolbarHeight: 70.0,
          leading: IconButton(
            onPressed: (){
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(
                    top: 30.0,
                    left: 20.0
                ),
                child: Row(
                  children: [
                    Container(
                      height: 90.0,
                      width: 90.0,
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(resena.foto),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                              left: 10.0
                          ),
                          child: Text(resena.psico,
                            style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(5.0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              border: Border.all(color: Colors.indigo,
                                  width: 2.0
                              )
                          ),
                          margin: EdgeInsets.only(
                              top: 5.0,
                              left: 10.0
                          ),
                          child: Text(
                            '#$clave',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                                fontSize: 17.0
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Center(
                child: Container(
                  margin: EdgeInsets.only(
                    top: 20.0,
                  ),
                  child: Text(
                    resena.title,
                    maxLines: null,
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                    top: 30.0,
                    left: 30.0,
                    right: 30.0
                ),
                padding: EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                    border: Border(
                        left: BorderSide(
                            color: Colors.indigo,
                            width: 3.0
                        )
                    )
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      child: Text(
                        resena.descripcion,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 17.0,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          left: 10.0,
                          top: 5.0
                      ),
                      child: Text(resena.fecha,
                        style: TextStyle(
                            fontSize: 13.0,
                            fontWeight: FontWeight.w600,
                            color: Colors.black45
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        )
    );
  }

}