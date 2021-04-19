import 'package:flutter/material.dart';
import 'package:tesis_brainstate/User/ui/screens/edit_profile_paciente.dart';
import 'package:tesis_brainstate/User/ui/widgets/header_profile.dart';
import 'package:tesis_brainstate/User/ui/widgets/card_imagelist_profile.dart';
import 'package:tesis_brainstate/User/model/User.dart';


class profile_screen extends StatelessWidget{

  profile_screen({Key key, @required this.user});
  User user = new User();



  @override


  Widget build(BuildContext context) {
    // TODO: implement build

    final edit = Container(
        margin: EdgeInsets.only(
            top: 1.0,
            left: 350.0
        ),
        child: RaisedButton(
          child: Text(
            'Editar perfil',
            style: TextStyle(
                color: Colors.white
            ),
          ),
          color: Colors.indigo,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
              side: BorderSide(color: Colors.white)
          ),
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => edit_profile_paciente(user)));
          },
        )
    );

   return ListView(
     children: [
       Stack(
         children: [
           headerprofile(user, 260.0),
           Positioned(
             top: 185.0,
             right: 115.0,
             child: edit,
           ),
         ],
       ),
       cardImageListProfile(user: user,)
     ],
   );
  }

}