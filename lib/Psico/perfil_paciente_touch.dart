import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tesis_brainstate/User/model/User.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:tesis_brainstate/Psico/mensajes_p.dart';


class perfil_paciente_t extends StatelessWidget{

  User user = new User();
  perfil_paciente_t(this.user);
  TextEditingController mensaje = TextEditingController();

  @override
  Widget build(BuildContext context) {

    String name = user.nombreA;

    final consejo =  Container(
      padding: EdgeInsets.only(left: 5.0, top: 30.0),
      // margin: const EdgeInsets.symmetric(horizontal: 5.0),
      child: Row(
        children: <Widget>[
          Flexible(
              child: TextField(
                maxLines: null,
                controller: mensaje,
                autofocus: false,
                decoration: InputDecoration(
                    hintText: "Mensaje a $name",
                    fillColor: Colors.indigo,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: BorderSide(
                            color: Colors.indigo
                        )
                    ),
                    hintStyle: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 15.0)),
              )
          ),
          Container(
            child: IconButton(
                icon: Icon(
                  Icons.send,
                  size: 30.0,
                  color: Colors.indigo,
                ),
                onPressed: () async{
                  FocusScope.of(context).requestFocus(new FocusNode());
                  DateTime now = DateTime.now();
                  String formattedDate = DateFormat('dd-MM-yyyy – kk:mm').format(now);
                  CollectionReference ref = Firestore.instance.collection('MensajesP');
                  String id = user.idA;
                  if(mensaje.text == ''){
                    Fluttertoast.showToast(msg: 'No puede enviar un mensaje vacio');
                  } else{
                    await ref.document(user.uid).updateData({
                      '$id': FieldValue.arrayUnion([{
                        'mensaje': mensaje.text,
                        'hora': formattedDate,
                      }])
                    }).whenComplete(() async{
                      Fluttertoast.showToast(msg: 'Mensaje enviado');
                      mensaje.clear();
                    });
                  }
                }),
          ),
        ],
      ),
    );

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
        title: Text('Paciente',
          style: TextStyle(
              color: Colors.black
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 5.0,
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: Firestore.instance.collection('PACIENTES').document(user.idA).snapshots(),
        builder: (BuildContext context,
            AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Error:  ${snapshot.error}');
          }
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Text('Cargando...');
            default:
              return SingleChildScrollView(child: Container(
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
                                      Navigator.of(context).push(MaterialPageRoute(
                                          builder: (context) => mensajes_p(user)));
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
                                      Icons.local_hospital,
                                      size: 30.0,
                                      color: Colors.indigo,
                                    ),
                                    Expanded(
                                        child: Container(
                                          margin: EdgeInsets.only(
                                              left: 10.0
                                          ),
                                          child: Text(
                                            'Ansiedad',
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
                              ),
                              consejo,
                            ],
                          )
                      )
                    ],
                  )
              )
              );
          }
        },
      ),
    );
  }

}