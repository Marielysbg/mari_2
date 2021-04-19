import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tesis_brainstate/User/model/User.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tesis_brainstate/brainstate_trips.dart';

class cuarto_registro extends StatelessWidget{

  User user = new User();
  FirebaseUser userf;
  cuarto_registro(this.userf, this.user);
  int selectedIndex=-1;

  String preferencia;

  List name = [
    'Ansiedad',
    'Depresión',
    'Pánico',
    'Estrés',
  ];

  List fotos = [
    'https://uniquemindcare.com/wp-content/uploads/2020/06/Treat-Anxiety-Social.png',
    'https://media.istockphoto.com/vectors/sad-lonely-woman-in-depression-with-flying-hair-vector-id1166335598?k=6&m=1166335598&s=612x612&w=0&h=iXIrvfNzCQGE1amU4WmOw6-52n3AZ5NGG4qhG7MTZAI=',
    'https://media.istockphoto.com/vectors/woman-in-panic-vector-id1218027613?k=6&m=1218027613&s=612x612&w=0&h=d95oMTyr0KS7C3g2Yv7TKyjGrgdkSKVjCtj71glUFog=',
    'https://as2.ftcdn.net/jpg/01/59/70/65/500_F_159706532_oxAt3zvMtaJY6Zd3JOo1aaX8LHdYMo40.jpg',
  ];

  @override
  Widget build(BuildContext context) {

    // TODO: implement build
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(
            top: 20.0,
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    height: 150.0,
                    width: 120.0,
                    margin: EdgeInsets.only(
                        left: 20.0,
                      top: 20.0
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        image: DecorationImage(
                            image: NetworkImage(user.foto),
                            fit: BoxFit.cover
                        )
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      left: 20.0,
                      top: 15.0
                    ),
                    child:  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                              bottom: 5.0
                          ),
                          child: Text(
                            user.name,
                            style: TextStyle(
                                fontSize: 25.0,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                        Text(
                          user.email,
                          style: TextStyle(
                            fontSize: 15.0,
                            color: Colors.black45,

                          ),
                        ),
                        Container(
                            margin: EdgeInsets.only(
                                top: 60.0
                            ),
                            width: 200.0,
                            height: 40.0,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: Colors.indigo
                            ),
                            child: Center(
                              child: Text(
                                'Paciente',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 17.0
                                ),
                              ),
                            )
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.only(
                    top: 20.0,
                    left: 20.0,
                  right: 20.0
                ),
                child: Text(
                  '¡La información que te pedimos a continuación nos permite brindarte herramientas mas personalizadas que puedan servirte de ayuda mas adelante!',
                  style: TextStyle(
                      color: Colors.black54
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                    top: 20.0,
                    left: 20.0
                ),
                child: Text(
                  '¿Con cuál te identificas más?',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      color: Colors.indigo,
                      fontWeight: FontWeight.bold,
                      fontSize: 17.0
                  ),
                ),
              ),
              Container(
                  margin: EdgeInsets.only(
                    top: 20.0,
                    right: 20.0,
                    left: 20.0
                  ),
                child: GridView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 10.0, mainAxisSpacing: 10.0),
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: 4,
                  itemBuilder: (_, index){
                    return Container(
                      child:  MaterialButton(
                        padding: EdgeInsets.zero,
                        minWidth: 0,
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        onPressed: (){
                          selectedIndex = index;
                          (context as Element).markNeedsBuild();
                          return selectedIndex;
                        },
                        shape: (selectedIndex == index) ? RoundedRectangleBorder(
                          side: BorderSide(
                            color: Colors.indigo,
                            width: 5.0
                          )
                        ):null,
                        elevation: 3.0,
                        child: Container(
                          height: 200.0,
                          width: 200.0,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(fotos[index]),
                                  fit: BoxFit.cover
                              ),
                              borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: Container(
                            margin: EdgeInsets.fromLTRB(15, 15, 0, 0),
                            child: Text(
                              name[index],
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                          ),
                        ),

                      ),
                    );
                  },
                ),
              ),
              Center(
                child: Container(
                  width: 330.0,
                  height: 45.0,
                  margin: EdgeInsets.only(
                      top: 20.0,
                      bottom: 30.0
                  ),
                  child: RaisedButton(
                    onPressed: () async {
                      if(selectedIndex == -1){
                        Fluttertoast.showToast(msg: 'Debe seleccionar una opción');
                      } else {
                        if(selectedIndex==0){
                          preferencia = 'ansiedad';
                        } else if(selectedIndex == 1){
                          preferencia = 'depresion';
                        } else if(selectedIndex == 2){
                          preferencia = 'panico';
                        } else if(selectedIndex == 3){
                          preferencia = 'estres';
                        }
                        user.cuadroc = preferencia;
                        buildShowDialog(context);
                        CollectionReference ref = Firestore.instance.collection('USUARIOS');
                        CollectionReference pac = Firestore.instance.collection('PACIENTES');
                        await pac.document(user.uid).updateData({
                          'cuadroC': user.cuadroc
                        }).then((value) async{
                          await ref.document(user.uid).updateData({
                            'cuadroC': user.cuadroc
                          });
                          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => home_trips(user)));
                          Fluttertoast.showToast(msg: 'Registro exitoso');
                        });
                        print(preferencia);
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
                ),
              ),

            ],
            crossAxisAlignment: CrossAxisAlignment.start,
          ),
        ),
      )
    ) ;
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
}