import 'package:flutter/material.dart';
import 'package:motus_flutter/ui/screens/home/my_home_page_viewmodel.dart';
import 'package:motus_flutter/ui/widgets/game/grid_widget.dart';
import 'package:motus_flutter/ui/widgets/keyboard/keyboard_widget.dart';
import 'package:motus_flutter/ui/widgets/my_bottom_bar.dart';
import 'package:provider/provider.dart';
import 'package:animate_do/animate_do.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    MyHomeViewModel viewModel = context.read<MyHomeViewModel>();
    viewModel.loadDictionary();

    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FadeIn(
              child:Image.asset('assets/images/motus&bouche.png', width: 0.8 * MediaQuery.of(context).size.width),
            ),
            const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
            Consumer<MyHomeViewModel>(
              builder: (context, viewModel, child) {
                return GridWidget(word: viewModel.word);
              },
            ),
            const Padding(padding: EdgeInsets.only(top: 40)),
            KeyboardWidget()
          ],
        ),
      ),
      bottomNavigationBar: MyBottomBar(context: context)
    );
  }
}
