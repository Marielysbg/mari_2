import 'package:flutter/material.dart';
import 'package:tesis_brainstate/Widget/card_image.dart';
import 'package:tesis_brainstate/User/ui/screens/screen_respira.dart';
import 'package:tesis_brainstate/User/ui/screens/NotesScreen.dart';
import 'package:tesis_brainstate/User/model/User.dart';
import 'package:tesis_brainstate/User/ui/screens/soli_psico.dart';
import 'package:tesis_brainstate/User/model/User.dart';

class cardImageListProfile extends StatelessWidget{

  User user = new User();
  cardImageListProfile({Key key, @required this.user});



  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        margin: EdgeInsets.only(
            top: 10.0,
            bottom: 40.0,
          left: 15.0
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
                  width: 160.0,
                  text: 'Diario personal',
                  onTap: (){

                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => NotesScreen(this.user)
                    ));
                  },
                ),
                Container(
                  margin: EdgeInsets.only(
                    left: 10.0
                  ),
                  child:  CardImage(
                    linkImage: 'https://blush.design/api/download?shareUri=Afh-NwFD1&w=800&h=800&fm=png',
                    height: 150.0,
                    width: 160.0,
                    text: 'Favoritos',
                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => screen_respira()
                      ));
                    },
                  ),
                ),
              ],
            ),
            Row(
              children: [
                CardImage(
                  linkImage: 'https://blush.design/api/download?shareUri=XQMeVJiJO&w=800&h=800&fm=png',
                  height: 150.0,
                  width: 160.0,
                  text: 'Mi psicologo',
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => soli_psico(user)
                    ));
                  },
                ),
                Container(
                    margin: EdgeInsets.only(
                        left: 10.0
                    ),
                  child: CardImage(
                    linkImage: 'https://blush.design/api/download?shareUri=YNhzKS3Lh&w=800&h=800&fm=png',
                    height: 150.0,
                    width: 160.0,
                    text: 'Rutinas',
                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => screen_respira()
                      ));
                    },
                  ),
                )

              ],
            )
          ],
        )
    );
  }


}