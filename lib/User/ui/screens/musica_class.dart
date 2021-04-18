import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:notification_audio_player/notification_audio_player.dart';

class musica_class extends StatefulWidget{

  String title, author, avatar, url;
  musica_class({Key key, @required this.author, @required this.title, @required this.avatar, @required this.url});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _musica_class();
  }

}

class _musica_class extends State<musica_class>{

  NotificationAudioPlayer notificationAudioPlayer = NotificationAudioPlayer();
  bool playState = true;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.indigo,
      appBar: AppBar(
        title: Text(
            'Reproductor'
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
          top: 70.0
        ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Container(
                  height: 300.0,
                  width: 300.0,
                  child:  CircleAvatar(
                    backgroundImage: NetworkImage(widget.avatar),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  top: 30.0
                ),
                child: Text(
                  widget.title,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                    top: 5.0
                ),
                child: Text(
                    widget.author,
                  maxLines: 3,
                  style: TextStyle(
                      fontSize: 17.0,
                      color: Colors.white,
                      fontWeight: FontWeight.w600
                  ),
                ),
              ),
              Spacer(),
              Container(
                height: 100.0,
                decoration: BoxDecoration(
                  color: Color(0xFFFF5252),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(90.0),
                      topRight: Radius.circular(90.0),
                    ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                   IconButton(
                        icon: Icon(playState ? Icons.play_arrow : Icons.pause, color: Colors.white,
                        ),
                        iconSize: 50.0,
                        onPressed: ()async{
                          String state = await notificationAudioPlayer.playerState;
                          if (playState == true){
                            if(state == "PAUSED"){
                              print(await notificationAudioPlayer.resume());
                              print(await notificationAudioPlayer.duration);
                              print(await notificationAudioPlayer.currentPosition);
                              setState(() {
                                playState = false;
                              });
                            } else{
                              print(await notificationAudioPlayer.playerState);
                              print(
                                  await notificationAudioPlayer.play(
                                      widget.title,
                                      widget.author,
                                      widget.avatar,
                                      widget.url));
                              setState(() {
                                playState = false;
                              });
                            }
                          } else{
                            setState(() {
                              playState = true;
                            });
                            print(await notificationAudioPlayer.pause());
                          }

                        },
                    )
                  ],
                ),
              )
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