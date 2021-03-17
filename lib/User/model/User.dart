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

  User({
    Key key,
    this.uid,
    this.name,
    this.email,
    this.telf,
    this.rol,
    this.sexo,
    this.contra,
    this.foto
  });

  Map<String, dynamic> toJsonPaciente() => {
    'uid': uid,
    'correo': email,
    'nombre': name,
    'sexo': sexo,
    'telf': telf,
    'rol': rol,
    'foto': foto
  };

  Map<String, dynamic> toJsonPsico() => {
    'uid': uid,
    'correo': email,
    'nombre': name,
    'sexo': sexo,
    'telf': telf,
    'rol': rol,
    'foto': foto,
    'verificado': false
  };
}