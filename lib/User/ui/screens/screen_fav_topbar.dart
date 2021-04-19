import 'package:flutter/material.dart';
import 'package:tesis_brainstate/User/model/User.dart';
import 'package:tesis_brainstate/User/ui/screens/screen_fav_musica.dart';
import 'package:tesis_brainstate/User/ui/screens/screen_favorito.dart';
import 'package:tesis_brainstate/User/ui/widgets/w_yoga_clases.dart';
import 'package:tesis_brainstate/User/ui/widgets/w_yoga_meditar.dart';

class screen_fav_topbar extends StatelessWidget{

  User user = new User();
  screen_fav_topbar(this.user);
  bool status = true;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back,
                color: Colors.white,
              ),
              onPressed: (){
                Navigator.pop(context);
              },
            ),
            backgroundColor: Colors.indigo,
            bottom: TabBar(
              tabs: [
                Tab(text: 'Videos'),
                Tab(text: 'Musica',),
              ],
            ),
            title: Text('FAVORITOS'),
            centerTitle: true,
          ),
          body: TabBarView(
            children: [
              screen_favorito(user),
              screen_fav_musica(user)
            ],
          ),
        ),
      ),
    );
  }
}