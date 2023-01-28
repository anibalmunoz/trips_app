import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:platzi_trips/User/model/user.dart';
import 'package:platzi_trips/User/repository/cloud_firestore_api.dart';
import 'package:platzi_trips/User/ui/widgets/profile_place.dart';

import '../../Place/model/place.dart';

class CloudFirestoreRepository {
  final _cloudFirestoreAPI = CloudFirestoreApi();
  void updateUserDataFirestore(User user) =>
      _cloudFirestoreAPI.updateUserData(user);
  Future<void> updatePlaceDate(Place place) =>
      _cloudFirestoreAPI.updatePlaceData(place);

  List<ProfilePlace> buildMyPlaces(List<DocumentSnapshot> placesListSnapshot) =>
      _cloudFirestoreAPI.buildMyPlaces(placesListSnapshot);

  List<Place> buildPlaces(
          List<DocumentSnapshot> placesListSnapshot, User user) =>
      _cloudFirestoreAPI.buildPlaces(placesListSnapshot, user);

  //ULTIMOS CAMBIOS DE LA CLASE 55

  Future likePlace(Place place, String uid) => _cloudFirestoreAPI.likePlace(place,uid);

}
