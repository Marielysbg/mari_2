import 'package:flutter/material.dart';
import 'package:tesis_brainstate/User/ui/screens/dos_registro.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tesis_brainstate/User/model/User.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Registro extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _Registro();
  }

}

class _Registro extends State<Registro> {

  String correo, contra;
  bool _passwordVisible = true;
  final auth = FirebaseAuth.instance;
  User user = new User();
  bool userNameValidate = false;
  bool contraValidate = false;
  TextEditingController userNameController = TextEditingController();
  TextEditingController contraController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    // TODO: implement build



    @override
    void initState() {
      _passwordVisible = false;
      super.initState();
    }

    //VALIDAR INPUT CORREO
    bool validateTextField(String userInput) {
      if (userInput.isEmpty || !userInput.contains('@') || !userInput.contains('.')){
        setState(() {
          userNameValidate = true;
        });
        return false;
      }
      setState(() {
        userNameValidate = false;
      });
      return true;
    }

    //VALIDAR INPUT CONTRASEÑA
    bool validateTextContra(String userinput){
      if(userinput.isEmpty || userinput.length < 7){
        setState(() {
          contraValidate = true;
        });
        return false;
      }
      setState(() {
        contraValidate = false;
      });
      return true;
    }

    final img = Container(
      width: 250.0,
      height: 250.0,
      decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.contain,
              image: NetworkImage("https://blush.design/api/download?shareUri=hpCi5TH7J&c=Hair_0%7E110b05-0.1%7E110b05_Skin_0%7Effd4aa-0.1%7Edb8c5c&w=800&h=800&fm=png")
          )
      ),
    );

    final input_correo = Padding(
      padding: const EdgeInsets.all(20.0),
      child: TextField(
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          hintText: "Correo",
          helperText: 'Example@example.com',
          errorText: userNameValidate ? 'Ingresa un correo valido' : null,
        ),
        controller: userNameController,
      ),
    );

    final input_contra = Padding(
      padding: const EdgeInsets.all(20.0),
      child: TextField(
        controller: contraController,
        obscureText: _passwordVisible,
        decoration: InputDecoration(
            errorText: contraValidate ? 'La contraseña debe tener mas de 8 digitos' : null,
            hintText: "Contraseña",
            suffixIcon: IconButton(
              icon: Icon(
                _passwordVisible
                    ? Icons.visibility
                    : Icons.visibility_off,
              ),
              onPressed: () {
                setState(() {
                  _passwordVisible = !_passwordVisible;
                });
              },
            )
        ),
      ),
    );

    final button = Container(
      width: 250.0,
      height: 50.0,
      margin: EdgeInsets.only(
          top: 50.0,
          bottom: 10.0
      ),
      child: RaisedButton(
        child: Text('Continuar',
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
          if(validateTextField(userNameController.text) && validateTextContra(contraController.text) == true){
            user.email = userNameController.text;
            user.contra = contraController.text;
            registro(user);
          }
        },
      ),
    );

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Registro'),
          backgroundColor: Colors.indigo,
          toolbarHeight: 70.0,
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(
                top: 100.0
            ),
            child: Column(
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

  registro(User user) async{
    try{
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => dos_registro(user)));
    } catch (error){
      Fluttertoast.showToast(msg: error.message, gravity: ToastGravity.TOP);
    }
  }
}
