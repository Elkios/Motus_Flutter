import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:motus_flutter/ui/screens/signin_and_signup/sign_in_and_sign_up_page_viewmodel.dart';
import 'package:provider/provider.dart';

class MyBottomBar extends StatefulWidget {
  const MyBottomBar({Key? key, required this.context}) : super(key: key);

  final BuildContext context;

  @override
  State<StatefulWidget> createState() {
    return MyBottomBarState();
  }
}

class MyBottomBarState extends State<MyBottomBar> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.games),
          label: 'Jouer',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.supervised_user_circle),
          label: 'Profil',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.logout),
          label: 'Deconnexion',
        ),
      ],
      onTap: (int index) {
        this.onTapHandler(index);
      },
    );
  }

  Future<void> onTapHandler(int index) async {
    SignInAndSignUpPageViewModel viewModel =
        context.read<SignInAndSignUpPageViewModel>();
    if (index == 2) {
      await viewModel.logout();
      context.beamToNamed('/');
    }
  }
}
