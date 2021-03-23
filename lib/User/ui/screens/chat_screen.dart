import 'package:flutter/material.dart';
import 'package:flutter_dialogflow/dialogflow_v2.dart';
import '../../../models/chatMessageModel.dart';

List<ChatMessage> messages=  <ChatMessage>[];


class chat_screen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _chat_screen();
  }

}



class _chat_screen extends State<chat_screen>{

  void response(String text) async {
    AuthGoogle authGoogle = await AuthGoogle( fileJson: "assets/dialog_flow_auth.json").build();
    Dialogflow dialogflow =        Dialogflow(authGoogle: authGoogle, language: Language.spanish);
        AIResponse response = await dialogflow.detectIntent(text);
  
    setState(() {
      
      messages.add( ChatMessage(messageContent: response.getListMessage()[0]["text"]["text"][0].toString(), messageType: "receiver"));
      
    });
  }

  final messagecontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
                             messages.add( ChatMessage(messageContent: messagecontroller.text, messageType: "sender"));
                            
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



  