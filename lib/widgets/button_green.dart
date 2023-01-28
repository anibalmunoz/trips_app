import 'package:flutter/material.dart';

class ButtonGreeen extends StatefulWidget {
  double ancho;
  double altura;
  final String texto;
  final VoidCallback onPressed;

  ButtonGreeen(
      {required this.texto,
      required this.onPressed,
      this.ancho = 0.0,
      this.altura = 0.0});

  @override
  State createState() {
    return _ButtonGreeen();
  }
}

class _ButtonGreeen extends State<ButtonGreeen> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onPressed,
      child: Container(
        margin: EdgeInsets.only(top: 30.0, left: 20.0, right: 20.0),
        height: widget.ancho,
        width: widget.altura,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.0),
          gradient: LinearGradient(
              colors: [
                Color(0xFFa7ff84), //arriba
                Color(0xFF1cbb78), //abajo
              ],
              begin: FractionalOffset(0.2, 0.0),
              end: FractionalOffset(1.0, 0.6),
              stops: [0.0, 0.6],
              tileMode: TileMode.clamp),
        ),
        child: Center(
          child: Text(
            widget.texto,
            style: TextStyle(
                fontSize: 18.0, fontFamily: "Lato", color: Colors.white),
          ),
        ),
      ),
    );
  }
}
