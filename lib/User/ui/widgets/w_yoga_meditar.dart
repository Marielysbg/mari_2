import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tesis_brainstate/User/model/User.dart';
import 'package:tesis_brainstate/User/ui/screens/musica_class.dart';

class w_yoga_meditar extends StatefulWidget{

  User user = new User();
  w_yoga_meditar(this.user);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _w_yoga_meditar();
  }
}

class _w_yoga_meditar extends State<w_yoga_meditar>{

  Stream<DocumentSnapshot> courseDocStream = Firestore.instance.collection('REPOSITORIOS').document('musica').snapshots();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        body: StreamBuilder<DocumentSnapshot>(
          stream: courseDocStream,
          builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot){
            if (snapshot.data != null){
              var courseDocument = snapshot.data.data;
              var sections = courseDocument['meditar'];
              return ListView.builder(
                  itemCount: sections != null ? sections.length : 0,
                  itemBuilder: (context, index){
                    return GestureDetector(
                      onTap: () async{
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => musica_class(
                          title: sections[index]['subtitle'],
                          url: sections[index]['url'],
                          author: sections[index]['author'],
                          avatar: sections[index]['avatar'],
                          user: widget.user,
                        )));
                      },
                      child: Container(
                          margin: EdgeInsets.only(
                              top: 20.0
                          ),
                          child: ListTile(
                              leading: Image.network(sections[index]['avatar'],),
                              title: Text(sections[index]['subtitle'],),
                              subtitle: Text(sections[index]['author'],),
                              trailing:  IconButton(
                                icon: Icon(Icons.arrow_forward_ios),
                                onPressed: ()async{
                                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => musica_class(
                                    title: sections[index]['subtitle'],
                                    url: sections[index]['url'],
                                    author: sections[index]['author'],
                                    avatar: sections[index]['avatar'],
                                    user: widget.user,
                                  )));
                                },
                              )
                          )
                      ),
                    );
                  }
              );
            } else {
              return Container();
            }
          },
        )
    );
  }




}