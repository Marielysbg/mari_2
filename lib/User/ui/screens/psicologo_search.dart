import 'dart:html';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class psicologo_search extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _psicologo_search();
  }
  
}

class _psicologo_search extends State<psicologo_search>{


  TextEditingController _searchController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
   return Scaffold(
     appBar: AppBar(
       title: TextField(
         controller: _searchController,
         decoration: InputDecoration(
           hintText: 'Buscar psicologo',
             suffixIcon: IconButton(
                icon: Icon(Icons.search),
                onPressed: () async{
                setState(() async{
                  List<DocumentSnapshot> documentList;
                  documentList = (await Firestore.instance
                      .collection("PSICOLOGO")
                      .where("correo", isEqualTo: _searchController)
                      .getDocuments())
                  .documents;
                });
              },
             )
         ),
       ),
     ),
     );

}
}