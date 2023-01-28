import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:platzi_trips/Place/model/place.dart';
import 'package:platzi_trips/Place/repository/firebase_storage_repository.dart';
import 'package:platzi_trips/User/repository/auth_repository.dart';
import 'package:platzi_trips/User/repository/cloud_firestore_api.dart';
import 'package:platzi_trips/User/repository/cloud_firestore_repository.dart';
import 'package:platzi_trips/User/model/user.dart' as Model;
import 'package:platzi_trips/User/ui/widgets/profile_place.dart';

class BlocUser implements Bloc {
  final _auth_repository = AuthRepository();

  //Flujo de datos - Streams
  //Stream - Firebase
  //StreamController
  Stream<User?> streamFirebase = FirebaseAuth.instance.authStateChanges();
  Stream<User?> get authStatus => streamFirebase;
  Future<User?> get currentUser async => FirebaseAuth.instance.currentUser;

  //Casos de uso de la aplicación
  //1. SignIn a la aplicación con google
  Future<UserCredential> signInWithGoogle() =>
      _auth_repository.signInFirebase();

  //2. Registrar usuario en base de datos
  final _cloudFirestoreRepository = CloudFirestoreRepository();

  //Actualizar usuario
  void updateUserData(Model.User user) async =>
      _cloudFirestoreRepository.updateUserDataFirestore(user);

  //En la siguiente linea se actualizan los lugares
  Future<void> updatePlaceData(Place place) =>
      _cloudFirestoreRepository.updatePlaceDate(place);

  //PROCESO DE LISTAR LAS IMAGENES QUE HA SUBIDO EL USUARIO
  //Trae todas las fotografías cuya conlección corresponda a los PLACES.
  Stream<QuerySnapshot> placesListStream = FirebaseFirestore.instance
      .collection(CloudFirestoreApi().PLACES)
      .snapshots();
  Stream<QuerySnapshot> get placesStream => placesListStream;

 /* List<CardImageWithFabIcon> buildPlaces(
          List<DocumentSnapshot> placesListSnapshot, User user) =>
      _cloudFirestoreRepository.buildPlaces(placesListSnapshot,user);*/
 List<Place> buildPlaces(
      List<DocumentSnapshot> placesListSnapshot, Model.User user) =>
      _cloudFirestoreRepository.buildPlaces(placesListSnapshot,user);

  // TRAE UNICAMENTE LOS LUGARES DEL USUARIO QUE SE LOGUEO EN LA APLICACION
  Stream<QuerySnapshot> myPlacesListStream(String uid) => FirebaseFirestore
      .instance
      .collection(CloudFirestoreApi().PLACES)
      .where("userOwner",
          isEqualTo: FirebaseFirestore.instance
              .doc("${CloudFirestoreApi().USERS}/${uid}"))
      .snapshots();

  List<ProfilePlace> buildMyPlaces(List<DocumentSnapshot> placesListSnapshot) =>
      _cloudFirestoreRepository.buildMyPlaces(placesListSnapshot);

  //METODO CREADO EN LA CLASE 55

  Future likePlace(Place place, String uid) => _cloudFirestoreRepository.likePlace(place,uid);

  //Metodo de clase 57, para traer nombre y descripicón de cada lugar en la aplicación

  StreamController<Place> placeSelectedStreamController=StreamController<Place>();
   Stream<Place> get placeSelectedStream => placeSelectedStreamController.stream;
   StreamSink<Place> get placeSelectedSink => placeSelectedStreamController.sink;


  final _firebaseStorageRepository = FirebaseStorageRepository();
  Future<UploadTask> uploadFile(String path, File image) =>
      _firebaseStorageRepository.uploadFile(path, image);

  signOut() {
    _auth_repository.sighOut();
  }

  @override
  void dispose() {}
}
