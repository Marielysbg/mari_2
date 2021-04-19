import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:tesis_brainstate/User/ui/screens/repositorio_musica_home.dart';

import 'User/ui/screens/Login_Screen.dart';
import 'User/ui/screens/screen_escuchaMusica.dart';

void main() {
  runApp(MyApp());
}

//PENDIENTE: TRAER DATA

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    return MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate
      ],
      supportedLocales: [
        const Locale('es')
      ],
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Login_Screen()
      // MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

