import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tesis_brainstate/User/ui/screens/resena_completo.dart';
import 'package:tesis_brainstate/User/model/Resena_model.dart';
import 'package:tesis_brainstate/User/model/User.dart';

class screen_relajate extends StatelessWidget {

  User user = new User();
  screen_relajate(this.user);

  Stream<DocumentSnapshot> courseDocStream = Firestore.instance.collection(
      'RESENA').document('resena').snapshots();

  Resena_model resena = new Resena_model();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 70.0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          backgroundColor: Colors.indigo,
          title: Text('Reseñas',
            style: TextStyle(
                color: Colors.white
            ),
          ),
          centerTitle: true,
        ),
        body: StreamBuilder<DocumentSnapshot>(
            stream: courseDocStream,
            builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (snapshot.data != null) {
                var courseDocument = snapshot.data.data;
                // get sections from the document
                var sections = courseDocument['resena'];
                return ListView.builder(
                    itemCount: sections != null ? sections.length : 0,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                          onTap: () {
                            resena.clave = sections[index]['clave'];
                            resena.title = sections[index]['title'];
                            resena.psico = sections[index]['psico'];
                            resena.hora = sections[index]['hora'];
                            resena.fecha = sections[index]['fecha'];
                            resena.foto = sections[index]['foto'];
                            resena.descripcion = sections[index]['description'];
                            Navigator.push(context, MaterialPageRoute(builder: (context) => resena_completo(resena)));
                          },
                          child: Container(
                            padding: EdgeInsets.all(20.0),
                           child: Material(
                                 elevation: 3.0,
                                 child: Container(
                                   margin: EdgeInsets.only(
                                       left: 10.0
                                   ),
                                   decoration: BoxDecoration(
                                     color: Colors.white70,
                                     borderRadius: BorderRadius.circular(10.0),
                                    ),
                                   padding: EdgeInsets.all(20.0),
                                   //height: 150.0,
                                   //width: 250.0,
                                   child: Row(
                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                     children: [
                                       Column(
                                         crossAxisAlignment: CrossAxisAlignment.start,
                                         children: [
                                           FittedBox(
                                             fit: BoxFit.fill,
                                             child:  Container(
                                               width: 250.0,
                                               margin: EdgeInsets.only(
                                                   right: 10.0
                                               ),
                                               child: Text(
                                                 sections[index]['title'],
                                                 maxLines: null,
                                                 style: TextStyle(
                                                     color: Colors.black,
                                                     fontSize: 17.0,
                                                   fontWeight: FontWeight.bold
                                                 ),
                                               ),
                                             ),
                                           ),
                                           Container(
                                             margin: EdgeInsets.only(
                                                 top: 10.0
                                             ),
                                             child: Text(
                                               sections[index]['psico'],
                                               style: TextStyle(
                                                   color: Colors.black,
                                                   fontSize: 15.0
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
                                                 top: 10.0
                                             ),
                                             child: Text(
                                               sections[index]['clave'],
                                               style: TextStyle(
                                                   color: Colors.black,
                                                   fontWeight: FontWeight.w600
                                               ),
                                             ),
                                           ),
                                           Container(
                                             margin: EdgeInsets.only(
                                                 top: 10.0
                                             ),
                                             child: Text(
                                               sections[index]['fecha'] + " " + sections[index]['hora'],
                                               style: TextStyle(
                                                 color: Colors.black,
                                               ),
                                             ),
                                           )
                                         ],
                                       ),
                                     ],
                                   )
                                 ),
                               ),
                          )
                      );
                    }
                );
              } else {
                return Container();
              }
            }
        )
    );
  }

}