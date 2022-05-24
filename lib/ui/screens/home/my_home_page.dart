import 'package:flutter/material.dart';
import 'package:motus_flutter/data/entities/word.dart';
import 'package:motus_flutter/ui/screens/home/my_home_viewmodel.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    MyHomeViewModel viewModel = context.read<MyHomeViewModel>();
    viewModel.insertWord(Word(1, 2));
    viewModel.loadDictionary();
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Consumer<MyHomeViewModel>(
              builder: (context, viewModel, child) {
                if (viewModel.list == null) {
                  return const CircularProgressIndicator();
                }
                return Text(
                  viewModel.list != null ? viewModel.list.first : '',
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
