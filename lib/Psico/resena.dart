import 'package:flutter/material.dart';
import 'package:tesis_brainstate/Psico/formulario_resena.dart';
import 'package:tesis_brainstate/Psico/resena_completa_psico.dart';
import 'package:tesis_brainstate/User/model/User.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tesis_brainstate/User/model/Resena_model.dart';

class resena extends StatelessWidget{

  User user = new User();
  resena(this.user);
  Resena_model resena_model = new Resena_model();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    Stream<DocumentSnapshot> courseDocStream = Firestore.instance.collection('PSICOLOGOS').document(user.uid).snapshots();
    return Scaffold(
      appBar: AppBar(
        title: Text('Reseña'),
        centerTitle: true,
        toolbarHeight: 70.0,
        backgroundColor: Colors.indigo,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => formulario_resena(user)));
        },
        backgroundColor: Colors.indigo,
        mini: false,
        tooltip: "Fav",
        child: Icon(
           Icons.add
        ),
        heroTag: null,
      ),
      body: StreamBuilder<DocumentSnapshot>(
          stream: courseDocStream,
          builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if(snapshot.data != null){
              var courseDocument = snapshot.data.data;
              // get sections from the document
              var sections = courseDocument['resena'];
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
                        onTap: (){
                          resena_model.clave = sections[index]['clave'];
                          resena_model.title = sections[index]['title'];
                          resena_model.psico = sections[index]['psico'];
                          resena_model.hora = sections[index]['hora'];
                          resena_model.fecha = sections[index]['fecha'];
                          resena_model.foto = sections[index]['foto'];
                          resena_model.descripcion = sections[index]['description'];
                          Navigator.push(context, MaterialPageRoute(builder: (context) => resena_completa_psico(resena_model, user)));
                        },
                        child: Container(
                          margin: EdgeInsets.only(
                            left: 20.0,
                            right: 20.0
                          ),
                          child: Material(
                            elevation: 5.0,
                            child: ListTile(
                                title: Text(sections[index]['title']),
                                subtitle: Container(
                                  margin: EdgeInsets.only(
                                      top: 15.0
                                  ),
                                  child: Text(sections[index]['fecha'] + " " + sections[index]['hora']),
                                ),
                                trailing: Icon(
                                    Icons.arrow_forward_ios
                                )
                            ),
                          )
                        )
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