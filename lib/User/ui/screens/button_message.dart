import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:tesis_brainstate/User/model/User.dart';
import 'package:tesis_brainstate/User/ui/screens/consejo_paciente.dart';

class button_message extends StatelessWidget{

  bool status = true;
  User user = new User();
  button_message(this.user);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.all(20.0),
              child: Text(
                'Consejos del psicologo',
                style: TextStyle(
                    fontSize: 17.0
                ),
              ),
            ),
            FlutterSwitch(
              activeText: "Generales",
              inactiveText: "Personales",
              inactiveColor: Colors.green,
              value: status,
              valueFontSize: 15.0,
              width: 130,
              borderRadius: 30.0,
              showOnOff: true,
              onToggle: (val) {
                status = val;
                print(val);
                (context as Element).markNeedsBuild();
              },
            ),
          ],
        ),
        status ? Expanded(
          child: consejos_paciente(user),
        ): Container()
      ],
    );
  }

}