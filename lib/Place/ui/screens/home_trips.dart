import 'package:flutter/material.dart';
import 'package:platzi_trips/Place/ui/widgets/description_place.dart';
import 'package:platzi_trips/Place/ui/screens/header_appbar.dart';
import 'package:platzi_trips/Place/ui/widgets/review_list.dart';

class HomeTrips extends StatelessWidget {
  const HomeTrips({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ListView(children: const [DescriptionPlace(), ReviewList()]),
        const HeaderAppBar()
      ],
    );
  }
}
