import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tesis_brainstate/User/model/User.dart';
import 'package:flutter_echarts/flutter_echarts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class screen_graphics extends StatelessWidget {
  User user = new User();
  screen_graphics(this.user);

  String title = "";

//static final String routeName = '/';



    @override
    Widget build(BuildContext context) {
      return Scaffold(
          appBar: AppBar(
            title: Text('Metricas'),
            backgroundColor: Colors.indigo,
            centerTitle: true,
            automaticallyImplyLeading: false,
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


