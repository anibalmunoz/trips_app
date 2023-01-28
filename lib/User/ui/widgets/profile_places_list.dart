import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:platzi_trips/User/bloc/bloc_user.dart';
import 'package:platzi_trips/User/model/user.dart';
import '../../../Place/model/place.dart';
import 'package:platzi_trips/Place/model/place.dart';

class ProfilePlacesList extends StatelessWidget {
  late BlocUser userBloc;
  late User user;
  ProfilePlacesList(@required this.user);
/*
  Place place = Place(
      name: "Knuckles Mountains Range",
      description: "Hiking. Water fall hunting. Natural bath",
      urlImage:
          "https://images.unsplash.com/photo-1519681393784-d120267933ba?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1500&q=80",
      likes: 3);
  Place place2 = Place(
      name: "Mountains",
      description:
          "Hiking. Water fall hunting. Natural bath', 'Scenery & Photography",
      urlImage:
          "https://images.unsplash.com/photo-1524654458049-e36be0721fa2?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1500&q=80",
      likes: 10);

 */

  /*
  Place place = new Place('Knuckles Mountains Range', 'Hiking. Water fall hunting. Natural bath', 'Scenery & Photography', '123,123,123');
  Place place2 = new Place('Mountains', 'Hiking. Water fall hunting. Natural bath', 'Scenery & Photography', '321,321,321');
*/
  @override
  Widget build(BuildContext context) {
    userBloc = BlocProvider.of<BlocUser>(context);

    return Container(
      margin: const EdgeInsets.only(
          top: 10.0, left: 20.0, right: 20.0, bottom: 10.0),
      child: StreamBuilder(
          stream: userBloc.myPlacesListStream(user.uid.toString()),
          builder: (context, AsyncSnapshot snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return CircularProgressIndicator();
              case ConnectionState.done:
                snapshot.data.documents;
                return Column(
                    children: userBloc.buildMyPlaces(snapshot.data.docs));
              case ConnectionState.active:
                return Column(
                    children: userBloc.buildMyPlaces(snapshot.data.docs));

              case ConnectionState.none:
                return CircularProgressIndicator();

              default:
                return Column(
                    children: userBloc.buildMyPlaces(snapshot.data.docs));
            }
          }),
    );
  }

  /*Column(
        children: <Widget>[
          ProfilePlace(place),
          ProfilePlace(place2),
        ],
      ),*/

}
