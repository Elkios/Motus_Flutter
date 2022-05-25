import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import '../../data/repositories/user_repositories.dart';
import 'package:provider/provider.dart';
import '../screens/home/my_home_page_viewmodel.dart';

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
          icon: Icon(Icons.home),
          label: 'Accueil',
          backgroundColor: Colors.red,
        ),
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
    MyHomeViewModel viewModel = context.read<MyHomeViewModel>();
    if (index == 3) {
      print(index);
      await viewModel.logout();
      context.beamToNamed('/');
    }
  }
}
