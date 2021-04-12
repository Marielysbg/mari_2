import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tesis_brainstate/User/ui/screens/Login_Screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tesis_brainstate/User/model/User.dart';
import 'package:tesis_brainstate/admin/gest_soli_psico.dart';
import 'package:tesis_brainstate/admin/home_admin.dart';


class gest_psico extends StatelessWidget{


  User user = new User();
  gest_psico(this.user);
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {

    void _showAlertDialog() {
      showDialog(
          context: context,
          builder: (buildcontext) {
            return AlertDialog(
              title: Text("¿Desea salir de la aplicación?"),
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
                  Text("Salir",
                    style: TextStyle(
                        color: Colors.blue
                    ),
                  ),
                  onPressed: (){ auth.signOut().whenComplete(() =>  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => Login_Screen()))); },
                ),
              ],
            );
          }
      );
    }

    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          backgroundColor:  Colors.indigo,
          title: Text('Psicólogos'),
          centerTitle: true,
          toolbarHeight: 70.0,
        ),
        drawer: new Drawer(
          child: ListView(
            children: [
              new UserAccountsDrawerHeader(
                decoration: BoxDecoration(
                    color: Colors.indigo
                ),
                accountName: Text('Admin'),
                accountEmail: Text('Admin@correo.com'),
                currentAccountPicture: CircleAvatar(
                  backgroundImage: NetworkImage('https://shanghai-date.com/uploads/g/t/t/h/q2t34kjldqrqv0pl7ihh.png'),
                ),
              ),
              new ListTile(
                title: Text('Gestión de pacientes'),
                onTap: (){
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => home_admin(user)));
                },
              ),
              new ListTile(
                title: Text('Gestión de psicólogos'),
                onTap: (){
                  Navigator.pop(context);
                },
              ),
              new ListTile(
                title: Text('Solicitudes de acceso'),
                onTap: (){
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => gest_soli_psico(user)));
                },
              ),
              Divider(
                color: Colors.indigo,
              ),
              new ListTile(
                title: Text('Salir'),
                onTap: (){
                  _showAlertDialog();
                },
              ),
            ],
          ),
        ),
        body:  SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.only(
                  top: 30.0
              ),
              child:  Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  StreamBuilder(
                      stream: Firestore.instance.collection('PSICOLOGOS').snapshots(),
                      builder: (BuildContext context, AsyncSnapshot<
                          QuerySnapshot> snapshot) {
                        if (snapshot.hasData &&
                            snapshot.data != null) {
                          //final docs = snapshot.data.docs;
                          return ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: snapshot.data.documents.length,
                              itemBuilder: (BuildContext context, int index) {
                                var docs = snapshot.data.documents[index].data;
                                //final user = docs[index].data();
                                return (docs['verificado'] == 'verificado') ? Container(
                                    child: GestureDetector(
                                      //MÉTODO ON TAP
                                      onTap: () {},
                                      child: Card(
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                        margin: EdgeInsets.only(
                                            left: 11.0,
                                            right: 11.0,
                                            bottom: 14.0
                                        ),
                                        elevation: 3,
                                        child: Row(
                                          children: [
                                            FadeInImage(
                                              image: NetworkImage(
                                                //IMAGEN PRINCIPAL
                                                  docs['foto']
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
                                                      docs['nombre'],
                                                      style: TextStyle(
                                                        fontSize: 17.0,
                                                        //fontWeight: FontWeight.bold
                                                      ),
                                                    ),
                                                    Text(
                                                      //TEXTO PRINCIPAL
                                                      docs['correo'],
                                                      style: TextStyle(
                                                        fontSize: 15.0,
                                                        //fontWeight: FontWeight.bold
                                                      ),
                                                    ),
                                                  ],
                                                )
                                            ),
                                            Spacer(),
                                            IconButton(
                                              onPressed: (){
                                                showDialog(
                                                    context: context,
                                                    builder: (buildcontext) {
                                                      return AlertDialog(
                                                        title: Text("¿Seguro de que desea eliminar al psicólogo?"),
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
                                                            onPressed: ()async{
                                                              if(docs['Aceptados'] == null){
                                                                print('No hay aceptados');
                                                              }else{
                                                                print(docs['Aceptados'].length);
                                                                for (var i = 0; i < docs['Aceptados'].length; i++){
                                                                  print(docs['Aceptados'][i]['aceptadoU']);
                                                                  DocumentReference ref2 = Firestore.instance.collection('PACIENTES').document(docs['Aceptados'][i]['aceptadoU']);
                                                                    //Aceptado a null
                                                                  await ref2.updateData({
                                                                    'Aceptado': null
                                                                  });
                                                                }
                                                              }
                                                              if(docs['Solicitudes'] == null){
                                                                print('No hay solicitudes');
                                                              }else{
                                                                print(docs['Solicitudes'].length);
                                                                for (var i = 0; i < docs['Solicitudes'].length; i++){
                                                                  print(docs['Solicitudes'][i]['solicitudU']);
                                                                  DocumentReference ref2 = Firestore.instance.collection('PACIENTES').document(docs['Solicitudes'][i]['solicitudU']);
                                                                  //Solicitudes a null
                                                                  await ref2.updateData({
                                                                    'Solicitud enviada': "null"
                                                                  });
                                                                }
                                                              }
                                                              //Actualizar rol a Psicologo a "Eliminado"
                                                              DocumentReference usu = Firestore.instance.collection('USUARIOS').document(docs['uid']);
                                                              DocumentReference psi = Firestore.instance.collection('PSICOLOGOS').document(docs['uid']);
                                                              //Actualizar verificado (usuario) a rechazado
                                                              await usu.updateData({
                                                                'verificado' : 'eliminado'
                                                              }).whenComplete(() async{
                                                                await psi.updateData({
                                                                  'verificado' : 'eliminado'
                                                                });
                                                                Navigator.pop(context);
                                                              });
                                                           },
                                                          ),
                                                        ],
                                                      );
                                                    }
                                                );
                                              },
                                              icon: Icon(Icons.delete),
                                              color: Colors.red,
                                            )
                                          ],
                                        ),
                                      ),
                                    )
                                ):Container();
                              }
                          );
                        }
                        return Container();
                      }
                  ),
                ],
              ),
            )

        ));
  }

}