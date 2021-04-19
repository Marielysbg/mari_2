import 'package:flutter/material.dart';
import 'package:tesis_brainstate/User/ui/screens/screen_escuchaMusica.dart';
import 'package:tesis_brainstate/User/ui/screens/screen_relajate.dart';
import 'package:tesis_brainstate/Widget/card_image.dart';
import 'package:tesis_brainstate/User/ui/screens/screen_respira.dart';
import 'package:tesis_brainstate/User/ui/screens/screen_yoga.dart';
import 'package:tesis_brainstate/User/model/User.dart';

class card_image_list extends StatelessWidget{

  User user = new User();
  card_image_list(this.user);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        margin: EdgeInsets.only(
          top: 10.0,
          bottom: 40.0
        ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              CardImage(
                linkImage: 'https://blush.design/api/download?shareUri=mzqGorML3&s=0%7Eca8f67&w=800&h=800&fm=png',
                height: 190.0,
                width: 180.0,
                text: '¡Respira!',
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => screen_respira(user)
                  ));
                },
              ),
              CardImage(
                linkImage: 'https://blush.design/api/download?shareUri=j3lwVkIhB&s=0.7%7Ef6cbc3&w=800&h=800&fm=png',
                height: 190.0,
                width: 180.0,
                text: 'Yoga',
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => screen_yoga(user)
                  ));
                },
              ),
            ],
          ),
          Row(
            children: [
              CardImage(
                linkImage: 'https://blush.design/api/download?shareUri=Eo8SHqLRz&w=800&h=800&fm=png',
                height: 190.0,
                width: 180.0,
                text: 'Escucha música',
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => screen_escuchaMusica(user)
                  ));
                },
              ),
              CardImage(
                linkImage: 'https://blush.design/api/download?shareUri=l5K_aCLUA&s=0.1%7Eeedab7&w=800&h=800&fm=png',
                height: 190.0,
                width: 180.0,
                text: 'Relájate',
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => screen_relajate(user)
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