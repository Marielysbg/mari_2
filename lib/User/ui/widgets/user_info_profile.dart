import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tesis_brainstate/User/model/User.dart';

class userInfoProfile extends StatelessWidget{

  User user = new User();
  userInfoProfile(this.user);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    final name = Container(
      child: Text(
        user.name,
        style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 15.0
        ),
      ),
    );

    final correo = Container(
      margin: EdgeInsets.only(
        top: 5.0
      ),
      child: Text(
        user.email,
        style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 15.0
        ),
      ),
    );

    final telf = Container(
      margin: EdgeInsets.only(
          top: 5.0
      ),
      child: Text(
        user.telf,
        style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 15.0
        ),
      ),
    );

    final user_info = Container(
      margin: EdgeInsets.only(
        left: 25.0,
        top: 20.0
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          name,
          correo,
          telf
        ],
      ),
    );

    final photo =   CircleAvatar(
      radius: 65.0,
      child: ClipOval(
        child: SizedBox(
          width: 120.0,
          height: 120.0,
          child:
          Image.network(
           user.foto,
            fit: BoxFit.cover,
          ),

        ),
      ),
    );

    return Container(
      margin: EdgeInsets.only(
        top: 70.0,
        left: 20.0
      ),
      child: Row(
        //mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          photo,
          user_info
        ],
      ),
    );

  }


}