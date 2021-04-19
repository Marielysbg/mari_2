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
  String verificado;
  String verificadoA;
  String s = null;
  String cuadroc;
  String dir;
  String des;
  String titulo;
  String descripcion;
  String direccion;

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
    this.dir,
    this.titulo,
    this.verificadoA,
    this.descripcion,
    this.direccion
  });

  Map<String, dynamic> toJsonPaciente() => {
    'uid': uid,
    'correo': email,
    'nombre': name,
    'sexo': sexo,
    'telf': telf,
    'rol': rol,
    'foto': foto,
    'Solicitud enviada': null,
    'aceptado': null,
    'fecha nacimiento': fecha,
    'verificado': 'verificado',
    'paciente': idA,
    'sexo': sexo,
    'fecha': fecha,
    'CuadroC': cuadroc
  };

  Map<String, dynamic> toJsonPsico() => {
    'uid': uid,
    'correo': email,
    'nombre': name,
    'sexo': sexo,
    'telf': telf,
    'rol': rol,
    'foto': foto,
    'verificado': 'none',
    'fecha nacimiento': fecha
  };
}