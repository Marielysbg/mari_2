import 'package:flutter/material.dart';
import 'package:tesis_brainstate/User/model/User.dart';
import 'package:tesis_brainstate/User/ui/screens/repositorio_musica_home.dart';

class musica_clasif extends StatelessWidget{

  User user = new User();
  musica_clasif(this.user);
  List name = [
    'Relajar',
    'Meditar',
    'Dormir',
    'Motivacional',
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
      appBar: AppBar(
        toolbarHeight: 70.0,
        title: Text('Categorias'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.indigo,
      ),
      body: Container(
        margin: EdgeInsets.only(
          top: 30.0
        ),
        child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 10.0, mainAxisSpacing: 50.0),
        physics: NeverScrollableScrollPhysics(),
        itemCount: 4,
        itemBuilder: (_, index){
        return Container(
          child: MaterialButton(
            onPressed: (){
              print('hola');
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => repositorio_musica_home(name[index], user)));
            },
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
      }
        ),
      ),
    );
  }

}