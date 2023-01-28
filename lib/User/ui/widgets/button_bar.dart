import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:platzi_trips/Place/ui/screens/add_place_screen.dart';
import 'package:platzi_trips/User/bloc/bloc_user.dart';
import 'circle_button.dart';

class ButtonsBar extends StatelessWidget {
  late BlocUser blocUser;

  @override
  Widget build(BuildContext context) {
    Firebase.initializeApp();
    blocUser = BlocProvider.of(context);
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 10.0),
        child: Row(
          children: <Widget>[
            //Reto, cambiar la contraseña
            CircleButton(true, Icons.vpn_key, 20.0, const Color.fromRGBO(255, 255, 255, 0.6), () {}),
            //Añadiremos un nuevo lugar
            CircleButton(false, Icons.add, 40.0, const Color.fromRGBO(255, 255, 255, 1), () async {
              final ImagePicker _picker = ImagePicker();

              final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

              if (image == null) {
                return;
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddPlaceScreen(image: image)),
                ).catchError((onError) => debugPrint(onError));
              }
            }),
            //Pondremos le método de cerrar sesion
            CircleButton(
              true,
              Icons.exit_to_app,
              20.0,
              const Color.fromRGBO(255, 255, 255, 0.6),
              () => {blocUser.signOut()},
            ),
          ],
        ));
  }
}
