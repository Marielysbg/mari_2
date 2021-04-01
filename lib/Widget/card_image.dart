import 'package:flutter/material.dart';

class CardImage extends StatefulWidget{

  final VoidCallback onTap;
  final linkImage;
  final String text;
  final double height;
  final double width;


  CardImage({Key key, @required this.linkImage, @required this.width, @required this.height, @required this.text, @required this.onTap});


  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _CardImage();
  }
}

class _CardImage extends State<CardImage>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
   return Container(

        child: GestureDetector(
          //MÉTODO ON TAP
          onTap: widget.onTap,
          child: Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            margin: EdgeInsets.only(
              top: 15.0,
              left: 11.0
            ),
            elevation: 10,
            child: Column(
              children: [
                FadeInImage(
                  image: NetworkImage(
                    //IMAGEN PRINCIPAL
                      widget.linkImage
                  ),
                  placeholder: AssetImage(
                      'assets/img/loading.gif'
                  ),
                  fit: BoxFit.scaleDown,
                  height: widget.height,
                  width: widget.width,
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Text(
                        //TEXTO PRINCIPAL
                        widget.text,
                        style: TextStyle(
                          fontSize: 15.0,
                          //fontWeight: FontWeight.bold
                        ),
                      ),
                    ],
                  )
                )
              ],
            ),
          ),
        )
    );
  }

}