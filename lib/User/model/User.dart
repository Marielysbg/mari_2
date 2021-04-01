import 'package:flutter/material.dart';

class User with ChangeNotifier{

  String uid;
  String name;
  String email;
  String telf;
  String rol;
  String sexo;
  String contra;
  String foto;
  List solicitud;
  String aceptado;
  String idA;
  String nombreA;
  String fotoA;
  String correoA;
  int index;
  String soli;
  String telfA;
  String fecha;
  String Temergencia;
  bool verificado = false;
  String s = null;
  String cuadroc;
  String dir;
  String des;

  User({
    Key key,
    this.uid,
    this.name,
    this.email,
    this.telf,
    this.rol,
    this.sexo,
    this.contra,
    this.foto,
    this.solicitud,
    this.aceptado,
    this.idA,
    this.nombreA,
    this.fotoA,
    this.correoA,
    this.index,
    this.soli,
    this.telfA,
    this.fecha,
    this.Temergencia,
    this.verificado,
    this.s,
    this.cuadroc,
    this.des,
    this.dir
  });

  Map<String, dynamic> toJsonPaciente() => {
    'uid': uid,
    'correo': email,
    'nombre': name,
    'sexo': sexo,
    'telf': telf,
    'rol': rol,
    'foto': foto,
    'Solicitud enviada': s,
    'aceptado': 'null',
    'fecha nacimiento': fecha
  };

  Map<String, dynamic> toJsonPsico() => {
    'uid': uid,
    'correo': email,
    'nombre': name,
    'sexo': sexo,
    'telf': telf,
    'rol': rol,
    'foto': foto,
    'verificado': verificado,
    'fecha nacimiento': fecha
  };
}