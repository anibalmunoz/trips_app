import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:platzi_trips/User/bloc/bloc_user.dart';
import 'package:platzi_trips/User/model/user.dart';
import 'package:platzi_trips/User/ui/widgets/profile_background.dart';
import 'package:platzi_trips/User/ui/screens/profile_header.dart';
import 'package:platzi_trips/User/ui/widgets/profile_places_list.dart';

class ProfileTrips extends StatelessWidget {
  late BlocUser userBloc;

  @override
  Widget build(BuildContext context) {
    userBloc = BlocProvider.of<BlocUser>(context);

    return StreamBuilder(
      stream: userBloc.authStatus,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return const CircularProgressIndicator();
          case ConnectionState.none:
            return const CircularProgressIndicator();
          case ConnectionState.active:
            return showProfileData(snapshot);

          case ConnectionState.done:
            return showProfileData(snapshot);
          default:
            return showProfileData(snapshot);
        }
      },
    );
  }

  Widget showProfileData(AsyncSnapshot snapshot) {
    if (!snapshot.hasData || snapshot.hasError) {
      print("No logueado");
      return Stack(
        children: <Widget>[
          ProfileBackground(),
          ListView(
            children: const <Widget>[
              Text("Usuario no logueado, haz login"),
            ],
          ),
        ],
      );
    } else {
      print("Usuario logueado");
      var user = User(
          uid: snapshot.data.uid,
          name: snapshot.data.displayName,
          email: snapshot.data.email,
          photoURL: snapshot.data.photoURL);

      return Stack(
        children: <Widget>[
          ProfileBackground(),
          ListView(
            children: <Widget>[ProfileHeader(user), ProfilePlacesList(user)],
          ),
        ],
      );
    }
  }
}
