import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:tesis_brainstate/Widget/floating_action_button.dart';

class videosRepository extends StatefulWidget{

  final String title;
  final url;
  final subtitle;

  videosRepository({Key key, @required this.title, @required this.url, this.subtitle});

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

  bool buttonState = false;
  bool get wantKeepAlive => true;

  void onPressedFav() {
    setState(() {
      buttonState = !this.buttonState;
    });
  }

  @override
  Widget build(BuildContext context) {

   return Scaffold(
     floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
     floatingActionButton: FloatingActionButton(
       backgroundColor: Color(0xFF11DA53),
       mini: false,
       tooltip: "Fav",
       onPressed: onPressedFav,
       child: Icon(
           this.buttonState ? Icons.favorite : Icons.favorite_border
       ),
       heroTag: null,
     ),
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
                 fontSize: 15.0
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
         )
       ],
     )
   );


  }

}
