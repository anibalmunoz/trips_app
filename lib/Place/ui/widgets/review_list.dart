import 'package:flutter/material.dart';
import 'review.dart';

class ReviewList extends StatelessWidget {
  const ReviewList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Review(
              "assets/img/people.jpg", "Varuna Yasas", "1 review · 5 photos", "There is an amazing place in Sri Lanka"),
          Review(
              "assets/img/ann.jpg", "Anahí Salgado", "2 review · 5 photos", "There is an amazing place in Sri Lanka"),
          Review(
              "assets/img/girl.jpg", "Gissele Thomas", "2 review · 2 photos", "There is an amazing place in Sri Lanka"),
        ],
      ),
    );
  }
}
