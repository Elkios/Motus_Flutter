import 'package:firebase_auth/firebase_auth.dart';

class UserFirestore {

  static UserFirestore? _instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  static getInstance() {
    _instance ??= UserFirestore._();
    return _instance!;
  }

  UserFirestore._();

  Future<UserCredential> signInWithCredentials({required String email, required String password}) async {
    UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
    return userCredential;
  }

  Future<UserCredential> signUp({required String email, required String password}) async {
    UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
    return userCredential;
  }

  Future<bool> isSignIn() async {
    return _firebaseAuth.currentUser != null;
  }

}