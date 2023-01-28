import 'package:flutter/material.dart';
import 'package:platzi_trips/Place/model/place.dart';

class User {
  /*String uid;
  String name;
  String email;
  String photoURL;
  late final List<Place> myPlaces;
  late final List<Place> myFavoritePlaces;

  //myFavoritePlaces
  //myPlaces

  User({
    this.uid = "",
    this.name = "",
    this.email = "",
    this.photoURL = "",
    //required this.myPlaces,
    //required this.myFavoritePlaces
  });*/

  final String? uid;
  final String name;
  final String email;
  final String photoURL;
  final List<Place>? myPlaces;
  final List<Place>? myFavoritePlaces;

  //myFavoritePlaces
  //myPlaces
  User(
      {Key? key,
      @required this.uid,
      required this.name,
      required this.email,
      required this.photoURL,
      this.myPlaces,
      this.myFavoritePlaces});
}
