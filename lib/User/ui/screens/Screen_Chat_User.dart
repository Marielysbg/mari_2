import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tesis_brainstate/User/model/User.dart';


class screen_Chat_User extends StatefulWidget {
  User user = new User();
  screen_Chat_User(this.user);
//static final String routeName = '/';

  @override
  _screen_Chat_UserState createState() => _screen_Chat_UserState(this.user);

}

class _screen_Chat_UserState extends State<screen_Chat_User> {

  User user = new User();
  _screen_Chat_UserState(this.user);
  String title="";
  Firestore _firestore = Firestore.instance;






  @override
  Widget build(BuildContext context) {
    String name = user.nombreA;
    return Scaffold(
        appBar: AppBar(backgroundColor: Colors.indigo,title: Text("Chat de  $name"),),//appbar

        body: StreamBuilder(stream: Firestore.instance.collection("chat").where("user.uid" ,  isEqualTo: user.idA).snapshots(),
          builder: (context, snapshots) {
            return ListView.builder(shrinkWrap: true,
                itemCount: snapshots.data != null ? snapshots.data.documents
                    .length : 0,
                itemBuilder: (context, index) {
                  DocumentSnapshot documentSnapshot = snapshots.data
                      .documents[index];
                  return Container(
                    padding: EdgeInsets.only(
                        left: 16, right: 16, top: 10, bottom: 10),
                    child: Align(
                      alignment: (documentSnapshot["messageType"] == "receiver"
                          ? Alignment.topLeft
                          : Alignment.topRight),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: (documentSnapshot["messageType"] == "receiver"
                              ? Colors.grey.shade200
                              : Colors.blue[200]),
                        ),
                        padding: EdgeInsets.all(16),
                        child: Text(documentSnapshot["messageContent"],
                          style: TextStyle(fontSize: 15),),
                      ),),
                  );
                });
          }
    ), );

  }

}

