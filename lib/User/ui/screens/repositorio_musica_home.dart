import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tesis_brainstate/User/model/User.dart';
import 'package:tesis_brainstate/User/ui/screens/musica_class.dart';

class repositorio_musica_home extends StatefulWidget{

  String name;
  User user = new User();
  repositorio_musica_home(this.name, this.user);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
   return _repositorio_musica_home();
  }

  }

  class _repositorio_musica_home extends State<repositorio_musica_home>{

    Stream<DocumentSnapshot> courseDocStream = Firestore.instance.collection('REPOSITORIOS').document('musica').snapshots();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.name
        ),
        centerTitle: true,
        toolbarHeight: 70.0,
        backgroundColor: Colors.indigo,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: courseDocStream,
        builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot){
          if (snapshot.data != null){
            var courseDocument = snapshot.data.data;
            var sections;
            widget.name == 'Motivacional' ?  sections = courseDocument['motivacional'] : widget.name == 'Relajar' ? sections = courseDocument['relajar'] : widget.name == 'Dormir' ? sections = courseDocument['dormir'] : sections = courseDocument['meditar'];

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