import 'package:flutter/material.dart';
import 'package:tesis_brainstate/User/ui/widgets/header_profile.dart';
import 'package:tesis_brainstate/User/ui/widgets/card_imagelist_profile.dart';
import 'package:tesis_brainstate/User/model/User.dart';


class profile_screen extends StatelessWidget{

  profile_screen({Key key, @required this.user});
  User user = new User();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

   return ListView(
     children: [
       headerprofile(user),
       cardImageListProfile(user: user,)
     ],
   );
  }

}