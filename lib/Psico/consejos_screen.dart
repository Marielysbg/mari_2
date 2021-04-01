import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tesis_brainstate/User/model/User.dart';
import 'package:fluttertoast/fluttertoast.dart';

class consejos_screen extends StatelessWidget{

  User user = new User();
  consejos_screen(this.user);
  String mensaje;
  String hora;
  CollectionReference ref = Firestore.instance.collection('PSICOLOGOS');

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    Stream<DocumentSnapshot> courseDocStream = Firestore.instance.collection('PSICOLOGOS').document(user.uid).snapshots();

    return Scaffold(
     appBar: AppBar(
       centerTitle: true,
       toolbarHeight: 70.0,
       title: Text('Consejos', style: TextStyle(
           color: Colors.white
       ),
       ),
       backgroundColor: Colors.indigo,
       automaticallyImplyLeading: false,
       leading: IconButton(
         icon: Icon(Icons.arrow_back),
         onPressed: () {
           Navigator.pop(context);
         },
       ),
     ),
     body: StreamBuilder<DocumentSnapshot>(
         stream: courseDocStream,
         builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
           if(snapshot.data != null){
             var courseDocument = snapshot.data.data;
             // get sections from the document
             var sections = courseDocument['Mensajes'];
             // build list using names from sections
             return ListView.builder(
               scrollDirection: Axis.vertical,
               shrinkWrap: true,
               itemCount: sections != null ? sections.length : 0,
               itemBuilder: (_, int index) {
                 return Container(
                   //padding: EdgeInsets.only(left: 15.0, right: 15.0, top: 30.0),
                   // margin: const EdgeInsets.symmetric(horizontal: 5.0),
                   child: GestureDetector(
                     child: Container(
                       child: Column(
                         children: [
                           Container(
                             width: 160.0,
                             height: 30.0,
                             decoration: BoxDecoration(
                               borderRadius: BorderRadius.circular(10.0),
                               color: Colors.lightBlue,
                               boxShadow:  [
                                 BoxShadow(
                                   color: Colors.grey.withOpacity(0.2),
                                   spreadRadius: 5,
                                   blurRadius: 5,
                                   offset: Offset(0, 3), // changes position of shadow
                                 ),
                               ],
                             ),
                             margin: EdgeInsets.only(
                               top: 15.0,
                             ),
                             child:Center(
                               child: Text(
                                   sections[index]['hora'],
                                 style: TextStyle(
                                   color: Colors.white
                                 ),
                               ),
                             ) ,
                           ),
                           Row(
                             children: <Widget>[
                               Expanded(
                                   child: Padding(
                                     padding: EdgeInsets.all(10.0),
                               child: Container(
                                 decoration: BoxDecoration(
                                   borderRadius: BorderRadius.circular(10.0),
                                   color: Colors.white70,
                                   boxShadow:  [
                                     BoxShadow(
                                       color: Colors.grey.withOpacity(0.2),
                                       spreadRadius: 5,
                                       blurRadius: 5,
                                       offset: Offset(0, 3), // changes position of shadow
                                     ),
                                   ],
                                 ),
                               child: Padding(
                                 padding: EdgeInsets.all(15.0),
                                 child:Text(sections[index]['mensaje'],
                                   textAlign: TextAlign.start,
                                   overflow: TextOverflow.ellipsis,
                                   maxLines: 20,
                                   style: TextStyle(
                                     color: Colors.black87
                                   ),
                                 ),
                               )
                   ), 
                           )
                               ),
                               IconButton(
                                     icon: Icon(
                                       Icons.delete,
                                       size: 30.0,
                                       color: Colors.red,
                                     ),
                                     onPressed: () async{

                                       mensaje = sections[index]['mensaje'];
                                       hora = sections[index]['hora'];
                                       await ref.document(user.uid).updateData({
                                         'Mensajes': FieldValue.arrayRemove([{
                                           'mensaje': mensaje,
                                           'hora': hora,
                                         }])
                                       }).whenComplete(() {
                                         Fluttertoast.showToast(msg: 'Mensaje eliminado');
                                       });
                                     }),
                             ],
                           ),
                         ],
                       ),
                     )
                   )
                 );
               },
             );
           } else{
             return Container();
           }
           return null;
         }),
   );
  }

}
