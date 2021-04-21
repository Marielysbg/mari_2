import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_dialogflow/dialogflow_v2.dart';
import '../../../models/chatMessageModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tesis_brainstate/User/model/User.dart';

List<ChatMessage> messages=  <ChatMessage>[];
final Firestore _firestore = Firestore.instance;

class chat_screen extends StatefulWidget {
  User user = new User();

  chat_screen(this.user);
  
  //final Firestore _firestore = Firestore.instance;

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    messages.clear();
    //getData();
    return _chat_screen(this.user, messages);
  }

   getData() async  {

    var messagesStream = _firestore.collection("chat").where('user.correo',isEqualTo: user.email).orderBy("timestamp", descending: false).snapshots();
    await for (var messagesSnapshot in messagesStream) {
    for (var messageDoc in messagesSnapshot.documents) {
      var message;
      print(messageDoc["uid"]);
      if (messageDoc["uid"] != null) {
        message = ChatMessage(messageContent: messageDoc["messageContent"], messageType: messageDoc["messageType"]);
      }
      else {
        message = ChatMessage(messageContent: messageDoc["messageContent"], messageType: messageDoc["messageType"]);
      }
      messages.add(message);
      }
    }
    return Future.delayed(Duration(seconds: 2), () => print('get messages'),);
  }





}




class _chat_screen extends State<chat_screen>{
  User user = new User();
  List<ChatMessage> _messages=  <ChatMessage>[];
  _chat_screen(this.user, this._messages);


  Future<http.Response> enviarCorreo({String subject, String text}) async{//String subject, String text
    return http.post(
      Uri.https('brainsimplemailer.herokuapp.com', 'mail'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "from":"brain.state",
        "to":"mariaalejandraduarte.ujap@gmail.com",
        "subject": subject,
        "text":text
      }),
    );
  }



  void response(String text) async {
    AuthGoogle authGoogle = await AuthGoogle( fileJson: "assets/dialog_flow_auth.json").build();
    Dialogflow dialogflow =        Dialogflow(authGoogle: authGoogle, language: Language.spanish);
        AIResponse response = await dialogflow.detectIntent(text);
  
    setState(() {
      String respuesta= response.getListMessage()[0]["text"]["text"][0].toString();
     if (respuesta == 'Emergencia') {
       DateTime now = new DateTime.now();
       String fecha = DateFormat('dd-MM-yyyy').format(now);
       _firestore.collection('Ataque').add({'userid': this.user.uid,"fecha" : fecha,});
       respuesta= 'Ante todo tu vales mucho, y todo en esta vida tiene un proposito , a pesar de no estar en tu mejor momento, juntos podemos salir de esta situación';
       String nombre= user.name;
       String tlf= user.telf;
       String tlfE= user.Temergencia;
       String Date = DateFormat('dd-MM-yyyy').format(DateTime.now());
       String hora = DateFormat('h:mma').format(DateTime.now());

       enviarCorreo(subject: 'Emergencia paciente: $nombre $Date - $hora'  ,text: 'Buenas el paciente: $nombre presenta una emergencia el dia $Date - $hora. '
           'Contacto del paciente # Telefono paciente: $tlf  # Telefono familiar: $tlfE ');
     }

      messages.add(ChatMessage(
          messageContent:respuesta,
          messageType: "receiver",
          user: this.user.toJsonPaciente()));
      _firestore.collection('chat').add({
        'messageContent': respuesta,
        'messageType': "receiver",
        'user': this.user.toJsonPaciente(),
        "timestamp": DateTime.now().millisecondsSinceEpoch,
      });

    });
  }

  final messagecontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    messages = this._messages;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Asistente de ayuda",
        ),
        backgroundColor: Colors.indigo,
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Flexible(child:
          ListView.builder( 
            itemCount: messages.length,
            padding: EdgeInsets.only(top: 10,bottom: 10),
            itemBuilder: (context, index){
              return Container(
                padding: EdgeInsets.only(left: 16,right: 16,top: 10,bottom: 10),
                child: Align(
        alignment: (messages[index].messageType == "receiver"?Alignment.topLeft:Alignment.topRight),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: (messages[index].messageType  == "receiver"?Colors.grey.shade200:Colors.blue[200]),
          ),
          padding: EdgeInsets.all(16),
          child: Text(messages[index].messageContent, style: TextStyle(fontSize: 15),),
              ), ),
      );
            },
        )),
            Divider(
              height: 5.0,
              color: Colors.indigo,
            ),
            Container(
              padding: EdgeInsets.only(left: 15.0, right: 15.0),
              margin: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                children: <Widget>[
                  Flexible(
                      child: TextField(
                    controller: messagecontroller,
                    decoration: InputDecoration.collapsed(
                        hintText: "Escribe un mensaje",
                        hintStyle: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18.0)),
                  )),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 4.0),
                    child: IconButton(
                      
                        icon: Icon(
                          
                          Icons.send,
                          size: 30.0,
                          color: Colors.indigo,
                        ),
                        onPressed: () {
                          if (messagecontroller.text.isEmpty) {
                            print("Mensaje vacio");
                          } else {
                            setState(() {
                            messages.add( ChatMessage(messageContent: messagecontroller.text, messageType: "sender", user: this.user.toJsonPaciente()));
                             _firestore.collection('chat').add({'messageContent': messagecontroller.text, 'messageType': "sender", 'user': this.user.toJsonPaciente(),
                               "timestamp" :DateTime.now().millisecondsSinceEpoch
                             });

                            });
                           response(messagecontroller.text);
                            messagecontroller.clear();
                          }
                        }),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 15.0,
            )
          ],
        ),
      ),
    );
  }




}


