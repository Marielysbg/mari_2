import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tesis_brainstate/User/model/User.dart';

class user_info_profile_psico extends StatelessWidget{

  User user = new User();
  user_info_profile_psico(this.user);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return StreamBuilder<DocumentSnapshot>(
      stream: Firestore.instance.collection('USUARIOS').document(user.uid).snapshots(),
      builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot){
        if(snapshot.hasError){
          return Text('Error:  ${snapshot.error}');
        }
        switch(snapshot.connectionState){
          case ConnectionState.waiting: return Text('Cargando...');
          default:
            return GestureDetector(
              child: Container(
                margin: EdgeInsets.only(
                    top: 70.0,
                    left: 20.0
                ),
                child: Row(
                  //mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 65.0,
                      child: ClipOval(
                        child: SizedBox(
                          width: 120.0,
                          height: 120.0,
                          child:
                          Image.network(
                            user.foto,
                            fit: BoxFit.cover,
                          ),

                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          left: 25.0,
                          top: 20.0
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            child: Text(
                              snapshot.data['nombre'],
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15.0
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                top: 5.0
                            ),
                            child: Text(
                              snapshot.data['correo'],
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15.0
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                top: 5.0
                            ),
                            child: Text(
                              snapshot.data['telf'],
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15.0
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                top: 5.0
                            ),
                            child: Text(
                              ('#' + snapshot.data['cuadroC']),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15.0
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                ]
                ),
              ),
            );
        }
      },
    );
  }
}