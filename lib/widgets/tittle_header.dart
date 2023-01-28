import 'package:flutter/material.dart';

class TittleHeader extends StatelessWidget {
  final String tittle;
  TittleHeader({Key? key, required this.tittle});

  @override
  Widget build(BuildContext context) {
    double screedWidht = MediaQuery.of(context).size.width;
    final text = Text(
      tittle,
      style: TextStyle(
        color: Colors.white,
        fontSize: 30.0,
        fontFamily: "Lato",
        fontWeight: FontWeight.bold,
      ),
    );

    return text;
  }
}
