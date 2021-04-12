import 'package:flutter/material.dart';

import 'package:notification_audio_player/notification_audio_player.dart';

class musica_class extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _musica_class();
  }

}

class _musica_class extends State<musica_class>{


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
      body: Container(
          margin: EdgeInsets.only(
              top: 20.0
          ),
          child: Column(
            children: [

            ],
          )
        /*Column(children: [
            RaisedButton(
              child: Text('Play'),
              onPressed: () async{

                print(await notificationAudioPlayer.play(title, author, avatar, url));
              },
            ),
            RaisedButton(
              child: Text('pause'),
              onPressed: () async{
                print(await notificationAudioPlayer.pause());
              },
            ),
            RaisedButton(
              child: Text('resume'),
              onPressed: () async{
                print(await notificationAudioPlayer.resume());
              },
            ),
            RaisedButton(
              child: Text('stop'),
              onPressed: () async{
                print(await notificationAudioPlayer.stop());
              },
            ),
            RaisedButton(
              child: Text('release'),
              onPressed: () async{
                print(await notificationAudioPlayer.release());
              },
            ),
            RaisedButton(
              child: Text('removeNotification'),
              onPressed: () async{
                print(await notificationAudioPlayer.removeNotification());
              },
            ),
            RaisedButton(
              child: Text('getPlayerState'),
              onPressed: () async{
                print(await notificationAudioPlayer.playerState);
              },
            ),
            RaisedButton(
              child: Text('getDuration'),
              onPressed: () async{
                print(await notificationAudioPlayer.duration);
              },
            ),
            RaisedButton(
              child: Text('getCurrentPosition'),
              onPressed: () async{
                print(await notificationAudioPlayer.currentPosition);
              },
            ),
            RaisedButton(
              child: Text('setWakeLock'),
              onPressed: () async{
                print(await notificationAudioPlayer.setWakeLock());
              },
            ),
            RaisedButton(
              child: Text('setSpeed'),
              onPressed: () async{
                print(await notificationAudioPlayer.setSpeed(1.5));
              },
            ),
            RaisedButton(
              child: Text('setVolume'),
              onPressed: () async{
                print(await notificationAudioPlayer.setVolume(0.5, 0.5));
              },
            ),
            RaisedButton(
              child: Text('setIsLooping'),
              onPressed: () async{
                print(await notificationAudioPlayer.setIsLooping(true));
              },
            ),
            RaisedButton(
              child: Text('seek'),
              onPressed: () async{
                print(await notificationAudioPlayer.seek(10000));
              },
            ),
          ],)

           */
      ),
    );
  }




}