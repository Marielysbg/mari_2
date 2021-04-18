import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tesis_brainstate/User/model/User.dart';
import 'package:flutter_echarts/flutter_echarts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class screen_graphics_User extends StatefulWidget {
  User user = new User();
  screen_graphics_User(this.user);
  String title="";
//static final String routeName = '/';

  @override
  _screen_graphics_UserState createState() => _screen_graphics_UserState(this.user);

}

class _screen_graphics_UserState extends State<screen_graphics_User> {

  User user = new User();
  _screen_graphics_UserState(this.user);
  String title="12";
  Firestore _firestore = Firestore.instance;






  var data = [0.0, 1.0, 1.5, 2.0, 0.0, 0.0, -0.5, -1.0, -0.5, 0.0, 0.0];
  var data1 = [0.0,-2.0,3.5,-2.0,0.5,0.7,0.8,1.0,2.0,3.0,3.2];



  @override
  Widget build(BuildContext context) {
    String name = user.nombreA;
    return Scaffold(
      appBar: AppBar(
        title: Text('Metricas de  $name '),
        backgroundColor: Colors.indigo,
        actions: <Widget>[
          IconButton(icon: Icon(
              FontAwesomeIcons.chartLine), onPressed: () {
            //
          }),
        ],
      ),
      body: GridView.count(crossAxisCount: 1,
      children: [

        Container(
          margin: EdgeInsets.only(
              top: 10.0,
              bottom: 2.0,
              left: 0.0
          ),
          color: Colors.white,
          child: Echarts(
            option: '''
             {
             title: {
                  text:'netflix'
                  },
    xAxis: {
        type: 'category',
        data: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun']
    },
    yAxis: {
        type: 'value'
    },
    series: [{
        data: [120, 200, 150, 80, 70, 110, 130],
        type: 'bar',
        showBackground: true,
        backgroundStyle: {
            color: 'rgba(180, 180, 180, 0.2)'
        }
    }]
}
          ''',
          ),


        ),

        Container(
          margin: EdgeInsets.only(
              top: 15.0,
              bottom: 30.0,
              left: 0.0
          ),
          color: Colors.white,
          child: Echarts(
            option: '''
             {
             title: {
                  text:'netflix'
                  },
    xAxis: {
        type: 'category',
        data: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun']
    },
    yAxis: {
        type: 'value'
    },
    series: [{
        data: [120, 200, 150, 80, 70, 110, 130],
        type: 'bar',
        showBackground: true,
        backgroundStyle: {
            color: 'rgba(180, 180, 180, 0.2)'
        }
    }]
}
          ''',

          ),



        ),

        Container(
          margin: EdgeInsets.only(
              top: 15.0,
              bottom: 30.0,
              left: 0.0
          ),
          color: Colors.white,
          child: Echarts(
            option: '''
             {
             title: {
                  text:'netflix'
                  },
    xAxis: {
        type: 'category',
        data: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun']
    },
    yAxis: {
        type: 'value'
    },
    series: [{
        data: [120, 200, 150, 80, 70, 110, 130],
        type: 'bar',
        showBackground: true,
        backgroundStyle: {
            color: 'rgba(180, 180, 180, 0.2)'
        }
    }]
}
          ''',
          ),



        ),
      ],)

    );
  }


}



