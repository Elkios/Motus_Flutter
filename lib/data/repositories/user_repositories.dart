import 'package:firebase_auth/firebase_auth.dart';
import 'package:motus_flutter/data/dataSources/firestore/user_firestore.dart';

class UserRepository {
  static UserRepository? _instance;
  static final UserFirestore? _userFirestore = UserFirestore.getInstance();

  static UserRepository getInstance()  {
      _instance = UserRepository._();
    return _instance!;
  }

  UserRepository._();

  Future<User?> signIn({required String email, required String password}) async {
    UserCredential userCredential = await _userFirestore!.signInWithCredentials(email: email, password: password);
    return userCredential.user;
  }

  Future<User?> signUp({required String email, required String password}) async {
    UserCredential userCredential = await _userFirestore!.signUp(email: email, password: password);
    return userCredential.user;
  }

  Future<void> logout() async {
    await _userFirestore!.logout();
  }

}
