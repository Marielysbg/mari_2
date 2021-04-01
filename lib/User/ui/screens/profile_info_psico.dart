import 'package:flutter/material.dart';
import 'package:tesis_brainstate/User/model/User.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class profile_info_psico extends StatelessWidget{


  User user = new User();
  profile_info_psico(this.user);
  CollectionReference ref = Firestore.instance.collection('PSICOLOGOS');
  CollectionReference ref2 = Firestore.instance.collection('PACIENTES');


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: StreamBuilder<DocumentSnapshot>(
        stream: Firestore.instance.collection('PSICOLOGOS').document(user.idA).snapshots(),
        builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot){
          if(snapshot.hasError){
            return Text('Error:  ${snapshot.error}');
          }
          switch(snapshot.connectionState){
            case ConnectionState.waiting: return Text('Esperando...');
            default:
              return Stack(
                children: [
                  Container(
                    width:  MediaQuery.of(context).size.width,
                    height: 230.0,
                    color: Colors.indigo,
                    child: IconButton(
                      icon: Icon(Icons.arrow_back),
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                        child: IconButton(
                          icon: Icon(Icons.arrow_back),
                          onPressed: (){
                            Navigator.pop(context);
                          },
                          color: Colors.white,
                        ),
                      ),
                      Container(
                        child: Text('Perfil',
                          style: TextStyle(
                            fontSize: 30.0,
                            color: Colors.white
                          ),
                        ),
                      )
                    ],
                  ),

                  Center(
                    child: Container(
                        margin: EdgeInsets.only(
                            top: 90.0
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              height: 200.0,
                              width: 200.0,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(180.0),
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(user.fotoA)
                                  )
                              ),
                            ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.only(
                                  top: 20.0,
                                  bottom: 5.0
                              ),
                              child: ListTile(
                                title: Text(
                                  user.nombreA,
                                  style: TextStyle(
                                    fontSize: 20.0,
                                  ),
                                ),
                                leading: Icon(Icons.person),
                              )
                            ),
                            ListTile(
                              title: Text(
                                user.correoA,
                                style: TextStyle(
                                    fontSize: 20.0,
                                ),
                              ),
                              leading: Icon(Icons.email),
                            ),
                            ListTile(
                              title: Text(
                                user.telfA,
                                style: TextStyle(
                                    fontSize: 20.0,
                                ),
                              ),
                              leading: Icon(Icons.phone),
                            )
                          ]),
                        Container(
                            margin: EdgeInsets.only(
                                top: 160.0
                            ),
                            width: 180.0,
                            height: 50.0,
                            child: RaisedButton(
                              elevation: 5.0,
                              color: Colors.white,
                              textColor: Colors.indigo,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                  side: BorderSide(color: Colors.indigo)
                              ),
                              child: Text('Enviar solicitud'),
                               onPressed: () async{
                                print(user.idA);
                                print(user.uid);
                                await ref2.document(user.uid).updateData({
                                  'Solicitud enviada': user.idA
                                }).whenComplete(() async {
                                  await ref.document(user.idA).updateData({
                                    'Solicitudes': FieldValue.arrayUnion([{
                                      'solicitudU': user.uid,
                                      'nombreU': user.name,
                                      'correoU': user.email,
                                      'fotoU': user.foto
                                    }])
                                  });
                                  Navigator.pop(context);
                                });
                                },
                            ),
                        )
                        ])
                  ),
                        )
              ]);
          }
        },
      ),
    );
  }
}

