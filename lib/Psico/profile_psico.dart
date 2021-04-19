import 'package:flutter/material.dart';
import 'package:tesis_brainstate/Psico/formulario_resena.dart';
import 'package:tesis_brainstate/Psico/resena.dart';
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
      padding: EdgeInsets.only(left: 17.0, right: 15.0, top: 20.0),
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
      child: CircleAvatar(
        backgroundColor: Color(0xFFC5CAE9),
        radius: 30.0,
        child: IconButton(
          onPressed: () => {
            Navigator.push(context, MaterialPageRoute(builder: (context) => List_pacientes(user)))
          },
          // padding: const EdgeInsets.all(0.0),
          color: Color(0xFFFF5252),
          icon: Icon(Icons.people,
              color: Colors.black),
        ),
      )
    );

    final b2 = Container(
      //width: 350.0,
      //height: 60.0,
     // margin: EdgeInsets.only(
      //    top: 30.0
     // ),
      child: CircleAvatar(
          backgroundColor: Color(0xFFC5CAE9),
          radius: 30.0,
        child: IconButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => consejos_screen(user)));
          },
          // padding: const EdgeInsets.all(0.0),
          color: Colors.white,
          icon: Icon(Icons.message,
            color: Colors.black,
          ),

        ),
      )
    );

    final b3 = Container(
      //width: 350.0,
      //height: 60.0,
      // margin: EdgeInsets.only(
      //    top: 30.0
      // ),
        child: CircleAvatar(
          backgroundColor: Color(0xFFC5CAE9),
          radius: 30.0,
          child: IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => resena(user)));
            },
            // padding: const EdgeInsets.all(0.0),
            color: Colors.white,
            icon: Icon(Icons.rate_review,
              color: Colors.black,
            ),
          ),
        )
    );

    final text = Container(
      margin: EdgeInsets.only(
        left: 20.0
      ),
      child: Text(
        'Envía un mensaje general a tus pacientes',
        style: TextStyle(
          color: Color(0xFF212121),
          fontWeight: FontWeight.bold
        ),
      ),
    );

    final des =  Container(
        margin: EdgeInsets.only(
            top: 20.0,
            right: 20.0,
          left: 20.0,
          bottom: 20.0
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
                          user.descripcion,
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
                         user.direccion,
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
                    user.telf,
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
    );

    // TODO: implement build
    return SingleChildScrollView(
      child: GestureDetector(
        onTap: (){
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                headerprofile(user, 280.0),
                Positioned(
                  top: 160.0,
                  right: 115.0,
                  child: edit,
                ),
                Container(
                  width: 250.0,
                  height: 100.0,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                          color: Colors.black54,
                          blurRadius: 15.0,
                          offset: Offset(0.0, 0.75)
                      )
                    ],
                  ),
                  margin: EdgeInsets.only(
                    top: 230.0,
                    left: 80.0,
                    bottom: 30.0
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      b1,
                      b2,
                      b3
                    ],
                  ),
                ),
              ],
            ),
            text,
            consejo,
            des,
          ],
        ),
      )
    );
  }

}
