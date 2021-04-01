import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tesis_brainstate/User/model/User.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tesis_brainstate/User/ui/screens/Registro.dart';
import 'package:tesis_brainstate/brainstate_trips_psico.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:tesis_brainstate/User/ui/screens/tres_registro.dart';
import 'package:tesis_brainstate/User/ui/screens/registro_dir_des_psico.dart';

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

  File _image;
  TextEditingController _TextFechaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    Future getImage() async{
      var image = await ImagePicker.pickImage(source: ImageSource.gallery);
      //var refi = FirebaseStorage().ref().child(image.toString());
      //var imageString = await refi.getDownloadURL();
      //print(imageString);

      setState(() {
        _image = image;
      });
    }

    final photo =  Container(
      child: Stack(
        alignment: Alignment(0.9, 1.3),
        children: [
          CircleAvatar(
            radius: 65.0,
            child: ClipOval(
              child: SizedBox(
                width: 120.0,
                height: 120.0,
                child: (_image != null)?Image.file(_image, fit: BoxFit.cover):
                Image.network(
                  "https://icon-library.com/images/default-profile-icon/default-profile-icon-16.jpg",
                  fit: BoxFit.fill,
                ),

              ),
            ),
          ),
          FloatingActionButton(
            child: Icon(
                Icons.camera_alt
            ),
            mini: true,
            onPressed: (){
              getImage();
            },
          )
        ],
      ),
    );

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
          FocusScope.of(context).requestFocus(new FocusNode());
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
          FocusScope.of(context).requestFocus(new FocusNode());
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
          if(widget.user.foto == '' || widget.user.name == '' || widget.user.telf == ''  || widget.user.fecha == '' ||  widget.user.rol == ''){
            Fluttertoast.showToast(msg: 'Debe completar todo el formulario para continuar');
          } else {
            setState(() {
              buildShowDialog(context);
            });
            FocusScope.of(context).requestFocus(new FocusNode());
            handleError(context, widget.user.email, widget.user.contra);
          }
    },
      ),
    );


    final fecha = Padding(
      padding: const EdgeInsets.all(18.0),
      child: Container(
        child: TextField(decoration: InputDecoration(
          hintText: 'Fecha de nacimiento'
        ),
          controller: _TextFechaController,
          onTap: (){
            FocusScope.of(context).requestFocus(new FocusNode());
            showDatePicker(context: context,
                locale : const Locale("es"),
                initialDate: DateTime.now(),
                firstDate: DateTime(1900),
                lastDate: DateTime(2022)
            ).then((value) {
              if(value != null){
                //_TextFechaController.text = value.toString();
                _TextFechaController.text = DateFormat('dd/MM/yyyy').format(value);
                widget.user.fecha = _TextFechaController.text;
              }
            });
          },
        ),
      ),
    );

    return Scaffold(
      body: SingleChildScrollView(
          child:  Container(
            margin: EdgeInsets.only(
                top: 80.0
            ),
            child: Column(
              children: [
                text,
                photo,
                input_correo,
                input_name,
                fecha,
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

  updateData(BuildContext context) async{

    String link;
    String imageUrl;
    FirebaseUser userf = await auth.currentUser();
    String uid = userf.uid;
    String fileName = basename(_image.path);
    StorageReference firebaseStorageRef = FirebaseStorage.instance.ref().child("usuarios/$uid/$fileName");
    StorageUploadTask uploadTask = firebaseStorageRef.putFile(_image);
    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
    imageUrl = await firebaseStorageRef.getDownloadURL();
    widget.user.foto = imageUrl;
    widget.user.fecha = _TextFechaController.text;

    widget.user.uid = userf.uid;
    CollectionReference ref = Firestore.instance.collection('USUARIOS');
    CollectionReference msj = Firestore.instance.collection('MensajesP');
    CollectionReference pac = Firestore.instance.collection('PACIENTES');
    CollectionReference psi = Firestore.instance.collection('PSICOLOGOS');
    if (widget.user.rol == "Paciente") {
      await pac.document(widget.user.uid).setData(widget.user.toJsonPaciente());
      await ref.document(widget.user.uid).setData(widget.user.toJsonPaciente()).whenComplete(() =>
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => tres_registro(widget.user, userf))));
    } else if(widget.user.rol == "Psicologo"){
      await psi.document(widget.user.uid).setData(widget.user.toJsonPaciente());
      await ref.document(widget.user.uid).setData(widget.user.toJsonPsico()).whenComplete(() async {
        //Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => brainstate_trips_psico(userf, widget.user)));
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => registro_dir_des_psico(userf, widget.user)));
        await msj.document(widget.user.uid).setData({
          'uid': widget.user.uid,
          'foto': widget.user.foto
        });
      });

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