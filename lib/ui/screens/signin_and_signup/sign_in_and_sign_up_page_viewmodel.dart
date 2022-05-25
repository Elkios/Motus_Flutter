import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:motus_flutter/data/repositories/user_repositories.dart';

class SignInAndSignUpPageViewModel with ChangeNotifier{

  User? _user;
  User? get user => _user;

  Future<void> signIn({required String email, required String password}) async {
    UserRepository userRepository = UserRepository.getInstance();
    try{
      _user = await userRepository.signIn(email: email, password: password);
    } on Exception catch(e){
      _user = await userRepository.signUp(email: email, password: password);
    }
    notifyListeners();
    return;
  }

}