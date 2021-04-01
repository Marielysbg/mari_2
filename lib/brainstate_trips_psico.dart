import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tesis_brainstate/Psico/edit_psico.dart';
import 'package:tesis_brainstate/Psico/home_psico.dart';
import 'package:tesis_brainstate/Psico/profile_psico.dart';
import 'package:tesis_brainstate/User/model/User.dart';
import 'package:tesis_brainstate/Psico/notificaciones_screen.dart';


class brainstate_trips_psico extends StatefulWidget{


  FirebaseUser user;
  User userr = new User();
  brainstate_trips_psico(this.user, this.userr);



  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _brainstate_trips_psico();
  }
}

class _brainstate_trips_psico extends State<brainstate_trips_psico>{

  int indextap = 0;

  void onTapTapped(int index){
    setState(() {
      indextap = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    final List widgetsChildren = [
      home_psico(widget.userr, widget.user),
      edit_psico(),
      notificaciones_screen(widget.userr, widget.user),
      profile_psico(widget.userr)
    ];

    return Scaffold(
        body: widgetsChildren[indextap],
        bottomNavigationBar: (Theme(
            data: Theme.of(context).copyWith(
                canvasColor: Colors.white,
            ),
            child:
            BottomNavigationBar(
              selectedItemColor: Colors.indigo,
              unselectedItemColor: Colors.black26,
              onTap: onTapTapped,
              currentIndex: indextap,
              //selectedFontSize: 0,
              items: [
                BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    title: Text("Home")
                ),
                BottomNavigationBarItem(
                    icon: Icon(Icons.show_chart),
                    title: Text("Estadísticas")
                ),
               BottomNavigationBarItem(
                  icon: Icon(Icons.notifications),
                  title: Text("Solicitudes")
               ),
                BottomNavigationBarItem(
                    icon: Icon(Icons.person),
                    title: Text("Perfil")
                ),
              ],
            )
        )
        )
    );

  }


}