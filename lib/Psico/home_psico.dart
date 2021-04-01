import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tesis_brainstate/User/ui/widgets/header_home_user.dart';
import 'package:tesis_brainstate/User/model/User.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class home_psico extends StatelessWidget{

  User user = new User();
  FirebaseUser userf;
  home_psico(this.user, this.userf);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    Stream<DocumentSnapshot> courseDocStream = Firestore.instance.collection('PSICOLOGOS').document(userf.uid).snapshots();

    final text = Container(
      margin: EdgeInsets.only(
          left: 20.0,
          bottom: 20.0,
          top: 20.0
      ),
      child: Text(
       'Histórico de pacientes',
        style: TextStyle(
            color: Colors.black,
            fontSize: 20.0,
            fontWeight: FontWeight.bold
        ),
      ),
    );

    final data = StreamBuilder<DocumentSnapshot>(
    stream: courseDocStream,
    builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
      if (snapshot.data != null) {
        print(snapshot.data);
        var courseDocument = snapshot.data.data;
        // get sections from the document
        var sections = courseDocument['Aceptados'];
        // build list using names from sections
        return Container(
            child: GridView.builder(
              physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            itemCount: sections != null ? sections.length : 0,
            itemBuilder: (_, int index) {
              return Container(
                child: Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                    margin: EdgeInsets.all(10),
                    elevation: 5,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: Column(
                        children: <Widget>[
                          FadeInImage(
                            // En esta propiedad colocamos la imagen a descargar
                            image: NetworkImage(
                              sections[index]['fotoU'],
                            ),
                            placeholder: AssetImage('assets/img/loading.gif'),
                            fit: BoxFit.cover,
                            // En esta propiedad colocamos el alto de nuestra imagen
                           height: 120.0,
                           // width: 300.0,
                          ),
                          Container(
                            padding: EdgeInsets.all(10),
                            child: Column(
                              children: [
                                Text(
                                  sections[index]['nombreU'],
                                ),
                                Text(
                                  sections[index]['correoU'],
                                )
                              ],
                            )
                          )
                        ],
                      ),
                    )
                ),
              );
            }
        )
        );
      } else{
        return Container();
      }
    }
    );


    return Container(
      child: ListView(
        children: [
          headerHomeUser('¡Bienvenido!', ''),
          text,
          data
        ],
      ),
    );
  }
}
