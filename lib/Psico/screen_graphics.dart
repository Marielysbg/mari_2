import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tesis_brainstate/User/model/User.dart';
import 'package:flutter_echarts/flutter_echarts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class screen_graphics extends StatelessWidget {
  User user = new User();

  screen_graphics(this.user);

  CollectionReference ref = Firestore.instance.collection('PSICOLOGOS');

  String title = "";

//static final String routeName = '/';

  static const String _title = 'Métricas';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_title),
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
      body: _screen_graphics(this.user),
    );
  }
}

class _screen_graphics extends StatefulWidget {
  User user = new User();

  _screen_graphics(this.user);

  @override
  _screen_graphics_state createState() => _screen_graphics_state(this.user);
}

class _screen_graphics_state extends State<_screen_graphics> {
  User user = new User();

  _screen_graphics_state(this.user);

  final Firestore _firestore = Firestore.instance;

  Future<Map<String, dynamic>> _calculation() async {
    var psicologo =
        await _firestore.collection('PSICOLOGOS').document(user.uid).get();
    int QTY_estres = 0;
    int QTY_ansiedad = 0;
    int QTY_panico = 0;
    int QTY_depresion = 0;
    int QTY_otras = 0;
    int QTY_Mujer = 0;
    int QTY_Hombre = 0;
    int QTY_SexOtro = 0;

    int QTY_Menor18 = 0;
    int QTY_Menor35 = 0;
    int QTY_Menor50 = 0;
    int QTY_Mayor50 = 0;

    if (psicologo != null) {
      for (var userA in psicologo.data['Aceptados']) {
        var cuadro = userA['CuadroC'];
        var sexo = userA['sexoU'];
        int edad = userA['fechaNU'] != null
            ? getAge(new DateFormat.yMd('en_US').parse(userA['fechaNU']))
            : -1;
        print(edad);
        switch (cuadro) {
          case 'ansiedad':
            QTY_ansiedad += 1;
            break;
          case 'depresion':
            QTY_depresion += 1;
            break;
          case 'panico':
            QTY_panico += 1;
            break;
          case 'estres':
            QTY_estres += 1;
            break;
          default:
            QTY_otras += 1;
        }

        switch (sexo) {
          case 'Mujer':
            QTY_Mujer += 1;
            break;
          case 'Hombre':
            QTY_Hombre += 1;
            break;
          default:
            QTY_SexOtro += 1;
        }

        if (edad < 18) {
          QTY_Menor18 += 1;
        } else if (edad < 35) {
          QTY_Menor35 += 1;
        } else if (edad < 50) {
          QTY_Menor50 += 1;
        } else {
          QTY_Mayor50 += 1;
        }
      }
    }

    return {
      'counters': {
        'ansiedad': QTY_ansiedad,
        'panico': QTY_panico,
        'estres': QTY_estres,
        'depresion': QTY_depresion,
        'otros': QTY_otras,
        'Mujer': QTY_Mujer,
        'Hombre': QTY_Hombre,
        'SexOtro': QTY_SexOtro,
        'menor18': QTY_Menor18,
        'menor35': QTY_Menor35,
        'menor50': QTY_Menor50,
        'mayor50': QTY_Mayor50,
      }
    };
  }

  final getAge =
      (DateTime from) => (DateTime.now().difference(from).inDays / 365).floor();

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
                        text:'Cuadro Clinico'
                        },
                        xAxis: {
                            type: 'category',
                            data: ['Ansiedad', 'Depresión', 'Pánico', 'Estrés']
                        },
                        yAxis: {
                            type: 'value'
                        },
                        series: [{
                            data: [ ${snapshot.data['counters']['ansiedad']}, 
                                    ${snapshot.data['counters']['depresion']}, 
                                    ${snapshot.data['counters']['panico']}, 
                                    ${snapshot.data['counters']['estres']}, 
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
                         legend: {
        data: ['Mujer', 'Hombre', 'Otros'],
        bottom: 10
    },
                        series: [{
                            data: [{value: ${snapshot.data['counters']['Mujer']}, name: 'Mujer'}, 
                                    {value:${snapshot.data['counters']['Hombre']}, name: 'Hombre'}, 
                                    {value:${snapshot.data['counters']['SexOtro']}, name: 'Otros'}, 
                                  ],
                            type: 'pie',
                            showBackground: true,
                            label: {
                show: false,
                position: 'center'
            },
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
                        text:'Agrupado por edades'
                        },
                        xAxis: {
                            type: 'category',
                            data: ['0 - 17', '18 - 35', '36 - 50', '> 50']
                        },
                        yAxis: {
                            type: 'value'
                        },
                        series: [{
                            data: [ ${snapshot.data['counters']['menor18']}, 
                                    ${snapshot.data['counters']['menor35']}, 
                                    ${snapshot.data['counters']['menor50']}, 
                                     ${snapshot.data['counters']['mayor50']}, 
                                  ],
                            type: 'line',
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
