import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notification_audio_player/notification_audio_player.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tesis_brainstate/User/model/User.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class musica_class extends StatefulWidget{

  User user = new User();
  musica_class({Key key, @required this.author, @required this.title, @required this.avatar, @required this.url, @required this.user, this.repo});
  String title, author, avatar, url, repo;


  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _musica_class();
  }
}

class _musica_class extends State<musica_class>{

  NotificationAudioPlayer notificationAudioPlayer = NotificationAudioPlayer();
  bool playState = true;

  bool get wantKeepAlive => true;


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
                  textAlign: TextAlign.center,
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
                padding: EdgeInsets.only(
                  top: 15.0
                ),
                height: 100.0,
                decoration: BoxDecoration(
                  color: Color(0xFFFF5252),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(90.0),
                      topRight: Radius.circular(90.0),
                    ),
                ),
                child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                          icon: Icon(playState ? Icons.play_arrow : Icons.pause, color: Colors.white,
                          ),
                          iconSize: 50.0,
                          onPressed: () async {
                            print(widget.url);
                            String state = await notificationAudioPlayer.playerState;
                            if (playState == true){
                              if(state == "PAUSED"){
                                await notificationAudioPlayer.removeNotification();
                                print(await notificationAudioPlayer.resume());
                                setState(() {
                                  playState = false;
                                });
                              } else{
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
                        ),
                        widget.repo != 'fav' ?
                        Container(
                          margin: EdgeInsets.only(
                            top: 5.0
                          ),
                          child: IconButton(
                            onPressed: () async {
                              print(widget.user.uid);
                              CollectionReference ref = Firestore.instance.collection('FAVORITOS');
                              try{
                                await ref.document(widget.user.uid).updateData({
                                  'musica': FieldValue.arrayUnion([{
                                   'title': widget.title,
                                    'url': widget.url,
                                    'author': widget.author,
                                    'avatar': widget.avatar,
                                  }])
                                }).whenComplete(() => Fluttertoast.showToast(msg: 'Agregado a favotitos'));
                              }catch (e){
                                Fluttertoast.showToast(msg: e);
                              }
                            },
                            icon: Icon(
                                Icons.format_list_numbered,
                              size: 40.0,
                              color: Colors.white,
                            ),
                            ),

                          ): Container(
                          margin: EdgeInsets.only(
                              top: 5.0
                          ),
                          child: IconButton(
                            onPressed: () async {
                              print(widget.user.uid);
                              CollectionReference ref = Firestore.instance.collection('FAVORITOS');
                              try{
                                await ref.document(widget.user.uid).updateData({
                                  'musica': FieldValue.arrayRemove([{
                                    'title': widget.title,
                                    'url': widget.url,
                                    'author': widget.author,
                                    'avatar': widget.avatar,
                                  }])
                                }).whenComplete(() => Fluttertoast.showToast(msg: 'Eliminado de favotitos'));
                              }catch (e){
                                Fluttertoast.showToast(msg: e);
                              }
                            },
                            icon: Icon(
                              Icons.delete_sweep, 
                              size: 40.0,
                              color: Colors.white,
                            ),
                          ),

                        ),
                      ],
                )
              )
            ],
          )
      ),
    );
  }




}