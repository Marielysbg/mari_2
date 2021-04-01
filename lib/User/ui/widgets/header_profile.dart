import 'package:flutter/material.dart';
import 'package:tesis_brainstate/Widget/gradient_back.dart';
import 'package:tesis_brainstate/User/ui/widgets/user_info_profile.dart';
import 'package:tesis_brainstate/User/model/User.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tesis_brainstate/User/ui/screens/Login_Screen.dart';


class headerprofile extends StatelessWidget{

  User user = new User();
  headerprofile(this.user);
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    void _showAlertDialog() {
      showDialog(
          context: context,
          builder: (buildcontext) {
            return AlertDialog(
              title: Text("¿Desea salir de la aplicación?"),
              content: Text("Presione cancelar para volver"),
              actions: <Widget>[
                    FlatButton(
                      child:
                      Text("Cancelar",
                        style: TextStyle(
                            color: Colors.blue
                        ),
                      ),
                      onPressed: (){ Navigator.of(context).pop(); },
                    ),
                FlatButton(
                  child:
                  Text("Salir",
                    style: TextStyle(
                        color: Colors.blue
                    ),
                  ),
                  onPressed: (){ auth.signOut().whenComplete(() =>  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => Login_Screen()))); },
                ),
              ],
            );
          }
      );
    }

    final text = Container(
      margin: EdgeInsets.only(
          top: 30.0,
          left: 40.0
      ),
      child: Text(
        "Perfil",
        style: TextStyle(
            color: Colors.white,
            fontSize: 30.0
        ),
      ),
    );

    final salir = Container(
      margin: EdgeInsets.only(
        top: 15.0,
        left: 350.0
      ),
      child: IconButton(
        icon: Icon(Icons.exit_to_app),
        color: Colors.white,
        onPressed: (){
          _showAlertDialog();
        },
      )
    );

    return Container(
      child: Stack(
        children: [
          TopGradientBox(height: 250.0),
         salir,
          text,
          userInfoProfile(user)
        ],
      ),
    );
  }


}