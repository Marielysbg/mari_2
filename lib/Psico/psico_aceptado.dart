import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tesis_brainstate/User/model/User.dart';
import 'package:tesis_brainstate/User/ui/screens/mensajes_ui.dart';

class psico_aceptado extends StatelessWidget{

  User user = new User();
  psico_aceptado(this.user);


  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back,
          color: Colors.indigo,
          size: 30.0,
          ),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        toolbarHeight: 70.0,
        title: Text('Mi psicologo',
        style: TextStyle(
          color: Colors.black
        ),
        ),
        backgroundColor: Colors.white,
        elevation: 5.0,
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: Firestore.instance.collection('PSICOLOGOS').document(user.aceptado).snapshots(),
        builder: (BuildContext context,
            AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Error:  ${snapshot.error}');
          }
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Text('Cargando...');
            default:
              return Container(
                margin: EdgeInsets.only(
                  top: 30.0,
                  left: 20.0
                ),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 140.0,
                          width: 120.0,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                              image: DecorationImage(
                                  image: NetworkImage(snapshot.data['foto']),
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
                                      snapshot.data['nombre'],
                                      style: TextStyle(
                                          fontSize: 25.0,
                                          fontWeight: FontWeight.bold
                                      ),
                                    ),
                                  ),
                                Text(
                                  snapshot.data['correo'],
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
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => mensajes_ui(user)),);
                                    },
                                    child: Text('Ver mensajes',
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
                        top: 40.0,
                        right: 20.0
                      ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30.0),
                                border: Border.all(
                                  color: Colors.indigo
                                )
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(15.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      child: Text(
                                        'Sobre mi',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20.0
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(
                                          top: 10.0
                                      ),
                                      child: Text(
                                        snapshot.data['descripcion'],
                                        textAlign: TextAlign.justify,
                                        style: TextStyle(
                                            fontSize: 17.0,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                top: 20.0
                              ),
                              child: Text(
                                'Datos personales',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.0
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                top: 20.0,
                                bottom: 20.0
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                      Icons.add_location,
                                    size: 30.0,
                                    color: Colors.indigo,
                                  ),
                                  Expanded(
                                    child: Container(
                                      margin: EdgeInsets.only(
                                        left: 10.0
                                      ),
                                      child: Text(
                                        snapshot.data['direccion'],
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 20,
                                        textAlign: TextAlign.justify,
                                        style: TextStyle(
                                            fontSize: 17.0,
                                            color: Colors.black45
                                        ),
                                      ),
                                    )
                                  ),
                                ],
                              ),
                            ),
                           Row(
                             children: [
                               Icon(
                                 Icons.phone,
                                 size: 30.0,
                                 color: Colors.indigo,
                               ),
                               Container(
                                 margin: EdgeInsets.only(
                                     left: 10.0
                                 ),
                                 child:Text(
                                   snapshot.data['telf'],
                                   style: TextStyle(
                                       fontSize: 17.0,
                                       color: Colors.black45
                                   ),
                                 ),
                               ),
                             ],
                           )
                          ],
                        )
                    )
                  ],
                )
              );
          }
        },
      ),
    );
  }

}