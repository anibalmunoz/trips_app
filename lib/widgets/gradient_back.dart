import 'package:flutter/material.dart';

class GradientBack extends StatelessWidget {
  String title = "Popular";
  double altura = 0.0;

  GradientBack(
      {Key? key, required this.altura}); //heigt=null será un full screen

  @override
  Widget build(BuildContext context) {
    double screedHeight = MediaQuery.of(context).size.height;
    double screedWidht = MediaQuery.of(context).size.width;

    if (altura == double.infinity) {
      altura = screedHeight;
    }

    return Container(
      width: screedWidht,
      height: altura,
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              colors: [Color(0xFF4268D3), Color(0xFF584CD1)],
              begin: FractionalOffset(0.2, 0.0),
              end: FractionalOffset(1.0, 0.6),
              stops: [0.0, 0.6],
              tileMode: TileMode.clamp)),
      child: FittedBox(
        fit: BoxFit.none,
        alignment: const Alignment(-1.5, -0.8),
        child: Container(
          width: screedHeight,
          height: screedHeight,
          decoration: BoxDecoration(
            color: const Color.fromRGBO(0, 0, 0, 0.02),
            borderRadius: BorderRadius.circular(screedHeight / 2),
          ),
        ),
      ),
    );
  }
}
