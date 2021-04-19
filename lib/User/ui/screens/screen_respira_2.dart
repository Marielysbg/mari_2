import 'package:flutter/material.dart';
import 'package:tesis_brainstate/User/ui/widgets/w_respira.dart';
import 'package:tesis_brainstate/User/ui/widgets/w_yoga.dart';
import 'package:tesis_brainstate/User/model/User.dart';


class screen_respira_dos extends StatelessWidget{

  User user = new User();
  screen_respira_dos(this.user);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Técnicas de respiración'),
        centerTitle: true,
        toolbarHeight: 70.0,
        backgroundColor: Colors.indigo,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    margin: EdgeInsets.only(
                        top: 30.0,
                      bottom: 20.0,
                      left: 20.0,
                      right: 20.0
                    ),
                    child: Text(
                      'Paso a paso de cómo realizar correctamente los ejercicios de respiración',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 17.0
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Text(
                    '1. Respiración con labios fruncidos:',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 17.0
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                      left: 20.0,
                      right: 20.0
                  ),
                  child: Text(
                    '- Inspirar lentamente por la nariz. \n\n- Aguantar el aire 2-3 segundos, si se puede. \n\n- Soplar lentamente frunciendo los labios.',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: Color(0xFF757575),
                      fontSize: 17.0,
                    ),
                  ),
                ),
                Center(
                  child:  Container(
                    height: 250.0,
                    width: 350.0,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(
                                'https://fisiofine.com/wp-content/uploads/2020/04/ejercicios-fisioterapia-respiratoria-labios-fruncidos.png'
                            )
                        )
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Text(
                    '2. Respiración abdominal o diafragmática:',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 17.0
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                      left: 20.0,
                      right: 20.0
                  ),
                  child: Text(
                    '- Paciente tumbado boca arriba con piernas flexionadas o tambien lo puede hacer sentado en una silla.\n\n- Colocará las manos en el abdomen para notar como la barriga se infla al coger aire y se desinfla al expulsarlo.\n\n- Tomaremos aire en cantidad máxima que se pueda por la nariz y lo expulsaremos por la boca lentamente con los labios fruncidos.\n\n- Lo debemos hacer 2 o 3 veces al día, unas 15 repeticiones cada vez .',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: Color(0xFF757575),
                      fontSize: 17.0,
                    ),
                  ),
                ),
                Center(
                  child:  Container(
                    height: 250.0,
                    width: 350.0,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(
                                'https://fisiofine.com/wp-content/uploads/2020/04/ejercicios-fisioterapia-respiratoria-abdominal-o-diafragmatica.png'
                            )
                        )
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Text(
                    '3. Respiración costal:',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 17.0
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                      left: 20.0,
                      right: 20.0
                  ),
                  child: Text(
                    '- El paciente estará con piernas estiradas o sentado en una silla.\n\n- Ahora pondremos las manos en el tórax que es lo que vamos a notar como se infla al coger aire, y se desinfla a expulsarlo.\n\n- Tomaremos aire en cantidad máxima que se pueda por la nariz y lo expulsaremos por la boca lentamente con los labios fruncidos.\n\n- Lo debemos hacer 2 o 3 veces al día, unas 15 repeticiones cada vez.',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: Color(0xFF757575),
                      fontSize: 17.0,
                    ),
                  ),
                ),
                Center(
                  child:  Container(
                    height: 250.0,
                    width: 350.0,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(
                                'https://fisiofine.com/wp-content/uploads/2020/04/ejercicios-fisioterapia-respiratoria-respiracion-costal.png'
                            )
                        )
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                      left: 20.0,
                      right: 20.0,
                      bottom: 30.0,
                      top: 10.0
                  ),
                  child: Text(
                    '¡Recuerda repetir estos ejercicios varias veces al día!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 17.0,
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    margin: EdgeInsets.only(
                        top: 20.0,
                        bottom: 30.0
                    ),
                    width: 300.0,
                    height: 50.0,
                    child: RaisedButton(
                      child: Text('¡Me interesa!',
                        style: TextStyle(
                            fontSize: 16.0
                        ),
                      ),
                      elevation: 5.0,
                      color: Colors.indigo,
                      textColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: BorderSide(color: Colors.indigo)
                      ),
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => w_respira(user)),);
                      },
                    ),
                  ),
                )
              ],
            ),
          )
      ),
    );
  }

}