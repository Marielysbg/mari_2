import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tesis_brainstate/User/ui/screens/ruta_rol.dart';
import 'package:fluttertoast/fluttertoast.dart';


class sign_in extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _sign_in();
  }

}

class _sign_in extends State<sign_in>{

  String correo, contra;
  final auth = FirebaseAuth.instance;
  bool _passwordVisible = true;
  FirebaseUser user;

  @override

  Widget build(BuildContext context) {
    // TODO: implement build

    final input_correo = Padding(
      padding: const EdgeInsets.all(20.0),
      child: TextField(
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          labelText: "Correo",
        ),
        onChanged: (value){
          setState(() {
            correo = value.trim();
          });
        },
      ),
    );

    final input_contra = Padding(
      padding: const EdgeInsets.all(20.0),
      child: TextField(
        obscureText: _passwordVisible,
        decoration: InputDecoration(
          labelText: "Contraseña",
            suffixIcon: IconButton(
              icon: Icon(
                _passwordVisible
                    ? Icons.visibility
                    :Icons.visibility_off,
              ),
              onPressed: (){
                setState(() {
                  _passwordVisible = !_passwordVisible;
                });
              },
            )
        ),
        onChanged: (value){
          setState(() {
            contra = value.trim();
          });
        },
      ),
    );

    final img = Container(
      width: 350.0,
      height: 350.0,
      decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.contain,
              image: NetworkImage("https://blush.design/api/download?shareUri=JzTG4MCHq&c=Skin_0%7Eca8f67-0.11%7Eca8f67-0.12%7Eb75858-0.13%7Eca8f67&w=800&h=800&fm=png")
          )
      ),
    );

    final button = Container(
      width: 250.0,
      height: 50.0,
      margin: EdgeInsets.only(
          top: 30.0,
          bottom: 10.0
      ),
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
        onPressed: () async{
          buildShowDialog(context);
          handleError(correo, contra);
        },
      ),
    );

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Inicia sesión'),
        backgroundColor: Colors.indigo,
        toolbarHeight: 70.0,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              img,
              input_correo,
              input_contra,
              button
            ],
          ),
        ),
      )
    );
  }

  buildShowDialog(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Center(
            child: CircularProgressIndicator(),
          );
        });
  }

  handleError(String correo, String contra) async {
    try {
      user =
      await auth.signInWithEmailAndPassword(email: correo, password: contra);
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => ruta_rol(user)));
    } catch (error) {
      print(error);
      if (error.message == 'There is no user record corresponding to this identifier. The user may have been deleted.') {
        Fluttertoast.showToast(msg: 'Usuario no registrado');
      } else if (error.message ==
          'The password is invalid or the user does not have a password.') {
        Fluttertoast.showToast(msg: 'Contraseña incorrecta');
      } else if (error.message ==
          'A network error (such as timeout, interrupted connection or unreachable host) has occurred.') {
        Fluttertoast.showToast(msg: 'Conexión inestable');
      } else if (error.message == 'ERROR_TOO_MANY_REQUESTS') {
        Fluttertoast.showToast(msg: 'Demasiados intentos. Intente luego');
      } else
        (Fluttertoast.showToast(msg: 'Error indefinido'));
    }
    print(user.uid);
  }

}