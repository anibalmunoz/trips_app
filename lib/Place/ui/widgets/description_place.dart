import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:platzi_trips/Place/model/place.dart';
import 'package:platzi_trips/User/bloc/bloc_user.dart';
import '../../../widgets/button_purple.dart';

class DescriptionPlace extends StatelessWidget {
  // String namePlace;
  // int stars;
  // String descriptionPlace;

  const DescriptionPlace({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocUser userBloc = BlocProvider.of(context);

    // final star_half = Container(
    //   margin: const EdgeInsets.only(top: 353.0, right: 3.0),
    //   child: const Icon(
    //     Icons.star_half,
    //     color: Color(0xFFf2C611),
    //   ),
    // );

    // final star_border = Container(
    //   margin: const EdgeInsets.only(top: 353.0, right: 3.0),
    //   child: const Icon(
    //     Icons.star_border,
    //     color: Color(0xFFf2C611),
    //   ),
    // );

    // final star = Container(
    //   margin: const EdgeInsets.only(top: 353.0, right: 3.0),
    //   child: const Icon(
    //     Icons.star,
    //     color: Color(0xFFf2C611),
    //   ),
    // );

    Widget titleStars(Place place) {
      return Row(
        children: <Widget>[
          Flexible(
            child: Container(
              margin: const EdgeInsets.only(top: 350.0, left: 20.0, right: 20.0),
              child: Text(
                place.name,
                style: const TextStyle(
                  fontFamily: "Lato",
                  fontSize: 30.0,
                  fontWeight: FontWeight.w900,
                ),
                textAlign: TextAlign.left,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 370.0, right: 10.0),
            child: Text(
              "Likes: ${place.likes}",
              style:
                  const TextStyle(fontFamily: "Lato", fontSize: 18.0, fontWeight: FontWeight.w900, color: Colors.amber),
              textAlign: TextAlign.left,
            ),
          )
        ],
      );
    }

    Widget descriptionWidget(String descriptionPlace) {
      return Container(
        margin: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
        child: Text(
          descriptionPlace,
          style: const TextStyle(
              fontFamily: "Lato", fontSize: 16.0, fontWeight: FontWeight.bold, color: Color(0xFF56575a)),
        ),
      );
    }

/*
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        title_stars,
        description,
        ButtonPurple(
          buttonText: "Navegando",
          onPressed: () {},
        )
      ],
    );

 */

    return StreamBuilder(
      stream: userBloc.placeSelectedStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          Place place = snapshot.data;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              titleStars(place),
              descriptionWidget(place.description),
              ButtonPurple(buttonText: "Navigate", onPressed: () {})
            ],
          );
        } else {
          return Container(
            margin: const EdgeInsets.only(top: 400.0, left: 20.0, right: 20.0),
            child: const Text(
              "Selecciona un lugar",
              style: TextStyle(fontFamily: "Lato", fontSize: 30.0, fontWeight: FontWeight.w900),
              textAlign: TextAlign.left,
            ),
          );
        }
      },
    );
  }
}
