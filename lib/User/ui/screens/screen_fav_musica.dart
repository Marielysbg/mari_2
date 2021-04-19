import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tesis_brainstate/User/model/User.dart';
import 'package:tesis_brainstate/User/ui/screens/musica_class.dart';

class screen_fav_musica extends StatefulWidget{

  User user = new User();
  screen_fav_musica(this.user);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _screen_fav_musica();
  }

}

class _screen_fav_musica extends State<screen_fav_musica>{

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    Stream<DocumentSnapshot> courseDocStream = Firestore.instance.collection('FAVORITOS').document(widget.user.uid).snapshots();
    return Scaffold(
        body: StreamBuilder<DocumentSnapshot>(
          stream: courseDocStream,
          builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot){
            if (snapshot.data != null){
              var courseDocument = snapshot.data.data;
              var sections = courseDocument['musica'];

              return ListView.builder(
                  itemCount: sections != null ? sections.length : 0,
                  itemBuilder: (context, index){
                    return GestureDetector(
                      onTap: () async{
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => musica_class(
                          title: sections[index]['title'],
                          url: sections[index]['url'],
                          author: sections[index]['author'],
                          avatar: sections[index]['avatar'],
                          user: widget.user,
                          repo: 'fav',
                        )));
                      },
                      child: Container(
                          margin: EdgeInsets.only(
                              top: 20.0
                          ),
                          child: ListTile(
                              leading: Image.network(sections[index]['avatar'],),
                              title: Text(sections[index]['title'],),
                              subtitle: Text(sections[index]['author'],),
                              trailing:  IconButton(
                                icon: Icon(Icons.arrow_forward_ios),
                                onPressed: ()async{
                                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => musica_class(
                                    title: sections[index]['title'],
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