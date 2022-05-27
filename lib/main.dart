import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:motus_flutter/data/entities/game/game.dart';
import 'package:motus_flutter/data/entities/trash/trash.dart';
import 'package:motus_flutter/data/entities/try/try.dart';
import 'package:motus_flutter/data/entities/word/word.dart';
import 'package:motus_flutter/ui/my_app.dart';
import 'package:motus_flutter/ui/screens/home/my_home_page_viewmodel.dart';
import 'package:motus_flutter/ui/screens/signin_and_signup/sign_in_and_sign_up_page_viewmodel.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  if (Platform.isIOS) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyDymVq7h2t1NsIbM0KhBqwaNL2bOFXZ5RE",
            appId: "1:886913267321:ios:7be09a51c19fff7c76c6a8",
            messagingSenderId: "886913267321",
            projectId: "fluttermotus"));
  } else {
    await Firebase.initializeApp();
  }

  await Hive.initFlutter();
  Hive.registerAdapter(WordAdapter());
  Hive.registerAdapter(GameAdapter());
  Hive.registerAdapter(TryAdapter());
  Hive.registerAdapter(TrashAdapter());
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider<MyHomeViewModel>(create: (_) => MyHomeViewModel()),
        ChangeNotifierProvider(create: (_) => SignInAndSignUpPageViewModel())
      ],
      child: MyApp()
    )
  );
}


