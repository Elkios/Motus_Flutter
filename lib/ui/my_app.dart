import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:motus_flutter/ui/screens/home/my_home_page.dart';
import 'package:motus_flutter/ui/screens/signin_and_signup/sign_in_and_sign_up_page.dart';

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final routerDeledate = BeamerDelegate(
      locationBuilder: RoutesLocationBuilder(
    routes: {
      '/': (context, state, data) => const SignInAndSignUpPage(),
      '/home': (context, state, data) => const MyHomePage(title: 'Motus')
    },
  ));

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
        routeInformationParser: BeamerParser(),
        routerDelegate: routerDeledate,
        backButtonDispatcher:
            BeamerBackButtonDispatcher(delegate: routerDeledate),
        title: 'Motus Flutter',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blueGrey,
          colorScheme: const ColorScheme(
            primary: Colors.blueAccent,
            onPrimary: Colors.white,
            background: Colors.red,
            onBackground: Colors.black,
            secondary: Colors.red,
            onSecondary: Colors.white,
            error: Colors.black,
            onError: Colors.white,
            surface: Colors.white,
            onSurface: Colors.black,
            brightness: Brightness.light,
          ),
        ));
  }
}
