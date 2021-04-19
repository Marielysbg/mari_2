import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tesis_brainstate/User/model/User.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class formulario_resena extends StatefulWidget {

  User user = new User();
  formulario_resena(this.user);


  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _formulario_resena();
  }

}

class _formulario_resena extends State<formulario_resena>{

  String title, clave, descripcion;

  @override

  Widget build(BuildContext context) {

    final input_titulo = Padding(
      padding: const EdgeInsets.all(20.0),
      child: TextField(
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
          labelText: "Titulo",
        ),
        onChanged: (value){
          setState(() {
            title = value.trim();
          });
        },
      ),
    );

    final input_clave = Padding(
      padding: const EdgeInsets.all(20.0),
      child: TextField(
        textCapitalization: TextCapitalization.sentences,
        maxLines: 1,
        decoration: InputDecoration(
          labelText: "Palabra clave",
        ),
        onChanged: (value){
          setState(() {
            clave = value.trim();
          });
        },
      ),
    );

    final input_descripcion = Padding(
      padding: const EdgeInsets.all(20.0),
      child: TextField(
        textCapitalization: TextCapitalization.sentences,
        maxLines: null,
        decoration: InputDecoration(
          labelText: "Descripción",
        ),
        onChanged: (value){
          setState(() {
            descripcion = value.trim();
          });
        },
      ),
    );

    final button = Container(
      margin: EdgeInsets.only(
          top: 20.0
      ),
      width: 300.0,
      height: 50.0,
      child: RaisedButton(
        child: Text('Registrar',
          style: TextStyle(
              fontSize: 16.0
          ),
        ),
        elevation: 5.0,
        color: Colors.indigo,
        textColor: Colors.white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
            side: BorderSide(color: Colors.indigo)
        ),
        onPressed: () async{
          DateTime now = DateTime.now();
          String formattedDate = DateFormat('dd-MM-yyyy').format(now);
          String hora = DateFormat('h:mma').format(now);
          if(title == null || clave == null || descripcion == null){
            Fluttertoast.showToast(msg: 'Debe completar el formulario para continuar');
          } else{
            CollectionReference ref = Firestore.instance.collection('RESENA');
            CollectionReference psi = Firestore.instance.collection('PSICOLOGOS');
            await ref.document('resena').updateData({
              'resena': FieldValue.arrayUnion([{
                'title': title,
                'psico': widget.user.name,
                'foto': widget.user.foto,
                'clave': clave,
                'description': descripcion,
                'fecha': formattedDate,
                'hora': hora
              }])
            }).whenComplete(() async{
              await psi.document(widget.user.uid).updateData({
                'resena': FieldValue.arrayUnion([{
                  'title': title,
                  'psico': widget.user.name,
                  'foto': widget.user.foto,
                  'clave': clave,
                  'description': descripcion,
                  'fecha': formattedDate,
                  'hora': hora
                }])
              }).whenComplete(() {
                Fluttertoast.showToast(msg: 'Reseña subida con exito');
                Navigator.pop(context);
              });

            });
          }
        },
      ),
    );

    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Subir reseña'),
        centerTitle: true,
        backgroundColor: Colors.indigo,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
                child:  Container(
                  margin: EdgeInsets.only(
                      top: 40.0,
                    bottom: 20.0
                  ),
                  child: Text(
                    'Rellena los formularios para subir tu reseña',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 17.0
                    ),
                  ),
                )
            ),
            input_titulo,
            input_clave,
           input_descripcion,
            Container(
              margin: EdgeInsets.only(
                top: 220.0
              ),
              child: button,
            )
          ],
        ),
      )
    );
  }



}