import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tesis_brainstate/User/ui/widgets/w_escuchaMusica.dart';
import 'package:tesis_brainstate/User/model/User.dart';

class screen_escuchaMusica extends StatelessWidget{

  User user = new User();
  screen_escuchaMusica(this.user);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
   return Scaffold(
     appBar: AppBar(
       title: Text('Musica-Terapia'),
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
                         image: NetworkImage('https://blush.design/api/download?shareUri=oUrkMXA8cLAsCSSo&c=Skin_0%7Ecdd6f2-0.2%7Eb3b2e6-0.3%7Eb3b2e6&w=800&h=800&fm=png')
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
                   '¿Es importante la música?',
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
                 '¡Te contamos sobre 5 beneficios que tiene la música para nuestra mente y corazón!',
                 textAlign: TextAlign.center,
               ),
             ),
             Padding(
               padding: EdgeInsets.all(20.0),
               child: Text(
                 '1. Mejora el estado de ánimo',
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
                 'Escuchar música puede beneficiar el bienestar en general, ayudar a regular las emociones, y crear felicidad y relajación en la vida diaria.',
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
                 '2. Reduce el estrés',
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
                 'Escuchar música “relajante” (considerada generalmente con un tempo lento, bajo tono, y sin letra) ha demostrado reducir el estrés y la ansiedad en personas saludables y en personas que se someten a algún procedimiento médico.',
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
                 '3. Disminuye la ansiedad',
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
                 'Estudios han demostrado que escuchar música disminuye la ansiedad en gran medida.',
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
                 '4. Mejora el ejercicio',
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
                 'Algunos estudios sugieren que la música puede mejorar el ejercicio aeróbico, aumentar la estimulación mental y física, y mejorar el rendimiento en general.',
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
                 '5. Mejora la memoria',
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
                   right: 20.0,
                 bottom: 30.0
               ),
               child: Text(
                 'Investigaciones han demostrado que los elementos repetitivos de ritmo y melodía ayudan al cerebro a formar patrones que mejoran la memoria. ',
                 textAlign: TextAlign.start,
                 style: TextStyle(
                   color: Color(0xFF757575),
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
                     Navigator.push(context, MaterialPageRoute(builder: (context) => w_escuchaMusica(user)),);
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