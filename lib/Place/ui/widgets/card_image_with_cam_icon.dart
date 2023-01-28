import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:platzi_trips/widgets/floating_action_button_green.dart';
import '../../../widgets/floating_action_button_green.dart';
import 'package:image/image.dart' as img;

class CardImageWithCamIcon extends StatelessWidget {
  final double height;
  final double width;
  final double left;
  final XFile image;
  late VoidCallback onPressedFabIcon;
  final IconData iconData;

  CardImageWithCamIcon({
    key,
    required this.image,
    required this.height,
    required this.width,
    //this.onPressedFabIcon,
    required this.iconData,
    required this.left,
  });

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    File imagen =
        File(image.path); //FORMA MAS ELABORADA DE CONVERTIR UN XFILE A FILE

    final card = Container(
      height: height,
      width: width,
      margin: EdgeInsets.only(left: left),
      child: Image.file(
        imagen,
        fit: BoxFit
            .cover, /*    File(image.path),  fit: BoxFit.cover,  ESTA ES LA FORMA RAPIDA DE HACER UNA CONVERSIÓN */
      ),
    );

    return Stack(
      alignment: const Alignment(0.9, 1.1),
      children: <Widget>[
        card,
        // Image.file(File(image.path)),
        FloatingActionButtonGreen(
          iconData: iconData,
          //   onPressed: onPressedFabIcon,
        )
      ],
    );
  }
}
