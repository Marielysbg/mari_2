import 'package:flutter/material.dart';
import 'package:tesis_brainstate/User/model/User.dart';
import 'package:tesis_brainstate/User/ui/widgets/w_yoga_clases.dart';
import 'package:tesis_brainstate/User/ui/widgets/w_yoga_meditar.dart';

class w_yoga extends StatelessWidget{

  User user = new User();
  w_yoga(this.user);
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
                Tab(text: 'Clases'),
                Tab(text: 'Meditación',),
              ],
            ),
            title: Text('¡NAMASTE!'),
            centerTitle: true,
          ),
          body: TabBarView(
            children: [
              w_yoga_clases(user),
              w_yoga_meditar(user)
            ],
          ),
        ),
      ),
    );
  }
}