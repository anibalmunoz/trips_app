import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:platzi_trips/Place/model/place.dart';
import 'package:platzi_trips/User/bloc/bloc_user.dart';
import 'package:platzi_trips/User/model/user.dart';
import 'card_image.dart';

class CardImageList extends StatefulWidget {
  late BlocUser userBloc;
  late User user;

  CardImageList(this.user, {Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _CardImageList();
  }
}

class _CardImageList extends State<CardImageList> {
  @override
  Widget build(BuildContext context) {
    widget.userBloc = BlocProvider.of<BlocUser>(context);

    return SizedBox(
      height: 350.0,
      child: StreamBuilder(
        stream: widget.userBloc.placesStream,
        builder: (context, AsyncSnapshot snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return const CircularProgressIndicator();
            case ConnectionState.none:
              return const CircularProgressIndicator();
            case ConnectionState.active:
              return listViewPlaces(widget.userBloc.buildPlaces(snapshot.data.docs, widget.user));
            case ConnectionState.done:
              return listViewPlaces(widget.userBloc.buildPlaces(snapshot.data.docs, widget.user));
            default:
              return listViewPlaces(widget.userBloc.buildPlaces(snapshot.data.docs, widget.user));
          }
        },
      ),
    );
  }

  Widget listViewPlaces(List<Place> places) {
    void setLiked(Place place) {
      setState(() {
        place.liked = !place.liked;
        widget.userBloc.likePlace(place, widget.user.uid.toString());
        place.likes = place.liked ? place.likes! + 1 : place.likes! - 1;
        widget.userBloc.placeSelectedSink.add(place);
      });
    }

    IconData iconDataLiked = Icons.favorite;
    IconData iconDataLike = Icons.favorite_border;

    return ListView(
      padding: const EdgeInsets.all(25.0),
      scrollDirection: Axis.horizontal,
      children: places.map((place) {
        return GestureDetector(
          onTap: () => widget.userBloc.placeSelectedSink.add(place),
          child: CardImageWithFabIcon(
            pathImage: place.urlImage,
            width: 300.0,
            height: 250.0,
            left: 20.0,
            iconData: place.liked ? iconDataLiked : iconDataLike,
            onPressedFabIcon: () {
              setLiked(place);
            },
            internet: true,
          ),
        );
      }).toList(),
    );
  }
}
