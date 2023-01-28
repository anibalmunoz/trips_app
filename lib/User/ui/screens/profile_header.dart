import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:platzi_trips/User/bloc/bloc_user.dart';
import '../../model/user.dart';
import '../widgets/user_info.dart';
import '../widgets/button_bar.dart';

class ProfileHeader extends StatelessWidget {
  late User user;

  ProfileHeader(@required this.user);

  @override
  Widget build(BuildContext context) {

    /*

//ESTE CODIGO LO HABIAMOS REALIZADO EN UNA CLASE ANTERIOR

    return StreamBuilder(
      stream: blocUser.streamFirebase,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return CircularProgressIndicator();
            break;
          case ConnectionState.none:
            return CircularProgressIndicator();
            break;
          case ConnectionState.active:
            return showProfileData(snapshot);
          case ConnectionState.done:
            return showProfileData(snapshot);
          default:
            return CircularProgressIndicator();
            break;
        }
      },
    );

     */

    const title =   Text(
      'Profile',
      style: TextStyle(
          fontFamily: 'Lato',
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 30.0),
    );

    return Container(
      margin: const EdgeInsets.only(left: 20.0, right: 20.0, top: 50.0),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[title],
          ),
          UserInfo(user),
          ButtonsBar()
        ],
      ),
    );
  }

  Widget showProfileData(AsyncSnapshot snapshot) {
    if (!snapshot.hasData || snapshot.hasError) {
      print("No logueado");
      return Container(
        margin: const EdgeInsets.only(left: 20.0, right: 20.0, top: 50.0),
        child: Column(
          children: const <Widget>[
            CircularProgressIndicator(),
            Text("No se pudo cargar la información. Haz login"),
          ],
        ),
      );
    } else {
      print("Logueado");
      print(snapshot.data);
      user = User(
          name: snapshot.data.displayName,
          email: snapshot.data.email,
          photoURL: snapshot.data.photoURL);
      const  title = Text(
        'Profile',
        style: TextStyle(
            fontFamily: 'Lato',
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 30.0),
      );

      return Container(
        margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 50.0),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[title],
            ),
            UserInfo(user),
            ButtonsBar()
          ],
        ),
      );
    }
  }
}
