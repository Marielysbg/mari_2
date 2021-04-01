import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tesis_brainstate/User/model/User.dart';


class getSoli extends StatelessWidget {

  User user = new User();
  getSoli(this.user);

  @override
  Widget build(BuildContext context) {
    // get the course document using a stream
    Stream<DocumentSnapshot> courseDocStream = Firestore.instance
        .collection('USUARIOS')
        .document(user.uid)
        .snapshots();

    return StreamBuilder<DocumentSnapshot>(
        stream: courseDocStream,
        builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          var courseDocument = snapshot.data.data;
          // get sections from the document
          var sections = courseDocument['Solicitudes'];
          // build list using names from sections
          return ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: sections != null ? sections.length : 0,
            itemBuilder: (_, int index) {
              print(sections[index]['Solicitud']);
              return ListTile(
                title: Text(sections[index]['solicitud']),
                subtitle: Text(sections[index]['correoU']),
               /* onTap: (){
                  user.idA = sections[index]['solicitud'];
                  user.nombreA = sections[index]['nombreU'];
                  user.correoA = sections[index]['correoU'];
                  user.index = index;
                  print(user.index);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => profile_dos(user)));
                },

                */
              );
            },
          );
        });
  }
}