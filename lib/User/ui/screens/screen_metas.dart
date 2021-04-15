

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tesis_brainstate/User/model/User.dart';


class screenMetas extends StatefulWidget {
User user = new User();
screenMetas(this.user);
//static final String routeName = '/';

@override
_screenMetasState createState() => _screenMetasState(this.user);

}

class _screenMetasState extends State<screenMetas> {

  User user = new User();
  _screenMetasState(this.user);
//List metas = List();
String title="";
  Firestore _firestore = Firestore.instance;

createMeta(){
  DocumentReference documentReference= Firestore.instance.collection("Metas").document(title);
  if (title.isEmpty ) return;

    documentReference.setData({'title': title, 'user': this.user.toJsonPaciente()}).whenComplete((){
     print("$title created");
  });


  }

  deleteMeta(item){
    DocumentReference documentReference= Firestore.instance.collection("Metas").document(item);
    documentReference.delete().whenComplete((){
      print("$item delete");
   });

  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.indigo,title: Text("Metas"),),//appbar
      floatingActionButton: FloatingActionButton(onPressed:(){
        showDialog(context: context,
            builder: (BuildContext context){
          return AlertDialog(
            title: Text("Agregar meta"),
            content: TextField(onChanged: (String value){
              title = value;
            },
            ),
        actions: <Widget>
            [FlatButton(onPressed: (){
              //setState((){
              //todos.add(input);});
            createMeta();
            Navigator.of(context).pop();
          },child: Text("agregar"))
        ],
          );
                  });
      },backgroundColor: Colors.indigo,
      child: Icon(Icons.add, color: Colors.white,),),
      body: StreamBuilder(stream: Firestore.instance.collection("Metas").where("user.correo" ,  isEqualTo: this.user.email).snapshots(),
        builder: (context, snapshots){
        return ListView.builder(shrinkWrap: true,
            itemCount: snapshots.data  != null ? snapshots.data.documents.length : 0,
            itemBuilder: ( context,  index){
          DocumentSnapshot documentSnapshot= snapshots.data.documents[index];
              return Dismissible(
                onDismissed: (direction){
                  deleteMeta(documentSnapshot["title"]);
                },
                  key: Key(documentSnapshot["title"]),
                  child: Card(
                    child: ListTile(
                      title: Text(documentSnapshot ["title"]),
                      trailing: IconButton(icon: Icon(Icons.delete), color: Colors.red, onPressed: (){
                          deleteMeta(documentSnapshot["title"]);

                        }),

                     ),
                  ));
            });
      },)
    );

  }

}