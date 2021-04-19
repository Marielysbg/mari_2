import 'package:flutter/material.dart';
import 'package:tesis_brainstate/User/model/User.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tesis_brainstate/Psico/perfil_paciente_touch.dart';

class List_pacientes extends StatelessWidget{

  User user = new User();
  List_pacientes(this.user);
  CollectionReference ref = Firestore.instance.collection('PSICOLOGOS');

  @override
  Widget build(BuildContext context) {
    // TODO: implement build


    Stream<DocumentSnapshot> courseDocStream = Firestore.instance.collection('PSICOLOGOS').document(user.uid).snapshots();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 70.0,
        title: Text('Pacientes'),
        backgroundColor: Colors.indigo,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        automaticallyImplyLeading: false,
      ),
      body: StreamBuilder<DocumentSnapshot>(
          stream: courseDocStream,
          builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if(snapshot.data != null){
              var courseDocument = snapshot.data.data;
              // get sections from the document
              var sections = courseDocument['Aceptados'];
              // build list using names from sections
              return ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: sections != null ? sections.length : 0,
                itemBuilder: (_, int index) {
                  return Container(
                      child: GestureDetector(
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          elevation: 3,
                          child: Row(
                              children: [
                                FadeInImage(
                                  image: NetworkImage(
                                    //IMAGEN PRINCIPAL
                                      sections[index]['fotoU']
                                  ),
                                  placeholder: AssetImage(
                                      'assets/img/loading.gif'
                                  ),
                                  fit: BoxFit.cover,
                                  height: 100.0,
                                  width: 100.0,
                                ),
                                Container(
                                    padding: EdgeInsets.all(10),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          //TEXTO PRINCIPAL
                                          sections[index]['nombreU'],
                                          style: TextStyle(
                                            fontSize: 17.0,
                                            //fontWeight: FontWeight.bold
                                          ),
                                        ),
                                        Text(
                                          //TEXTO PRINCIPAL
                                          sections[index]['correoU'],
                                          style: TextStyle(
                                            fontSize: 15.0,
                                            color: Colors.black54
                                            //fontWeight: FontWeight.bold
                                          ),
                                        ),
                                      ],
                                    )
                                ),
                                Expanded(
                                  child:  Container(
                                    margin: EdgeInsets.only(
                                        left: 70.0
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        IconButton(
                                          icon: Icon(Icons.delete,
                                              color: Colors.red),

                                          onPressed: ()  async{
                                            user.idA = sections[index]['aceptadoU'];
                                            user.nombreA = sections[index]['nombreU'];
                                            user.correoA = sections[index]['correoU'];
                                            user.fotoA = sections[index]['fotoU'];
                                            String name = user.nombreA;
                                            showDialog(
                                                context: context,
                                                builder: (buildcontext) {
                                                  return AlertDialog(
                                                    title: Text("¿Desea eliminar paciente ?"),
                                                    content: Text("Está por eliminar a $name presione cancelar para volver"),
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
                                                        onPressed: () async{
                                                          user.idA = sections[index]['aceptadoU'];
                                                          user.nombreA = sections[index]['nombreU'];
                                                          user.correoA = sections[index]['correoU'];
                                                          user.fotoA = sections[index]['fotoU'];

                                                          DocumentReference ref2 = Firestore.instance.collection('PACIENTES').document(user.idA);
                                                          //1. VOLVER "NULL" A ACEPTADO DE PACIENTE
                                                          await ref2.updateData({
                                                            'Aceptado': null
                                                          }).then((value) async{
                                                            //2. ELIMINAR PACIENTE A PSICOLOGO
                                                            await ref.document(user.uid).updateData({
                                                              'Aceptados': FieldValue.arrayRemove([{
                                                                'aceptadoU': user.idA,
                                                                'nombreU': user.nombreA,
                                                                'correoU': user.correoA,
                                                                'fotoU': user.fotoA
                                                              }])
                                                            });
                                                            Fluttertoast.showToast(msg: 'Solicitud eliminada');
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
                                      ],
                                    ),
                                  ),
                                )

                              ]),
                        ),
                        onTap: (){
                          user.idA = sections[index]['aceptadoU'];
                          user.nombreA = sections[index]['nombreU'];
                          user.correoA = sections[index]['correoU'];
                          user.fotoA = sections[index]['fotoU'];
                           Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => perfil_paciente_t(user)));
                        },
                      )
                  );
                },
              );
            } else{
              return Container();
            }
          }),
    );

  }

}