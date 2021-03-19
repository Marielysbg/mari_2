import 'package:flutter/material.dart';
import 'package:tesis_brainstate/User/model/User.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tesis_brainstate/User/ui/screens/Registro.dart';
import 'package:tesis_brainstate/brainstate_trips_psico.dart';
import 'package:tesis_brainstate/brainstate_trips.dart';
import 'package:fluttertoast/fluttertoast.dart';

class dos_registro extends StatefulWidget{

  User user = new User();
  dos_registro(this.user);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _dos_registro();
  }
  
}

class _dos_registro extends State<dos_registro>{

  String valueChoose;
  final auth = FirebaseAuth.instance;
  List listItem = [
    'Mujer',
    'Hombre',
    'otro'
  ];
  String rolvalueChoose;
  List rollistItem = [
    'Paciente',
    'Psicologo'
  ];


  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    final text = Container(
      margin: EdgeInsets.only(
        bottom: 30.0
      ),
      child: Text('Completa el registro',
        style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20.0
        ),
      ),
    );

    final input_correo = Padding(
      padding: const EdgeInsets.all(20.0),
      child: TextField(
        decoration: InputDecoration(
          hintText: widget.user.email,
        ),
        enabled: false,
      ),
    );

    final input_name = Padding(
      padding: const EdgeInsets.all(20.0),
      child: TextField(
        decoration: InputDecoration(
          labelText: "Nombre y apellido",
        ),
        onChanged: (value) {
          setState(() {
            widget.user.name = value.trim();
          });
        },
      ),
    );

    final input_num = Padding(
      padding: const EdgeInsets.all(20.0),
      child: TextField(
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelText: "Numéro de télefono",
        ),
        onChanged: (value) {
          setState(() {
            widget.user.telf = value.trim();
          });
        },
      ),
    );

    final input_sex = Padding(
      padding: const EdgeInsets.all(18.0),
      child: DropdownButton(
        hint: Text("Sexo"),
        icon: Icon(
            Icons.arrow_downward),
        //iconSize: 36.0,
        value: valueChoose,
        isExpanded: true,
        onChanged: (newvalue) {
          setState(() {
            valueChoose = newvalue;
            widget.user.sexo = valueChoose;
          });
        },
        items: listItem.map((valueItem) {
          return DropdownMenuItem(
            value: valueItem,
            child: Text(valueItem),
          );
        }).toList(),
      ),
    );

    final input_rol = Padding(
      padding: const EdgeInsets.all(18.0),
      child: DropdownButton(
        hint: Text("Rol"),
        icon: Icon(
            Icons.arrow_downward),
        //iconSize: 36.0,
        value: rolvalueChoose,
        isExpanded: true,
        onChanged: (newvalue){
          setState(() {
            rolvalueChoose = newvalue;
            widget.user.rol = rolvalueChoose;
          });
        },
        items: rollistItem.map((valueItem){
          return DropdownMenuItem(
            value: valueItem,
            child: Text(valueItem),
          );
        }).toList(),
      ),
    );

    final button = Container(
      width: 250.0,
      height: 50.0,
      margin: EdgeInsets.only(
          top: 50.0,
          bottom: 10.0
      ),
      child: RaisedButton(
        child: Text('Registrar',
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
          handleError(context, widget.user.email, widget.user.contra);
    },
      ),
    );


    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(
            top: 80.0
          ),
          child: Column(
            children: [
              text,
              input_correo,
              input_name,
              input_num,
              input_sex,
              input_rol,
              button
            ],
          ),
        )
      ),
    );
  }

  updateData(BuildContext context) async{
    FirebaseUser userf = await auth.currentUser();
    widget.user.uid = userf.uid;
    CollectionReference ref = Firestore.instance.collection('USUARIOS');
    CollectionReference pac = Firestore.instance.collection('PACIENTES');
    CollectionReference psi = Firestore.instance.collection('PSICOLOGOS');
    if (widget.user.rol == "Paciente") {
      await pac.document(widget.user.uid).setData(widget.user.toJsonPaciente());
      await ref.document(widget.user.uid).setData(widget.user.toJsonPaciente()).whenComplete(() =>
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => home_trips(widget.user))));
    } else if(widget.user.rol == "Psicologo"){
      await psi.document(widget.user.uid).setData(widget.user.toJsonPaciente());
      await ref.document(widget.user.uid).setData(widget.user.toJsonPsico()).whenComplete(() =>
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => brainstate_trips_psico(userf, widget.user))));
    }
  }
  handleError(BuildContext context, String correo, String contra) async{
    try{
      await auth.createUserWithEmailAndPassword(email: correo, password:contra);
      updateData(context);
    }catch (e){
      print(e);
      if(e.message == 'The email address is already in use by another account.'){
        Fluttertoast.showToast(msg: 'Correo en uso');
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Registro()));
      }
    }
  }
}