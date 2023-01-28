import 'package:flutter/material.dart';
import '../../model/user.dart';
import '../widgets/user_info.dart';
import '../widgets/button_bar.dart';

class ProfileHeader extends StatelessWidget {
  User user;
  ProfileHeader(this.user, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget title = Container(
      alignment: Alignment.centerLeft,
      child: const Text(
        'Profile',
        style: TextStyle(fontFamily: 'Lato', color: Colors.white, fontWeight: FontWeight.bold, fontSize: 30.0),
      ),
    );

    return Container(
      margin: const EdgeInsets.only(left: 20.0, right: 20.0, top: 50.0),
      child: Column(
        children: [
          title,
          UserInfo(user),
          ButtonsBar(),
        ],
      ),
    );
  }

  Widget showProfileData(AsyncSnapshot snapshot) {
    if (!snapshot.hasData || snapshot.hasError) {
      debugPrint("No logueado");
      return Container(
        margin: const EdgeInsets.only(left: 20.0, right: 20.0, top: 50.0),
        child: Column(
          children: const [
            CircularProgressIndicator(),
            Text("No se pudo cargar la información. Haz login"),
          ],
        ),
      );
    } else {
      debugPrint("Logueado");
      debugPrint(snapshot.data);
      user = User(name: snapshot.data.displayName, email: snapshot.data.email, photoURL: snapshot.data.photoURL);
      const title = Text(
        'Profile',
        style: TextStyle(fontFamily: 'Lato', color: Colors.white, fontWeight: FontWeight.bold, fontSize: 30.0),
      );

      return Container(
        margin: const EdgeInsets.only(left: 20.0, right: 20.0, top: 50.0),
        child: Column(
          children: [
            Row(children: const [title]),
            UserInfo(user),
            ButtonsBar()
          ],
        ),
      );
    }
  }
}
