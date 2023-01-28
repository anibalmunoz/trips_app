import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:platzi_trips/Place/model/place.dart';
import 'package:platzi_trips/User/model/user.dart' as ModelUs;
import 'package:platzi_trips/User/ui/widgets/profile_place.dart';

class CloudFirestoreApi {
  final String USERS = "users";
  final String PLACES = "places";

  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void updateUserData(ModelUs.User user) async {
    DocumentReference ref = _db.collection(USERS).doc(user.uid);
    return await ref.set({
      'uid': user.uid,
      'name': user.name,
      'email': user.email,
      'photoURL': user.photoURL,
      'myPlaces': user.myPlaces,
      'myFavoritePlaces': user.myFavoritePlaces,
      'lastSignIn': DateTime.now(),
    }, SetOptions(merge: true));
  }

  Future<void> updatePlaceData(Place place) async {
    CollectionReference refPlaces = _db.collection(PLACES);

    User? user = _auth.currentUser;

    await refPlaces.add({
      'name': place.name,
      'description': place.description,
      'likes': place.likes,
      'urlImage': place.urlImage,
      'userOwner': _db.doc("${USERS}/${user?.uid}"),
      'userLiked': FieldValue.arrayUnion([]),
      //tipo de dato conocido o llamado reference
    }).then((DocumentReference dr) {
      dr.get().then((DocumentSnapshot snapshot) {
        snapshot.id; // id de los lugares REFERENCIA ARRAY

        DocumentReference refUsers = _db.collection(USERS).doc(user?.uid);
        refUsers.update({
          'myPlaces':
              FieldValue.arrayUnion([_db.doc("${PLACES}/${snapshot.id}")])
        });
      });
    });
  }

  List<ProfilePlace> buildMyPlaces(List<DocumentSnapshot> placesListSnapshot) {
    List<ProfilePlace> profilePlaces = [];

    placesListSnapshot.forEach((p) {
      profilePlaces.add(ProfilePlace(Place(
          name: p['name'],
          description: p['description'],
          urlImage: p['urlImage'],
          likes: p['likes'])));
    });

    return profilePlaces;
  }

  List<Place> buildPlaces(
      List<DocumentSnapshot> placesListSnapshot, ModelUs.User user) {
    List<Place> places = [];

    placesListSnapshot.forEach((DocumentSnapshot p) {
      Place place = Place(
          id: p.id,
          name: p["name"],
          description: p["description"],
          urlImage: p["urlImage"],
          likes: p["likes"]);

      List<dynamic>? usersLikedRefs = p["userLiked"];

      place.liked = false;

      usersLikedRefs?.forEach((drUl) {
        if (user.uid == drUl.id) {
          place.liked = true;
        }
      });

      places.add(place);
    });

    return places;
  }

  Future likePlace(Place place, String uid) async {
    await _db
        .collection(PLACES)
        .doc(place.id)
        .get()
        .then((DocumentSnapshot ds) {
      int likes = ds['likes'];

      _db.collection(PLACES).doc(place.id).update({
        'likes': place.liked ? likes + 1 : likes - 1,
        'userLiked': place.liked
            ? FieldValue.arrayUnion([_db.doc("${USERS}/${uid}")])
            : FieldValue.arrayRemove([_db.doc("${USERS}/${uid}")])
      });
    });
  }
}
