import 'package:flutter/material.dart';
import 'package:tesis_brainstate/User/ui/widgets/header_profile.dart';
import 'package:tesis_brainstate/User/model/User.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tesis_brainstate/Psico/consejos_screen.dart';
import 'package:tesis_brainstate/Psico/List_pacientes.dart';
import 'package:tesis_brainstate/Psico/edit_profile_psico.dart';

class profile_psico extends StatelessWidget{

  User user = new User();
  profile_psico(this.user);
  TextEditingController mensaje = TextEditingController();
  String fecha;

  @override

  Widget build(BuildContext context) {

    final edit = Container(
        margin: EdgeInsets.only(
            top: 1.0,
            left: 350.0
        ),
        child: RaisedButton(
          child: Text(
            'Editar perfil',
            style: TextStyle(
              color: Colors.white
            ),
          ),
          color: Colors.indigo,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
              side: BorderSide(color: Colors.white)
          ),
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => edit_profile_psico(user)));
          },
        )
    );

    final consejo =  Container(
      padding: EdgeInsets.only(left: 17.0, right: 15.0, top: 30.0),
      // margin: const EdgeInsets.symmetric(horizontal: 5.0),
      child: Row(
        children: <Widget>[
          Flexible(
              child: TextField(
                maxLines: null,
                controller: mensaje,
                autofocus: false,
                decoration: InputDecoration(
                    hintText: "Envía un consejo a tus pacientes",
                    fillColor: Colors.indigo,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: BorderSide(
                        color: Colors.indigo
                      )
                    ),
                    hintStyle: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 15.0)),
              )),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 4.0),
            child: IconButton(
                icon: Icon(
                  Icons.send,
                  size: 30.0,
                  color: Colors.indigo,
                ),
                onPressed: () async{
                  FocusScope.of(context).requestFocus(new FocusNode());
                  DateTime now = DateTime.now();
                  String formattedDate = DateFormat('dd-MM-yyyy – kk:mm a').format(now);
                  CollectionReference ref = Firestore.instance.collection('PSICOLOGOS');
                  if(mensaje.text == ''){
                    Fluttertoast.showToast(msg: 'No puede enviar un mensaje vacio');
                  } else{
                    await ref.document(user.uid).updateData({
                      'Mensajes': FieldValue.arrayUnion([{
                        'mensaje': mensaje.text,
                        'hora': formattedDate,
                      }])
                    }).whenComplete(() {
                      Fluttertoast.showToast(msg: 'Mensaje enviado');
                      mensaje.clear();
                    });
                  }
                }),
          ),
        ],
      ),
    );

    final b1 = Container(
      width: 350.0,
      height: 60.0,
      margin: EdgeInsets.only(
          top: 30.0
      ),
      child: RaisedButton(
          elevation: 3.0,
          onPressed: () => {
          Navigator.push(context, MaterialPageRoute(builder: (context) => List_pacientes(user)))
          },
          // padding: const EdgeInsets.all(0.0),
          color: Colors.white,
          child: Container(
            child:Row(
              children: [
                Align(
                    alignment: Alignment.centerLeft,
                    child: Icon(Icons.list,
                      size: 30.0,
                      color: Colors.indigo,
                    )
                ),
                Container(
                    margin: const EdgeInsets.only( left: 10.0 ),
                    child: Text(
                      "Mis pacientes",
                      style: TextStyle( fontSize: 17.0,
                        color: Colors.black54,
                      ),
                    )
                )
              ],
            ),
          ),
          shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(5.0),
              side: BorderSide(color: Colors.indigo)
          )
      ),
    );

    final b2 = Container(
      width: 350.0,
      height: 60.0,
      margin: EdgeInsets.only(
          top: 30.0
      ),
      child: RaisedButton(
          elevation: 3.0,
          onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => consejos_screen(user)));
          },
          // padding: const EdgeInsets.all(0.0),
          color: Colors.white,
          child: Container(
            child:Row(
              children: [
                Align(
                    alignment: Alignment.centerLeft,
                    child: Icon(Icons.message,
                      size: 30.0,
                      color: Colors.indigo,
                    )
                ),
                Container(
                    margin: const EdgeInsets.only( left: 10.0 ),
                    child: Text(
                      "Consejos",
                      style: TextStyle( fontSize: 17.0,
                          color: Colors.black54
                      ),
                    )
                )
              ],
            ),
          ),
          shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(5.0),
              side: BorderSide(color: Colors.indigo)
          )
      ),
    );

    // TODO: implement build
    return SingleChildScrollView(
      child: GestureDetector(
        onTap: (){
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Column(
          children: [
            Stack(
              children: [
                headerprofile(user),
                Positioned(
                  top: 160.0,
                  right: 115.0,
                  child: edit,
                )
              ],
            ),
            consejo,
            b1,
            b2
          ],
        ),
      )
    );
  }

}
