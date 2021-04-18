import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notification_audio_player/notification_audio_player.dart';
import 'package:tesis_brainstate/User/ui/screens/musica_class.dart';

class repositorio_musica_home extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
   return _repositorio_musica_home();
  }

  }

  class _repositorio_musica_home extends State<repositorio_musica_home>{


    String title = "Shape of Yo";
    String author = "J.Fla";
    String avatar = "http://p3.music.126.net/hZ2ttGYOQbL9ei9yABpejQ==/109951163032775841.jpg?param=320y320";
    String url = "https://x2convert.com/es/Thankyou?token=U2FsdGVkX194hdLsjWbwpujROHPHffqDiy3HaIcBEOsBiMvmXmCTjOZLhLWMRXcUQUS3VEYImhfLial7e7%2bCFvyuXZ1gT5FDBvMR903jIJqZHQfzd4%2bHCIoFnBVf4mVaKlnbOSOwR6ggYofMPoPLetPD2yHr5rdtRtDsworailOfJhoKatTDL9bVknBYhRfa1%2f9Wy50nUgusM2ERU1z94ZFsfih5nXcl5nYs%2fvuMRag%3d&s=youtube&id=&h=4760418728908101522";
    NotificationAudioPlayer notificationAudioPlayer = NotificationAudioPlayer();


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Repositorio de música'
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
      body: GestureDetector(
        onTap: ()async{
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => musica_class(
            title: title,
            url: url,
            author: author,
            avatar: avatar,
          )));
        },
        child: Container(
            margin: EdgeInsets.only(
                top: 20.0
            ),
            child: ListTile(
                leading: Image.network(avatar),
                title: Text(title),
                subtitle: Text(author),
                trailing:  IconButton(
                  icon: Icon(Icons.arrow_forward_ios),
                  onPressed: ()async{
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => musica_class(
                      title: title,
                      url: url,
                      author: author,
                      avatar: avatar,
                    )));
                  },
                )
            )
        ),
      )
    );
  }


  

}