import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tesis_brainstate/User/model/User.dart';
import 'package:fluttertoast/fluttertoast.dart';

class videosRepository extends StatefulWidget{

  final String title;
  final url;
  final subtitle;
  final repo;
  User user = new User();

  videosRepository({Key key, @required this.title, @required this.url, @required this.subtitle, @required this.repo, @required this.user});


  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _videosRepository();
  }
}

class _videosRepository extends State<videosRepository>{

  YoutubePlayerController _controller;

  void runYoutubePlayer(){
    _controller = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(widget.url),
      flags: YoutubePlayerFlags(
      enableCaption: false,
      isLive: false,
        autoPlay: false,
          disableDragSeek: true,
      ),

    );
  }

  @override
  void initState() {
    runYoutubePlayer();
    super.initState();
  }

  @override
  void deactivate() {
    _controller.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  bool get wantKeepAlive => true;


  @override
  Widget build(BuildContext context) {

    Stream<DocumentSnapshot> courseDocStream = Firestore.instance.collection(
        'REPOSITORIOS').document(widget.repo).snapshots();

   return Scaffold(
       appBar: AppBar(
         title: Text('Repositorio'),
         centerTitle: true,
         backgroundColor: Colors.indigo,
         leading: IconButton(
           onPressed: (){
             Navigator.pop(context);
           },
           icon: Icon(Icons.arrow_back),
         ),
       ),
       body: Column(
         crossAxisAlignment: CrossAxisAlignment.start,
         children: [
           Container(
             margin: EdgeInsets.only(
                 bottom: 10.0
             ),
             child: YoutubePlayerBuilder(
               player: YoutubePlayer(
                 controller: _controller,
               ),
               builder: (context, player){
                 return player;
                 },
             ),
           ),
           Container(
             padding: EdgeInsets.all(20.0),
             child: Text(
               widget.title,
               maxLines: 3,
               style: TextStyle(
                   color: Colors.black,
                   fontWeight: FontWeight.bold,
                   fontSize: 17.0
               ),
             ),
           ),
           Container(
             margin: EdgeInsets.only(
                 left: 20.0,
                 right: 20.0
             ),
             child: Text(
               widget.subtitle,
               maxLines: 3,
               style: TextStyle(
                   color: Color(0xFF757575),
                   fontSize: 15.0
               ),
             ),
           ),
           widget.repo != 'fav' ? Container(
               margin: EdgeInsets.only(
                   top: 20.0,
                 left: 20.0
               ),
               width: 200.0,
               height: 50.0,
             child: RaisedButton(
               elevation: 5.0,
               color: Colors.white,
               textColor: Colors.indigo,
               shape: RoundedRectangleBorder(
                   borderRadius: BorderRadius.circular(18.0),
                   side: BorderSide(color: Colors.indigo)
               ),
               child: Text(
                 'Agregar a favoritos',
                 style: TextStyle(
                     fontSize: 16.0
                 ),
               ),
               onPressed: () async {
                 print(widget.user.uid);
                 CollectionReference ref = Firestore.instance.collection('FAVORITOS');
               try{
                 await ref.document(widget.user.uid).updateData({
                   'video': FieldValue.arrayUnion([{
                     'subtitle': widget.subtitle,
                     'title': widget.title,
                     'url': widget.url,
                   }])
                 }).whenComplete((){
                   //Navigator.pop(context);
                   Fluttertoast.showToast(msg: 'Agregado a favoritos');
                 });
               } catch(e){
                 Fluttertoast.showToast(msg: e);
               }
               },
             ),
           ): Container(
             margin: EdgeInsets.only(
                 top: 20.0,
                 left: 20.0
             ),
             width: 200.0,
             height: 50.0,
             child: RaisedButton(
               elevation: 5.0,
               color: Colors.white,
               textColor: Colors.indigo,
               shape: RoundedRectangleBorder(
                   borderRadius: BorderRadius.circular(18.0),
                   side: BorderSide(color: Colors.indigo)
               ),
               child: Text(
                 'Eliminar de favoritos',
                 style: TextStyle(
                     fontSize: 16.0
                 ),
               ),
               onPressed: () async {
                 print(widget.user.uid);
                 CollectionReference ref = Firestore.instance.collection('FAVORITOS');
                 try{
                   await ref.document(widget.user.uid).updateData({
                     'video': FieldValue.arrayRemove([{
                       'subtitle': widget.subtitle,
                       'title': widget.title,
                       'url': widget.url,
                     }])
                   }).whenComplete((){
                     //Navigator.pop(context);
                     Fluttertoast.showToast(msg: 'Eliminado de favoritos');
                     Navigator.pop(context);
                   });
                 } catch(e){
                   Fluttertoast.showToast(msg: e);
                 }
               },
             ),
           )
         ],
       )
   );
  }
}


