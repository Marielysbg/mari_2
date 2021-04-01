import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tesis_brainstate/User/ui/screens/sign_in.dart';
import 'package:tesis_brainstate/User/ui/screens/Registro.dart';

class Login_Screen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _Login_Screen();
  }

}

class _Login_Screen extends State<Login_Screen>{

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    final text_titulo = Container(
      margin: EdgeInsets.only(
        top: 80.0
      ),
      child: Column(
        //mainAxisAlignment:  MainAxisAlignment.center,
        //crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Bienvenido a',
            style: TextStyle(
              fontSize: 20.0,
            ),
          ),
          Text('BrainState',
          style: TextStyle(
            fontSize: 30.0,
              fontWeight: FontWeight.bold,
            color: Colors.black
          ),
            )
        ],
      ),
    );

    final img = Container(
      margin: EdgeInsets.only(
        top: 90.0
      ),
      width: 300.0,
      height: 300.0,
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.contain,
          image: NetworkImage("https://blush.design/api/download?shareUri=U7HhfP_Su&c=Clothes_0%7Effbcbf-0.1%7E323c84_Hair_0%7Ee27955-0.1%7E240000_Skin_0%7Ee88f70-0.1%7Effbf94&w=800&h=800&fm=png")
        )
      ),
    );

    final button = Container(
      margin: EdgeInsets.only(
        top: 80.0
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            width: 300.0,
            height: 50.0,
            child: RaisedButton(
              child: Text('Iniciar sesión',
              style: TextStyle(
                fontSize: 16.0
              ),
              ),
              elevation: 5.0,
              color: Colors.indigo,
              textColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0)
              ),
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => sign_in()),
                );
              },
            ),
          ),
          Container(
            margin: EdgeInsets.only(
                top: 20.0
            ),
            width: 300.0,
            height: 50.0,
            child: RaisedButton(
              child: Text('Registrar',
              style: TextStyle(
                fontSize: 16.0
              ),
              ),
              elevation: 5.0,
              color: Colors.white,
              textColor: Colors.indigo,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                  side: BorderSide(color: Colors.indigo)
              ),
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => Registro()),);
              },
            ),
          )
        ],
      ),
    );

    return Scaffold(
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            text_titulo,
            img,
            button
          ],
        ),
      ),
    );
  }

}