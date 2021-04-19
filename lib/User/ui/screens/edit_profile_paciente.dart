import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tesis_brainstate/User/model/User.dart';
import 'package:tesis_brainstate/User/ui/screens/edit_cc.dart';

class edit_profile_paciente extends StatefulWidget {

  User user = new User();
  edit_profile_paciente(this.user);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _edit_profile_paciente();
  }
}


class _edit_profile_paciente extends State<edit_profile_paciente> {
  // TODO: implement build

  TextEditingController telf = TextEditingController();
  TextEditingController emergencia = TextEditingController();


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    String id = widget.user.uid;
    print(id);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 70.0,
        title: Text('Editar perfil',
          style: TextStyle(
              color: Colors.white
          ),
        ),
        backgroundColor: Colors.indigo,
        leading: IconButton(
          icon: Icon(Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: StreamBuilder<DocumentSnapshot>(
          stream: Firestore.instance.collection('PSICOLOGOS').document(id).snapshots(),
          builder: (BuildContext context,
              AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text('Error:  ${snapshot.error}');
            }
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Text('Cargando...');
              default:
                return SingleChildScrollView(
                  child: Container(
                    margin: EdgeInsets.only(
                      top: 30.0,
                    ),
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                              left: 20.0,
                              bottom: 20.0,
                          ),
                          child: Text(
                            'Cambia tu número de teléfono',
                            style: TextStyle(
                                fontSize: 17.0
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                            right: 20.0,
                            left: 20.0,
                          ),
                          child: Row(
                            children: [
                              Container(
                                padding: EdgeInsets.only(
                                    right: 5.0
                                ),
                                child: Icon(
                                  Icons.add_location,
                                  color: Colors.indigo,
                                ),
                              ),
                              Flexible(
                                  child: TextField(
                                    keyboardType: TextInputType.number,
                                    maxLines: null,
                                    controller: telf,
                                    autofocus: false,
                                    decoration: InputDecoration(
                                        hintText: "Número de teléfono",
                                        fillColor: Colors.indigo,
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius
                                                .circular(25.0),
                                            borderSide: BorderSide(
                                                color: Colors.indigo
                                            )
                                        ),
                                        hintStyle: TextStyle(fontSize: 15.0)),
                                  )),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              left: 20.0,
                              bottom: 20.0,
                              top: 20.0
                          ),
                          child: Text(
                            'Cambia tu número de teléfono de emergencia',
                            style: TextStyle(
                                fontSize: 17.0
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              right: 20.0,
                              left: 20.0
                          ),
                          child: Row(
                            children: [
                              Container(
                                padding: EdgeInsets.only(
                                    right: 5.0
                                ),
                                child: Icon(
                                  Icons.phone,
                                  color: Colors.indigo,
                                ),
                              ),
                              Flexible(
                                  child: TextField(
                                    keyboardType: TextInputType.number,
                                    maxLines: null,
                                    controller: emergencia,
                                    autofocus: false,
                                    decoration: InputDecoration(
                                        hintText: "Número de emergencia",
                                        fillColor: Colors.indigo,
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius
                                                .circular(25.0),
                                            borderSide: BorderSide(
                                                color: Colors.indigo
                                            )
                                        ),
                                        hintStyle: TextStyle(fontSize: 15.0)),
                                  )),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              left: 20.0,
                              bottom: 20.0,
                              top: 20.0
                          ),
                          child: Text(
                            'Cambia tu cuadro clínico',
                            style: TextStyle(
                                fontSize: 17.0
                            ),
                          ),
                        ),
                      Center(
                        child:   Container(
                          height: 50.0,
                          width: 220.0,
                          child: RaisedButton.icon(
                              elevation: 5.0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                  side: BorderSide(color: Colors.indigo)
                              ),
                              color: Colors.white,
                              onPressed: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => edit_cc(widget.user)));
                              },
                              icon: Icon(Icons.healing),
                              label: Text('Cuadro clínico',
                              style: TextStyle(
                                fontSize: 17.0
                              ),
                              )),
                        ),
                      ),
                        Center(
                          child: Container(
                            width: 330.0,
                            height: 55.0,
                            margin: EdgeInsets.only(
                                top: 250.0,
                                bottom: 30.0
                            ),
                            child: RaisedButton(
                              onPressed: () async {
                                DocumentReference ref = Firestore.instance.collection('PACIENTES').document(widget.user.uid);
                                DocumentReference ref2 = Firestore.instance.collection('USUARIOS').document(widget.user.uid);
                                FocusScope.of(context).requestFocus(new FocusNode());
                                try{
                                  if(telf.text != ''){
                                    await ref.updateData({
                                      'telf': telf.text
                                    }).whenComplete(() async {
                                      await ref2.updateData({
                                        'telf': telf.text
                                      });
                                    });
                                  }
                                  if (emergencia.text != ''){
                                    await ref.updateData({
                                      'nro emergencia': emergencia.text
                                    }).whenComplete(()async{
                                      await ref2.updateData({
                                        'nro emergencia': emergencia.text
                                      });
                                    });
                                  }
                                  Navigator.pop(context);
                                  Fluttertoast.showToast(msg: 'Actualizado exitosamente');
                                }catch (e){
                                  Fluttertoast.showToast(msg: e);
                                }
                              },
                              color: Colors.indigo,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  side: BorderSide(color: Colors.indigo)
                              ),
                              child: Text('Guardar cambios',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 17.0
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                      crossAxisAlignment: CrossAxisAlignment.start,
                    ),
                  ),
                );
            }
          }),
    );
  }
}


