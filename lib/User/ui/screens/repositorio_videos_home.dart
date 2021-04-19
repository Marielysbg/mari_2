import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tesis_brainstate/User/model/User.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:tesis_brainstate/User/ui/widgets/videos_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class repositorio_videos_home extends StatelessWidget{

  User user = new User();
  repositorio_videos_home(this.user);
  Stream<DocumentSnapshot> courseDocStream = Firestore.instance.collection('REPOSITORIOS').document('videos').snapshots();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70.0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.indigo,
        title: Text('Repositorio de videos',
        style: TextStyle(
          color: Colors.white
        ),
        ),
        centerTitle: true,
      ),
      body: StreamBuilder<DocumentSnapshot>(
      stream: courseDocStream,
      builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.data != null) {
          var courseDocument = snapshot.data.data;
          // get sections from the document
          var sections = courseDocument['video'];
          return ListView.builder(
              itemCount: sections != null ? sections.length : 0,
              itemBuilder: (context, index) {
                String id = YoutubePlayer.convertUrlToId(sections[index]['url']);
                return GestureDetector(
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => videosRepository(
                      title: sections[index]['title'],
                      url: sections[index]['url'],
                      subtitle: sections[index]['subtitle'],
                      repo: 'videos',
                      user: user,
                    )));
                    print(user.uid);
                  },
                    child: Container(
                      padding: EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              padding: EdgeInsets.all(15.0),
                              decoration: BoxDecoration(
                                  color: Colors.indigo,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10.0),
                                    topRight: Radius.circular(10.0),
                                  )
                              ),
                              child: Center(
                                child: Text(
                                  sections[index]['title'],
                                  maxLines: 3,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 17.0,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                              )
                          ),
                          Container(
                            height: 200.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(10.0),
                                bottomRight: Radius.circular(10.0),
                              ),
                              image: DecorationImage(
                                  image: NetworkImage(
                                      'https://img.youtube.com/vi/$id/0.jpg'),
                                  fit: BoxFit.cover
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                );
              }
          );
        } else {
          return Container();
        }
      }
      )
    );
  }


//Image.network('https://img.youtube.com/vi/6cwnBBAVIwE/0.jpg'),
}