import 'package:emoji_feedback/emoji_feedback.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:tesis_brainstate/User/model/User.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';

class emoji_feedback extends StatelessWidget {

  User user = new User();
  emoji_feedback(this.user);
  int x;
  String emocion;


  @override
  Widget build(BuildContext context) {
    // TODO: implement build


    buildShowDialog(BuildContext context) {
      return showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return Center(
              child: CircularProgressIndicator(),
            );
          });
    }

    final feedback =  Center(
      child:  Container(
        child: EmojiFeedback(
            onChange: (index) {
          x = index;
        }
        ),
      ),
    );


    final text = Container(
      margin: EdgeInsets.only(
          left: 20.0,
          bottom: 20.0,
        top: 20.0
      ),
      child: Text(
        '¿Cómo te sientes hoy?',
        style: TextStyle(
            color: Colors.black,
            fontSize: 20.0,
            fontWeight: FontWeight.bold
        ),
      ),
    );

    final buton = Container(
      margin: EdgeInsets.only(
          left: 240.0,
        top: 10.0
      ),
      width: 130.0,
      height: 45.0,
      child: RaisedButton(
        child: Text('Enviar',
          style: TextStyle(
              fontSize: 16.0,
              color: Colors.white
          ),
        ),
        elevation: 5.0,
        color: Color(0xFFFF5252),
        textColor: Colors.indigo,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0)
        ),
        onPressed: ()async{
          buildShowDialog(context);
          DateTime now = new DateTime.now();
          String fecha = DateFormat('dd-MM-yyyy').format(now);
          String hora = DateFormat('h:mma').format(now);

          if (x == null){
            x = 2;
            emocion = 'ok';
          } else if (x == 0){
            emocion = 'terrible';
          } else if (x == 1){
            emocion = 'bad';
          } else if (x == 2){
            emocion = 'ok';
          } else if (x == 3){
            emocion = 'good';
          } else if (x == 4){
            emocion = 'awesome';
          }

          try{
            CollectionReference pac = Firestore.instance.collection('PACIENTES');
            await pac.document(user.uid).updateData({
              'Emociones': FieldValue.arrayUnion([{
                'index': x,
                'emocion': emocion,
                'fecha': fecha,
                'hora': hora
              }])
            }).whenComplete(()async {
              CollectionReference emo = Firestore.instance.collection('EMOCIONES');
              await emo.document(user.uid).updateData({
                'Emociones': FieldValue.arrayUnion([{
                  'index': x,
                  'emocion': emocion,
                  'fecha': fecha,
                  'hora': hora
                }])
              }).whenComplete((){
                Fluttertoast.showToast(msg: 'Cargado exitosamente');
                Navigator.pop(context);
              });
            });
          } catch (e){
          }
          print(fecha);
          print(hora);
          print(emocion);
        },
      ),
    );

    return Container(
      margin: EdgeInsets.only(
        bottom: 15.0
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          text,
          feedback,
          buton,
        ],
      ),
    );


  }
}