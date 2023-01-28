import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:platzi_trips/Place/model/place.dart';
import 'package:platzi_trips/Place/ui/widgets/card_image_with_cam_icon.dart';
import 'package:platzi_trips/Place/ui/widgets/title_input_location.dart';
import 'package:platzi_trips/User/bloc/bloc_user.dart';
import 'package:platzi_trips/widgets/button_purple.dart';
import 'package:platzi_trips/widgets/gradient_back.dart';
import 'package:platzi_trips/widgets/text_input.dart';
import 'package:platzi_trips/widgets/tittle_header.dart';

class AddPlaceScreen extends StatefulWidget {
  XFile image;

  AddPlaceScreen({key, required this.image});

  @override
  State<StatefulWidget> createState() {
    return _AddPlaceScreen();
  }
}

class _AddPlaceScreen extends State<AddPlaceScreen> {
  @override
  Widget build(BuildContext context) {
    //TODO: implement build
    BlocUser blocUser = BlocProvider.of<BlocUser>(context);
    final _controllerTittlePlace = TextEditingController();
    final _controllerDescriptionPlace = TextEditingController();

    final scafold = Scaffold(
      body: Stack(
        children: [
          GradientBack(altura: 300.0),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.only(top: 25.0, left: 5.0),
                child: SizedBox(
                  //Esto ayuda a incrementar el area en la que los usuarios podrán hacer click
                  height: 45.0,
                  width: 45.0,
                  child: IconButton(
                    icon: const Icon(
                      Icons.keyboard_arrow_left,
                      color: Colors.white,
                      size: 45.0,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),
              Flexible(
                  child: Container(
                padding: const EdgeInsets.only(
                  top: 45.0,
                  left: 20.0,
                  right: 10.0,
                ),
                child: TittleHeader(tittle: "Agrega un nuevo lugar"),
              )),
            ],
          ),
          Container(
            margin: const EdgeInsets.only(top: 120.0, bottom: 20.0),
            child: ListView(
              children: [
                Container(
                  //foto
                  alignment: Alignment.center,
                  child: CardImageWithCamIcon(
                    image: widget.image,
                    iconData: Icons.camera_alt,
                    width: 350.0,
                    height: 250.0,
                    left: 0.0,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 25.0, bottom: 20.0),
                  child: TextInput(
                      hintText: "Titulo",
                      inputType: null,
                      maxLines: 1,
                      controller: _controllerTittlePlace),
                ),
                TextInput(
                    hintText: "Descripcion",
                    inputType: TextInputType.multiline,
                    maxLines: 4,
                    controller: _controllerDescriptionPlace),
                Container(
                  margin: const EdgeInsets.only(top: 20.0),
                  child: TextInputLocation(
                      hintText: "Agrega ubicación",
                      iconData: Icons.location_on),
                ),
                Container(
                  width: 70.0,
                  child: ButtonPurple(
                    buttonText: "Añadir lugar",
                    onPressed: () {
                      //ID del usuario
                      blocUser.currentUser.then((User? user) {
                        if (user != null) {
                          String uid = user.uid;
                          File imagen = File(widget.image
                              .path); //FORMA MAS ELABORADA DE CONVERTIR UN XFILE A FILE
                          String path =
                              "${uid}/${DateTime.now().toString()}.jpg"; //El path de la imagen lo construimos nosotros
                          //1.Firebase Storage
                          //url - imagen
                          blocUser.uploadFile(path, imagen).then((storageTask) {
                            storageTask.then((TaskSnapshot snapshot) {
                              snapshot.ref.getDownloadURL().then((urlImage) {
                                print("URLIMAGEN: ${urlImage}");

                                //2. Cloud Firestore
                                //Place - tittle, description, url, userOwner, likes
                                blocUser
                                    .updatePlaceData(Place(
                                  name: _controllerTittlePlace.text,
                                  description: _controllerDescriptionPlace.text,
                                  urlImage: urlImage,
                                  likes: 0,
                                ))
                                    .whenComplete(() {
                                  print("Terminó");
                                  Navigator.pop(context);
                                });
                              });
                            });
                          });
                        }
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );

    return scafold;
  }
}
