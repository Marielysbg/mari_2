import 'package:flutter/material.dart';
import '../widgets/header_home_user.dart';
import 'package:tesis_brainstate/Widget/emoji_feedback.dart';
import 'package:tesis_brainstate/User/ui/widgets/card_image_list.dart';
import 'package:tesis_brainstate/Widget/card_repository.dart';


class home_user extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    final text = Container(
      margin: EdgeInsets.only(
          left: 20.0,
          bottom: 20.0,
          top: 20.0
      ),
      child: Text(
        'Nuestro repositorio',
        style: TextStyle(
            color: Colors.black,
            fontSize: 20.0,
            fontWeight: FontWeight.bold
        ),
      ),
    );

    final text2 = Container(
      margin: EdgeInsets.only(
          left: 20.0,
          top: 20.0
      ),
      child: Text(
        'Cambia tu rutina',
        style: TextStyle(
            color: Colors.black,
            fontSize: 20.0,
            fontWeight: FontWeight.bold
        ),
      ),
    );

    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          headerHomeUser('¡RESPIRA!', 'Todo estará bien'),
          emoji_feedback(),
          text,
          SizedBox(
            height: 120.0,
            child: ListView(
              scrollDirection: Axis.horizontal,
              physics: ClampingScrollPhysics(),
              shrinkWrap: true,
              children: [
                Container(
                  margin: EdgeInsets.only(
                    left: 10.0,
                  ),
                  child: card_repository(
                      title: 'Música',
                      icon: Icon(Icons.library_music),
                      sub: 'Escucha nuestro repositorio de música',
                    onTap: (){},
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    left: 10.0
                  ),
                  child: card_repository(
                      title: 'Videos',
                      icon: Icon(Icons.video_library),
                      sub: 'Relajate con los videos que preparamos para ti',
                    onTap: (){},
                  ),
                ),
              ],
            ),
          ),
          text2,
          card_image_list()
        ],
      ),
    );

  }

}