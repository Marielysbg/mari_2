import 'package:flutter/material.dart';
import 'package:tesis_brainstate/User/ui/widgets/w_yoga.dart';
import 'package:tesis_brainstate/User/model/User.dart';

class screen_yoga extends StatelessWidget{

  User user = new User();
  screen_yoga(this.user);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('¡Namaste!'),
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
                        top: 30.0
                    ),
                    height: 250.0,
                    width: 250.0,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage('https://blush.design/api/download?shareUri=9qZF31w1mRDiivKl&c=Hair_0%7E0f0f0f_Skin_0%7Eecafa3&w=800&h=800&fm=png')
                        )
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    margin: EdgeInsets.only(
                        top: 30.0
                    ),
                    child: Text(
                      '¿Como el yoga es beneficioso para ti?',
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
                    'Vivir con ansiedad y ataques de pánico es difícil, pero hay una variedad de técnicas que pueden ayudar a aliviar los síntomas. y ¿Adiniva qué? El yoga es una excelente manera de reducir la ansiedad y el estrés😊.',
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Text(
                    '1. Te obliga a concentrarte en tu respiración',
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
                    'Entrenarse a sí mismo para seguir su respiración durante la clase de yoga es una habilidad útil que se puede aplicar a otras áreas de la vida. Siempre que se sienta ansioso o estresado, recuerde tomar respiraciones profundas y lentas hasta que comience a sentirse más relajado.',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: Color(0xFF757575),
                      fontSize: 17.0,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Text(
                    '2. El ejercicio produce endorfinas',
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
                    'Las endorfinas son neurotransmisores en el cerebro que han demostrado mejorar el estado de ánimo, reducir los síntomas de depresión, aliviar el estrés y la ansiedad. Las endorfinas son esencialmente un antidepresivo totalmente natural. ',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: Color(0xFF757575),
                      fontSize: 17.0,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Text(
                    '3. Reduce la tensión muscular',
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
                    'Cuando nos sentimos ansiosos o estresados, a menudo se tensan ciertas áreas de nuestro cuerpo sin siquiera darse cuenta. El yoga ayuda a aliviar la tensión muscular al fortalecer, alargar y relajar los músculos adoloridos. ',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: Color(0xFF757575),
                      fontSize: 17.0,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                      left: 20.0,
                      right: 20.0,
                      bottom: 20.0,
                    top: 10.0
                  ),
                  child: Text(
                    'El yoga es una de las formas más eficaces de reducir la ansiedad y el estrés, inclusive puede ayudarte a concentrarse en tu respiración, liberar endorfinas, aliviar la tensión muscular, ganar confianza y ser parte de una comunidad. Si no has probado hacer yoga antes ¡No es tarde para hacerlo parte de tu rutina!',
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
                        Navigator.push(context, MaterialPageRoute(builder: (context) => w_yoga(user)),);
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