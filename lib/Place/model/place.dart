import 'package:flutter/material.dart';

class Place {
  String? id;
  String name;
  String description;
  String urlImage;
  int? likes;
  bool liked;
  //User? userOwner;

  Place({
    Key? key,
    required this.name,
    required this.description,
    required this.urlImage,
    this.likes,
    this.liked = false,
    this.id,
    //  this.userOwner
  });
}
