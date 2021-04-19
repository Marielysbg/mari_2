import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tesis_brainstate/User/model/User.dart';
import 'package:flutter_echarts/flutter_echarts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';


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





  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Métricas del paciente"),
        backgroundColor: Colors.indigo,
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: <Widget>[
          IconButton(
              icon: Icon(FontAwesomeIcons.chartLine),
              onPressed: () {
                //
              }),
        ],
      ),
      body: _screen_graphics_data(this.user),
    );

  }


}


class _screen_graphics_data extends StatefulWidget {
  User user = new User();

  _screen_graphics_data(this.user);

  @override
  _screen_graphics_state createState() => _screen_graphics_state(this.user);
}

class _screen_graphics_state extends State<_screen_graphics_data> {
  User user = new User();

  _screen_graphics_state(this.user);

  final Firestore _firestore = Firestore.instance;

  Future<Map<String, dynamic>> _calculation() async {
    var session =
    await _firestore.collection('Session').where("userid" ,  isEqualTo: this.user.idA).getDocuments();
    int QTY_terrible = 0;
    int QTY_bad = 0;
    int QTY_ok = 0;
    int QTY_good = 0;
    int QTY_awesome = 0;

    int QTY_Mujer = 0;
    int QTY_Hombre = 0;
    int QTY_SexOtro = 0;

    int QTY_Menor3 = 0;
    int QTY_Menor7 = 0;
    int QTY_Menor14 = 0;
    int QTY_Mayor15 = 0;

    if (session != null) {

      for (var userA in session.documents) {
        int qty_days = userA['fecha'] != null
            ? getDays(new DateFormat('dd-MM-yyyy').parse(userA.data['fecha']))
            : -1;

        if (qty_days < 3) {
          QTY_Menor3 += 1;
        } else if (qty_days < 7) {
          QTY_Menor7 += 1;
        } else if (qty_days < 14) {
          QTY_Menor14 += 1;
        } else {
          QTY_Mayor15 += 1;
        }
      }
    }

    var emociones =
    await _firestore.collection('EMOCIONES').document(this.user.idA).get();

    if (emociones != null) {

      for (var userA in emociones.data['Emociones']) {
        var emocion = userA['emocion'];
        int days = userA['fecha'] != null
            ? getDays(new DateFormat('dd-MM-yyyy').parse(userA['fecha']))
            : -1;

        if (days<7) {
          switch (emocion) {
            case 'terrible':
              QTY_terrible += 1;
              break;
            case 'bad':
              QTY_bad += 1;
              break;
            case 'ok':
              QTY_ok += 1;
              break;
            case 'good':
              QTY_good += 1;
              break;
            default:
              QTY_awesome += 1;
          }
        }
      }
    }

    return {
      'counters': {
        'terrible': QTY_terrible,
        'bad': QTY_bad,
        'ok': QTY_ok,
        'good': QTY_good,
        'awesome': QTY_awesome,
        'Mujer': QTY_Mujer,
        'Hombre': QTY_Hombre,
        'SexOtro': QTY_SexOtro,
        'menor3': QTY_Menor3,
        'menor7': QTY_Menor7,
        'menor14': QTY_Menor14,
        'mayor15': QTY_Mayor15,
      }
    };
  }

  final getDays =
      (DateTime from) => (DateTime.now().difference(from).inDays ).floor();

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: Theme.of(context).textTheme.headline2,
      textAlign: TextAlign.center,
      child: FutureBuilder<Map<String, dynamic>>(
        future: _calculation(), // a previously-obtained Future<String> or null
        builder: (BuildContext context,
            AsyncSnapshot<Map<String, dynamic>> snapshot) {
          List<Widget> children;
          if (snapshot.hasData) {
            children = <Widget>[
              /*const Icon(
                Icons.check_circle_outline,
                color: Colors.green,
                size: 60,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text('Result: ${snapshot.data}'),
              )*/

              Container(
                margin: EdgeInsets.only(top: 10.0, bottom: 2.0, left: 0.0),
                color: Colors.white,
                child: Echarts(
                  option: '''
                   {
                   title: {
                        text:'Emociones de la ultima semana'
                        },
                        xAxis: {
                            type: 'category',
                            data: ['Terrible', 'Bad', 'Ok', 'Good', 'Awesome'],
                            axisLabel: { interval: 0, rotate: 40 },
                        },
                        yAxis: {
                            type: 'value'
                        },
                        series: [{
                            data: [ ${snapshot.data['counters']['terrible']}, 
                                    ${snapshot.data['counters']['bad']}, 
                                    ${snapshot.data['counters']['ok']}, 
                                    ${snapshot.data['counters']['good']}, 
                                    ${snapshot.data['counters']['awesome']}, 
                                  ],
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
                margin: EdgeInsets.only(top: 10.0, bottom: 2.0, left: 0.0),
                color: Colors.white,
                child: Echarts(
                  option: '''
                   {
                   title: {
                        text:'Género'
                        },
                        xAxis: {
                            type: 'category',
                            data: ['Mujer', 'Hombre', 'Otro']
                        },
                        yAxis: {
                            type: 'value'
                        },
                        series: [{
                            data: [ ${snapshot.data['counters']['Mujer']}, 
                                    ${snapshot.data['counters']['Hombre']}, 
                                    ${snapshot.data['counters']['SexOtro']}, 
                                  ],
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
                margin: EdgeInsets.only(top: 10.0, bottom: 2.0, left: 0.0),
                color: Colors.white,
                child: Echarts(
                  option: '''
                   {
                   title: {
                        text:'Fecuencia de uso por rango de dias'
                        },
                        xAxis: {
                            type: 'category',
                            data: [ '> 15', '8 - 14', '4 - 7','0 - 3']
                        },
                        yAxis: {
                            type: 'value'
                        },
                        series: [{
                            data: [ ${snapshot.data['counters']['mayor15']}, 
                             ${snapshot.data['counters']['menor14']}, 
                               ${snapshot.data['counters']['menor7']}, 
                             ${snapshot.data['counters']['menor3']}, 
                               
                                  ],
                            type: 'line',
                            smooth: true,
                            showBackground: true,
                            backgroundStyle: {
                                color: 'rgba(180, 180, 180, 0.2)'
                            }
                        }]
                    }
                ''',
                ),
              ),
            ];
          } else if (snapshot.hasError) {
            children = <Widget>[
              const Icon(
                Icons.error_outline,
                color: Colors.red,
                size: 60,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text('Error: ${snapshot.error}'),
              )
            ];
          } else {
            children = const <Widget>[
              SizedBox(
                child: CircularProgressIndicator(),
                width: 60,
                height: 60,
              ),
              Padding(
                padding: EdgeInsets.only(top: 16),
                child: Text('Cargando...'),
              )
            ];
          }
          return GridView.count(crossAxisCount: 1, children: children);
        },
      ),
    );
  }
}



