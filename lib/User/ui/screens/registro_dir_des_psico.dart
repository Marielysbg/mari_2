import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tesis_brainstate/User/model/User.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tesis_brainstate/brainstate_trips_psico.dart';
import 'package:firebase_auth/firebase_auth.dart';

class registro_dir_des_psico extends StatelessWidget{

 User user = new User();
 registro_dir_des_psico(this.userf, this.user);
 FirebaseUser userf;

  TextEditingController dir = TextEditingController();
  TextEditingController des = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        body: SingleChildScrollView(
          child: GestureDetector(
            child: Container(
              margin: EdgeInsets.only(
                top: 20.0,
              ),
              child: Column(
                children: [
                  Container(
                      margin: EdgeInsets.only(
                          top: 20.0,
                          left: 20.0,
                          right: 20.0,
                          bottom: 20.0
                      ),
                      child: Center(
                        child: Text(
                          'Completa tu perfil',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0
                          ),
                        ),
                      )
                  ),
                  Row(
                    children: [
                      Container(
                        height: 150.0,
                        width: 120.0,
                        margin: EdgeInsets.only(
                            left: 20.0,
                            top: 20.0
                        ),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            image: DecorationImage(
                                image: NetworkImage(user.foto),
                                fit: BoxFit.cover
                            )
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            left: 20.0,
                            top: 15.0
                        ),
                        child:  Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.only(
                                  bottom: 5.0
                              ),
                              child: Text(
                                user.name,
                                style: TextStyle(
                                    fontSize: 25.0,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                            ),
                            Text(
                              user.email,
                              style: TextStyle(
                                fontSize: 15.0,
                                color: Colors.black45,

                              ),
                            ),
                            Container(
                                margin: EdgeInsets.only(
                                    top: 60.0
                                ),
                                width: 200.0,
                                height: 40.0,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    color: Colors.indigo
                                ),
                                child: Center(
                                  child: Text(
                                    'Psicólogo',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 17.0
                                    ),
                                  ),
                                )
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        top: 40.0,
                        left: 25.0,
                        bottom: 15.0,
                        right: 25.0
                    ),
                    child: Text(
                      'Agrega una dirección donde tus pacientes puedan ubicarte',
                      style: TextStyle(
                          color: Colors.black54,
                          fontSize: 15.0
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        left: 20.0,
                        right: 20.0,
                        bottom: 20.0
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.only(
                            right: 5.0,
                          ),
                          child: Icon(
                            Icons.add_location,
                            color: Colors.indigo,
                          ),
                        ),
                        Flexible(
                            child: TextField(
                              maxLines: null,
                              controller: dir,
                              autofocus: false,
                              decoration: InputDecoration(
                                  hintText: "Dirección",
                                  fillColor: Colors.indigo,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(25.0),
                                      borderSide: BorderSide(
                                          color: Colors.indigo
                                      )
                                  ),
                                  hintStyle: TextStyle(fontSize: 15.0)),
                            )),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        top: 10.0,
                        left: 25.0,
                        bottom: 15.0,
                        right: 25.0
                    ),
                    child: Text(
                      '¡Haz que tus pacientes conozcan un poco más sobre ti!',
                      style: TextStyle(
                          color: Colors.black54,
                          fontSize: 15.0
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        right: 20.0,
                        left: 20.0
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.only(
                              right: 5.0
                          ),
                          child: Icon(
                            Icons.person,
                            color: Colors.indigo,
                          ),
                        ),
                        Flexible(
                            child: TextField(
                              maxLines: null,
                              controller: des,
                              autofocus: false,
                              decoration: InputDecoration(
                                  hintText: "Breve descripción sobre ti",
                                  fillColor: Colors.indigo,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(25.0),
                                      borderSide: BorderSide(
                                          color: Colors.indigo
                                      )
                                  ),
                                  hintStyle: TextStyle(fontSize: 15.0)),
                            )),
                      ],
                    ),
                  ),
                  Center(
                    child: Container(
                      width: 330.0,
                      height: 45.0,
                      margin: EdgeInsets.only(
                          top: 150.0,
                          bottom: 30.0
                      ),
                      child: RaisedButton(
                        onPressed: () async {

                          FocusScope.of(context).requestFocus(new FocusNode());
                          if(dir.text == '' && des.text == ''){
                            Fluttertoast.showToast(msg: 'Debe llenar el formulario antes de continuar');
                          } else{
                            user.des = des.text;
                            user.dir = dir.text;
                            buildShowDialog(context);
                            CollectionReference ref = Firestore.instance.collection('USUARIOS');
                            CollectionReference pac = Firestore.instance.collection('PSICOLOGOS');
                            await pac.document(user.uid).updateData({
                              'direccion': user.dir,
                              'descripcion': user.des
                            }).then((value) async{
                              await ref.document(user.uid).updateData({
                                'direccion': user.dir,
                                'descripcion': user.des
                              });
                              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => brainstate_trips_psico(userf, user)));
                              Fluttertoast.showToast(msg: 'Registro exitoso');
                            });
                          }
                        },
                        color: Colors.indigo,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            side: BorderSide(color: Colors.indigo)
                        ),
                        child: Text('Continuar',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 17.0
                          ),
                        ),
                      ),
                    ),
                  ),

                ],
                crossAxisAlignment: CrossAxisAlignment.start,
              ),
            ),
            onTap: (){
              FocusScope.of(context).requestFocus(new FocusNode());
            },
          )
        )
    ) ;
  }

 buildShowDialog(BuildContext context) {
   return showDialog(
       context: context,
       barrierDismissible: false,
       builder: (BuildContext context) {
         return Center(
           child: CircularProgressIndicator(),
         );
       });
 }
}