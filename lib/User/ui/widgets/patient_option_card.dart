import 'package:flutter/material.dart';
import 'package:tesis_brainstate/Widget/card_image.dart';
import 'package:tesis_brainstate/User/ui/screens/screen_respira.dart';
import 'package:tesis_brainstate/User/ui/screens/NotesScreenPsicologo.dart';
import 'package:tesis_brainstate/User/ui/screens/screen_Chat_User.dart';
import 'package:tesis_brainstate/User/model/User.dart';
import 'package:tesis_brainstate/User/ui/screens/soli_psico.dart';
import 'package:tesis_brainstate/User/model/User.dart';
import 'package:tesis_brainstate/User/ui/screens/Screen_graphics_User.dart';


class patient_option_card extends StatelessWidget{

  User user = new User();
  patient_option_card({Key key, @required this.user});



  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        margin: EdgeInsets.only(
            top: 10.0,
            bottom: 40.0,
            left: 40.0
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                CardImage(
                  linkImage: 'https://blush.design/api/download?shareUri=YGMWyZaeP&s=0%7Eecafa3&w=800&h=800&fm=png',
                  height: 150.0,
                  width: 250.0,
                  text: 'Notas del paciente',
                  onTap: (){

                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => NotesScreenPsicologo(this.user)
                    ));
                  },
                ),

              ],
            ),
            Row(
              children: [
                  CardImage(
                    linkImage: 'https://blush.design/api/download?shareUri=Fj1MhDoeH&w=800&h=800&fm=png',
                    height: 150.0,
                    width: 250.0,
                    text: 'Chat',
                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => screen_Chat_User(user)
                      ));
                    },
                  ),


              ],
            ),
            Row(
              children: [
                CardImage(
                  linkImage: 'https://blush.design/api/download?shareUri=jfO3_vOJgr&w=800&h=800&fm=png',
                  height: 150.0,
                  width: 250.0,
                  text: 'Métricas',
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => screen_graphics_User(user)
                    ));
                  },
                ),


              ],
            )
          ],
        )
    );
  }


}