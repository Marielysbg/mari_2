import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tesis_brainstate/User/model/User.dart';
import 'package:tesis_brainstate/User/ui/screens/profile_info_psico.dart';
import 'package:tesis_brainstate/Psico/psico_aceptado.dart';



class soli_psico extends StatefulWidget {

  User user = new User();
  soli_psico(this.user);
  final auth = FirebaseAuth.instance;

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _soli_psico();
  }
}


class _soli_psico extends State<soli_psico>{

  TextEditingController search = new TextEditingController();
  String name = "";


  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Scaffold(
        body: StreamBuilder<DocumentSnapshot>(
            stream: Firestore.instance.collection('PACIENTES').document(widget.user.uid).snapshots(),
            builder: (BuildContext context,
                AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text('Error:  ${snapshot.error}');
              }

                  widget.user.soli = snapshot.data['Solicitud enviada'];
                  widget.user.aceptado = snapshot.data['Aceptado'];
                  String acep = widget.user.aceptado;
                 String soli = widget.user.soli;
                 print(soli);
                  return acep != null ? psico_aceptado(widget.user) : soli == null ? Scaffold(
                      appBar: AppBar(
                        toolbarHeight: 70.0,
                        backgroundColor: Colors.indigo,
                        title: TextField(
                          style: TextStyle(
                            color: Colors.white
                          ),
                          //controller: search,
                          onChanged: (val){
                            setState(() {
                              name = val;
                            });
                          },
                          decoration: InputDecoration(
                              hintText: 'Ingresa el correo de tu psicologo',
                            hintStyle: TextStyle(
                              color: Colors.white
                            )
                          ),
                        ),
                        leading: IconButton(
                          icon: Icon(Icons.arrow_back),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    body: Container(
                    margin: EdgeInsets.only(
                        top: 20.0
                    ),
                    child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            StreamBuilder<QuerySnapshot>(
                                stream: (name != "" && name != null) ? Firestore.instance.collection('PSICOLOGOS').where('key', arrayContains: name).snapshots():
                                Firestore.instance.collection('PSICOLOGOS').snapshots(),
                                builder: (BuildContext context, AsyncSnapshot<
                                    QuerySnapshot> snapshot) {
                                  if (snapshot.hasData && snapshot.data != null) {
                                    //final docs = snapshot.data.docs;
                                    return ListView.builder(
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        itemCount: snapshot.data.documents.length,
                                        itemBuilder: (BuildContext context, int index) {
                                          var docs = snapshot.data.documents[index].data;
                                          //final user = docs[index].data();
                                          return docs['verificado'] == 'verificado' ? Container(
                                              child: GestureDetector(
                                                //MÉTODO ON TAP
                                                onTap: () {
                                                  widget.user.idA = docs['uid'];
                                                  widget.user.nombreA = docs['nombre'];
                                                  widget.user.correoA = docs['correo'];
                                                  widget.user.fotoA = docs['foto'];
                                                  widget.user.telfA = docs['telf'];
                                                  widget.user.verificado = docs['verificado'];
                                                  Navigator.push(context, MaterialPageRoute(builder: (context) => profile_info_psico(widget.user)));
                                                },
                                                child: Card(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius
                                                          .circular(10)),
                                                  margin: EdgeInsets.only(
                                                      left: 11.0,
                                                      right: 11.0,
                                                      bottom: 14.0
                                                  ),
                                                  elevation: 3,
                                                  child: Row(
                                                    children: [
                                                      FadeInImage(
                                                        image: NetworkImage(
                                                          //IMAGEN PRINCIPAL
                                                            docs['foto']
                                                        ),
                                                        placeholder: AssetImage(
                                                            'assets/img/loading.gif'
                                                        ),
                                                        fit: BoxFit.cover,
                                                        height: 100.0,
                                                        width: 100.0,
                                                      ),
                                                      Container(
                                                          padding: EdgeInsets
                                                              .all(
                                                              10),
                                                          child: Column(
                                                            crossAxisAlignment: CrossAxisAlignment
                                                                .start,
                                                            children: [
                                                              Text(
                                                                //TEXTO PRINCIPAL
                                                                docs['nombre'],
                                                                style: TextStyle(
                                                                  fontSize: 20.0,
                                                                  //fontWeight: FontWeight.bold
                                                                ),
                                                              ),
                                                              Text(
                                                                //TEXTO PRINCIPAL
                                                                docs['correo'],
                                                                style: TextStyle(
                                                                  fontSize: 15.0,
                                                                  //fontWeight: FontWeight.bold
                                                                ),
                                                              ),
                                                            ],
                                                          )
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              )
                                          ):Container();
                                        }
                                    );
                                  }
                                  return Container();
                                }
                            ),
                          ],
                        )
                    ),
                  )) : Scaffold(
                    body: StreamBuilder<DocumentSnapshot>(
                      stream: Firestore.instance.collection('PSICOLOGOS').document(widget.user.soli).snapshots(),
                      builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                        if (snapshot.hasError) {
                          return Text('Error:  ${snapshot.error}');
                        }
                        switch (snapshot.connectionState) {
                          case ConnectionState.waiting:
                            return Text('Cargando...');
                          default:
                            return Stack(
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: 230.0,
                                    color: Colors.indigo,
                                    child: IconButton(
                                      onPressed: (){},
                                      icon: Icon(Icons.arrow_back),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        child: IconButton(
                                          icon: Icon(Icons.arrow_back),
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          color: Colors.white,
                                        ),
                                      ),
                                      Container(
                                        child: Text('Perfil',
                                          style: TextStyle(
                                              fontSize: 30.0,
                                              color: Colors.white
                                          ),
                                        ),
                                      )
                                    ],
                                  ),

                                  Center(
                                    child: Container(
                                        margin: EdgeInsets.only(
                                            top: 90.0
                                        ),
                                        child: Column(
                                            crossAxisAlignment: CrossAxisAlignment
                                                .center,
                                            children: [
                                              Container(
                                                height: 200.0,
                                                width: 200.0,
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius
                                                        .circular(180.0),
                                                    image: DecorationImage(
                                                        fit: BoxFit.cover,
                                                        image: NetworkImage(snapshot.data['foto'])
                                                    )
                                                ),
                                              ),
                                              Column(
                                                  crossAxisAlignment: CrossAxisAlignment
                                                      .start,
                                                  children: [
                                                    Container(
                                                        margin: EdgeInsets.only(
                                                            top: 20.0,
                                                            bottom: 5.0
                                                        ),
                                                        child: ListTile(
                                                          title: Text(
                                                            snapshot
                                                                .data['nombre'],
                                                            style: TextStyle(
                                                              fontSize: 20.0,
                                                            ),
                                                          ),
                                                          leading: Icon(
                                                              Icons.person),
                                                        )
                                                    ),
                                                    ListTile(
                                                      title: Text(
                                                        snapshot.data['correo'],
                                                        style: TextStyle(
                                                          fontSize: 20.0,
                                                        ),
                                                      ),
                                                      leading: Icon(
                                                          Icons.email),
                                                    ),
                                                    ListTile(
                                                      title: Text(
                                                        snapshot.data['telf'],
                                                        style: TextStyle(
                                                          fontSize: 20.0,
                                                        ),
                                                      ),
                                                      leading: Icon(
                                                          Icons.phone),
                                                    )
                                                  ]),
                                              Container(
                                                margin: EdgeInsets.only(
                                                    top: 160.0
                                                ),
                                                width: 180.0,
                                                height: 50.0,
                                                child: RaisedButton(
                                                    elevation: 5.0,
                                                    color: Colors.white,
                                                    textColor: Colors.indigo,
                                                    shape: RoundedRectangleBorder(
                                                        borderRadius: BorderRadius
                                                            .circular(18.0),
                                                        side: BorderSide(
                                                            color: Colors
                                                                .indigo)
                                                    ),
                                                    child: Text(
                                                        'Solicitud Enviada'),
                                                    onPressed: () {}
                                                ),
                                              )
                                            ])
                                    ),
                                  )
                                ]);
                        }
                      },
                    ),
                  );
              }
        )
    );
  }


}
