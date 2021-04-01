import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tesis_brainstate/User/model/User.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_switch/flutter_switch.dart';

class consejos_paciente extends StatelessWidget{

  User user = new User();
  consejos_paciente(this.user);
  String mensaje;
  String hora;
  CollectionReference ref = Firestore.instance.collection('PSICOLOGOS');

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    Stream<DocumentSnapshot> courseDocStream = Firestore.instance.collection('PSICOLOGOS').document(user.aceptado).snapshots();

    return Scaffold(
      body: StreamBuilder<DocumentSnapshot>(
          stream: courseDocStream,
          builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if(snapshot.data != null){
              var courseDocument = snapshot.data.data;
              // get sections from the document
              var sections = courseDocument['Mensajes'];
              // build list using names from sections
              return ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: sections != null ? sections.length : 0,
                itemBuilder: (_, int index) {
                  return Container(
                    //padding: EdgeInsets.only(left: 15.0, right: 15.0, top: 30.0),
                    // margin: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: GestureDetector(
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.only(
                                  top: 15.0,
                                  left: 20.0,
                                ),
                                child:Text(
                                  sections[index]['hora'],
                                  style: TextStyle(
                                      color: Colors.indigo
                                  ),
                                ) ,
                              ),
                              Row(
                                children: <Widget>[
                                  Container(
                                    height: 50.0,
                                    width: 50.0,
                                    margin: EdgeInsets.only(
                                        left: 20.0,
                                      bottom: 5.0
                                    ),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(180),
                                        image: DecorationImage(
                                            image: NetworkImage(snapshot.data['foto']),
                                            fit: BoxFit.cover
                                        )
                                    ),
                                  ),
                                  Expanded(
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            left: 5.0,
                                            right: 20.0,
                                        ),
                                        child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(10.0),
                                              color: Colors.white70,
                                              boxShadow:  [
                                                BoxShadow(
                                                  color: Colors.grey.withOpacity(0.2),
                                                  spreadRadius: 5,
                                                  blurRadius: 5,
                                                  offset: Offset(0, 3), // changes position of shadow
                                                ),
                                              ],
                                            ),
                                            child: Padding(
                                              padding: EdgeInsets.all(10.0),
                                              child: Text(sections[index]['mensaje'],
                                                textAlign: TextAlign.start,
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 20,
                                                style: TextStyle(
                                                    color: Colors.black87,
                                                    fontSize: 17.0
                                                ),
                                              ),
                                            )
                                        ),
                                      )
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
                    ),
                  );
                },
              );
            } else{
              return Container();
            }
            return null;
          }
      ),
    );

  }

}
