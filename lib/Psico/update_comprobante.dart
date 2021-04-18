import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tesis_brainstate/User/model/User.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tesis_brainstate/brainstate_trips_psico.dart';
import 'package:tesis_brainstate/Psico/verificado.dart';

class update_comprobante extends StatefulWidget{

  User user = new User();
  FirebaseUser userf;
  update_comprobante(this.userf, this.user);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _update_comprobante();
  }

}

class _update_comprobante extends State<update_comprobante>{

  File _image;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    Future getImage() async{
      var image = await ImagePicker.pickImage(source: ImageSource.gallery);
      setState(() {
        _image = image;
        print('Image Path $_image');
      });
    }

    final text = Container(
      margin: EdgeInsets.only(
        top: 20.0,
        bottom: 30.0
      ),
      child: Text(
        '¡Último paso!',
          style: TextStyle(
            color: Color(0xFF212121),
            fontSize: 20.0,
            fontWeight: FontWeight.bold
          ),
      ),
    );

    final text2 = Container(
      margin: EdgeInsets.only(
          top: 20.0,
          bottom: 30.0,
        left: 20.0,
        right: 20.0
      ),
      child: Text(
        'Para completar tu registro carga una foto que nos compruebe que eres psicólogo\n\n¡En cuanto lo revisemos podrás acceder!',
        textAlign: TextAlign.center,
        style: TextStyle(
            color: Color(0xFF757575),
            fontSize: 17.0,
        ),
      ),
    );

    final text3 = Container(
      margin: EdgeInsets.only(
          top: 20.0,
          bottom: 15.0,
          left: 20.0,
          right: 20.0
      ),
      child: Text(
        'Carga la foto',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Color(0xFF303F9F),
          fontWeight: FontWeight.bold,
          fontSize: 20.0,
        ),
      ),
    );

    final com = Container(
      height: 250.0,
      width: 350.0,
      child: Stack(
        alignment: Alignment(1.0, 1.3),
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: _image == null
                    ? NetworkImage("https://icon-library.com/images/default-profile-icon/default-profile-icon-16.jpg")
                    : FileImage(_image),
              )
            ),
          ),
          FloatingActionButton(
            backgroundColor: Color(0xFFFF5252),
            child: Icon(
                Icons.camera_alt
            ),
            mini: false,
            onPressed: (){
              getImage();
            },
          )
        ],
      ),
    );

    final button = Container(
      width: 330.0,
      height: 45.0,
      margin: EdgeInsets.only(
          top: 120.0,
          bottom: 30.0
      ),
      child: RaisedButton(
        onPressed: () async{
          if (_image == null){
            Fluttertoast.showToast(msg: 'Debe subir una imagen para continuar');
          } else{
            buildShowDialog(context);
            updateData(context);
          }
        },
        color: Colors.indigo,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
            side: BorderSide(color: Colors.indigo)
        ),
        child: Text('Continuar',
          style: TextStyle(
              color: Colors.white,
              fontSize: 17.0
          ),),
      ),
    );

    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(
          top: 30.0
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: text,
            ),
            Center(
              child: text2,
            ),
            Center(
              child: text3,
            ),
           com,
            button
          ],
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
    String imageUrl;
    String uid = widget.user.uid;
    String fileName = basename(_image.path);
    StorageReference firebaseStorageRef = FirebaseStorage.instance.ref().child("usuarios/$uid/$fileName");
    StorageUploadTask uploadTask = firebaseStorageRef.putFile(_image);
    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
    imageUrl = await firebaseStorageRef.getDownloadURL();
    CollectionReference pac = Firestore.instance.collection('PSICOLOGOS');
    CollectionReference ver = Firestore.instance.collection('VERIFICACION');
    widget.user.titulo = imageUrl;
    await pac.document(uid).updateData({
      'titulo': imageUrl,
    }).whenComplete(() async {
      await ver.document(uid).updateData({
        'titulo': imageUrl,
      });
      await pac.document(uid).updateData({
        'verificado': 'none',
      });
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => verificado(widget.userf, widget.user)));
    });
  }

}