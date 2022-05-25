import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:motus_flutter/data/entities/word/word.dart';
import 'package:motus_flutter/ui/my_app.dart';
import 'package:motus_flutter/ui/screens/home/my_home_page_viewmodel.dart';
import 'package:motus_flutter/ui/screens/signin_and_signup/sign_in_and_sign_up_page_viewmodel.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Hive.initFlutter();
  Hive.registerAdapter(WordAdapter());
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider<MyHomeViewModel>(create: (_) => MyHomeViewModel()),
        ChangeNotifierProvider(create: (_) => SignInAndSignUpPageViewModel())
      ],
      child: const MyApp()
    )
  );
}


