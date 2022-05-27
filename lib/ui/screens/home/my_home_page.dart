import 'dart:io';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:motus_flutter/ui/screens/home/my_home_page_viewmodel.dart';
import 'package:motus_flutter/ui/widgets/game/grid_widget.dart';
import 'package:motus_flutter/ui/widgets/keyboard/keyboard_widget.dart';
import 'package:motus_flutter/ui/widgets/my_bottom_bar.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    MyHomeViewModel viewModel = context.read<MyHomeViewModel>();
    viewModel.loadGame();

    return Scaffold(
        backgroundColor: Colors.blue,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FadeIn(
                child: Image.asset('assets/images/motus&bouche.png',
                    width: 0.8 * MediaQuery.of(context).size.width),
              ),
              const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
              Consumer<MyHomeViewModel>(
                builder: (context, viewModel, child) {
                  if (viewModel.game == null) {
                    return const CircularProgressIndicator();
                  } else if (viewModel.game!.isFinished()) {
                    stdout.writeln(viewModel.game!.endDate);
                    if(viewModel.game!.isVictory()) {
                      return Text('Victoire ! \nVous avez trouvé le mot ${viewModel.game!.word!.word} en ${viewModel.game!.tries!.length} ! \nScore : ${viewModel.game!.score} points\n Revenez dans 24h pour remettre votre victoire en jeu !', style: const TextStyle(fontSize: 20, color: Colors.white));
                    } else {
                      return Text('Défaite ! \n Il fallait trouver le mot ${viewModel.game!.word!.word}\n Retentez votre chance dans 24h !', style: const TextStyle(fontSize: 20, color: Colors.white));
                    }
                  } else {
                    return Column(children: [
                      Text(
                        'Indice : ${viewModel.game!.word!.word}',
                        style: const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      GridWidget(
                        game: viewModel.game!,
                        currentInput: viewModel.currentInput,
                      ),
                      const Padding(padding: EdgeInsets.only(top: 40)),
                      KeyboardWidget(
                        onKeyPressed: (action) {
                          if (action == '#ENTER' || action == '#DELETE') {
                            if (action == '#ENTER') {
                              ///viewModel.checkWord(widget.currentWord);
                              if (viewModel.currentInput.length >=
                                  viewModel.game!.word!.wordLength()) {
                                viewModel.addTry();
                              }
                            } else if (action == '#DELETE') {
                              if (viewModel.currentInput.length > 1) {
                                viewModel.updateCurrentInput(viewModel.currentInput
                                    .substring(0, viewModel.currentInput.length - 1));
                              }
                            }
                          } else {
                            if (viewModel.currentInput.length <
                                viewModel.game!.word!.wordLength()) {
                              viewModel
                                  .updateCurrentInput(viewModel.currentInput + action);
                            }
                          }
                          stdout.writeln(
                              '[INFO] Current input: ${viewModel.currentInput}');
                        },
                      )
                    ]);
                  }
                },
              ),
            ],
          ),
        ),
        bottomNavigationBar: MyBottomBar(context: context));
  }
}
