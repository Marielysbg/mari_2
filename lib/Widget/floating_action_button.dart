import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class FloatingActionButtonGreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _FloatingActionButtonGreen();
  }

}

class _FloatingActionButtonGreen extends State <FloatingActionButtonGreen> with AutomaticKeepAliveClientMixin{

  bool buttonState = false;
  bool get wantKeepAlive => true;

  void onPressedFav() {
    setState(() {
      buttonState = !this.buttonState;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return FloatingActionButton(
      backgroundColor: Color(0xFF11DA53),
      mini: true,
      tooltip: "Fav",
      onPressed: onPressedFav,
      child: Icon(
        this.buttonState ? Icons.favorite : Icons.favorite_border
      ),
      heroTag: null,

    );

  }
}
