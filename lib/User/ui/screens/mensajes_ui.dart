import 'package:flutter/material.dart';
import 'package:tesis_brainstate/User/ui/screens/consejo_paciente.dart';
import 'package:tesis_brainstate/User/model/User.dart';
import 'package:tesis_brainstate/User/ui/screens/consejos_pp.dart';

class mensajes_ui extends StatelessWidget{

  bool status = true;
  User user = new User();
  mensajes_ui(this.user);

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
                Tab(text: 'GENERALES'),
                Tab(text: 'PERSONALES',),
              ],
            ),
            title: Text('MENSAJES'),
            centerTitle: true,
          ),
          body: TabBarView(
            children: [
              consejos_paciente(user),
              consejos_pp(user)
            ],
          ),
        ),
        ),
      );
  }
}