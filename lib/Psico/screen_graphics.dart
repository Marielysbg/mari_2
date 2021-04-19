import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
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

    if (psicologo != null) {
      for (var userA in psicologo.data['Aceptados']) {
        var cuadro = userA['CuadroC'];
        var sexo = userA['sexoU'];

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
      }
    };
  }

  /* = Future<Map<String, dynamic>>.delayed(
    const Duration(seconds: 2),
        () => 'Data Loaded',
  );*/

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
