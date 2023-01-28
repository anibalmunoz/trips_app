import 'package:firebase_auth/firebase_auth.dart';
import 'package:platzi_trips/User/repository/firebase_auth_api.dart';

class AuthRepository {
  final _firebaseAuthAPI = FirebaseAuthAPI();
  Future<UserCredential> signInFirebase() =>
      _firebaseAuthAPI.signInWithGoogle();

  sighOut() => _firebaseAuthAPI.sighOut();
}
