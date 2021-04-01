import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:tesis_brainstate/User/model/User.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tesis_brainstate/User/ui/screens/cuarto_registro.dart';


class tres_registro extends StatelessWidget{


  User user = new User();
  FirebaseUser userf;
  tres_registro(this.user, this.userf);
  TextEditingController nro = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    final text = Container(
      margin: EdgeInsets.only(
        top: 100.0
      ),
      child: Column(
        children: [
          Center(
            child: Text('Teléfono de emergencia',
          style: TextStyle(
            fontSize: 25.0,
            fontWeight: FontWeight.bold
          ),
        ),
          ),
        Container(
            margin: EdgeInsets.only(
                top: 5.0
            ),
        child: Center(
          child: Text('Este número será utilizado en caso de que tengas una emergencia',
          style: TextStyle(
          fontSize: 10.0
         ),
      ),
    )
        )
        ],
      ),
    );

    final field = Container(
      margin: EdgeInsets.only(
        top: 100.0
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: IntlPhoneField(
          decoration: InputDecoration(
              labelText: 'Número de teléfono',
              border: OutlineInputBorder(
                  borderSide: BorderSide()
              )
          ),
          initialCountryCode: 'VE',
          onChanged: (phone){
            user.Temergencia = phone.number;
          },
        ),
      )
    );

    final button = Container(
      width: 300.0,
      height: 50.0,
      margin: EdgeInsets.only(
          top: 300.0,
          bottom: 10.0
      ),
      child: RaisedButton(
        child: Text('Continuar',
          style: TextStyle(
              fontSize: 16.0
          ),
        ),
        elevation: 5.0,
        color: Colors.indigo,
        textColor: Colors.white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0)
        ),
        onPressed: () async{
         if(user.Temergencia == ''){
           Fluttertoast.showToast(msg: 'Debe completar el formulario para continuar');
         } else {
           buildShowDialog(context);
           FocusScope.of(context).requestFocus(new FocusNode());
           CollectionReference ref = Firestore.instance.collection('USUARIOS');
           CollectionReference pac = Firestore.instance.collection('PACIENTES');
           await pac.document(user.uid).updateData({
             'nro emergencia': user.Temergencia
           }).then((value) async{
             await ref.document(user.uid).updateData({
               'nro emergencia': user.Temergencia
             });
             Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => cuarto_registro(userf, user)));
           });
         }
        },
      ),
    );

    return Scaffold(
      body: SingleChildScrollView(
        child: GestureDetector(
          onTap: (){
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: Container(
            child: Column(
              children: [
                text,
                field,
                button
              ],
            ),
          ),
        )
      ),
    );
  }

  buildShowDialog(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Center(
            child: CircularProgressIndicator(),
          );
        });
  }

}