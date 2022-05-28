import 'dart:io';
import 'dart:math';

import 'package:animate_do/animate_do.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:motus_flutter/data/entities/game/game.dart';
import 'package:motus_flutter/data/entities/letterState/letter_state.dart';
import 'package:motus_flutter/data/entities/try/try.dart';
import 'package:motus_flutter/ui/screens/home/my_home_page_viewmodel.dart';
import 'package:motus_flutter/ui/widgets/game/grid_widget.dart';
import 'package:motus_flutter/ui/widgets/game/letter_widget.dart';
import 'package:motus_flutter/ui/widgets/game/row_widget.dart';
import 'package:motus_flutter/ui/widgets/keyboard/keyboard_widget.dart';
import 'package:motus_flutter/ui/widgets/my_bottom_bar.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late final ConfettiController _controllerCenter =
      ConfettiController(duration: const Duration(seconds: 1));

  @override
  Widget build(BuildContext context) {
    MyHomeViewModel viewModel = context.read<MyHomeViewModel>();
    viewModel.loadGame();
    _controllerCenter.play();

    Path drawStar(Size size) {
      // Method to convert degree to radians
      double degToRad(double deg) => deg * (pi / 180.0);

      const numberOfPoints = 5;
      final halfWidth = size.width / 2;
      final externalRadius = halfWidth;
      final internalRadius = halfWidth / 2.5;
      final degreesPerStep = degToRad(360 / numberOfPoints);
      final halfDegreesPerStep = degreesPerStep / 2;
      final path = Path();
      final fullAngle = degToRad(360);
      path.moveTo(size.width, halfWidth);

      for (double step = 0; step < fullAngle; step += degreesPerStep) {
        path.lineTo(halfWidth + externalRadius * cos(step),
            halfWidth + externalRadius * sin(step));
        path.lineTo(halfWidth + internalRadius * cos(step + halfDegreesPerStep),
            halfWidth + internalRadius * sin(step + halfDegreesPerStep));
      }
      path.close();
      return path;
    }

    return Scaffold(
        backgroundColor: Colors.blue,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FadeIn(
                child: Image.asset('assets/images/motus&bouche.png',
                    width: 0.6 * MediaQuery.of(context).size.width),
              ),
              const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
              Consumer<MyHomeViewModel>(
                builder: (context, viewModel, child) {
                  if (viewModel.game == null) {
                    return const CircularProgressIndicator();
                  }
                  else if (viewModel.game!.isFinished()) {
                    if (viewModel.game!.isVictory()) {
                      Game limitedGame = viewModel.game!;
                      limitedGame.limitTries = limitedGame.tries!.length;
                      return Column(
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: ConfettiWidget(
                              confettiController: _controllerCenter,
                              blastDirectionality:
                                  BlastDirectionality.explosive,
                              // don't specify a direction, blast randomly
                              shouldLoop: false,
                              minimumSize: const Size(10, 10),
                              colors: const [
                                Colors.green,
                                Colors.blue,
                                Colors.red,
                              ], // manually specify the colors to be used
                            ),
                          ),
                          GridWidget(
                            game: limitedGame,
                            currentInput: viewModel.currentInput,
                          ),
                          const Padding(padding: EdgeInsets.all(20)),
                          Wrap(
                            spacing: 5,
                            direction: Axis.vertical,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              const Text(
                                'Félicitation !',
                                style: TextStyle(
                                    fontSize: 30,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              const Text('Vous avez trouvé le mot',
                                  style: TextStyle(
                                      fontSize: 25, color: Colors.white)),
                              Text(viewModel.game!.word!.word,
                                  style: const TextStyle(
                                      fontSize: 25,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold)),
                              Text(
                                  'en ${viewModel.game!.tries!.length} essais !',
                                  style: const TextStyle(
                                      fontSize: 25, color: Colors.white)),
                              Text(
                                '+${viewModel.game!.score} points',
                                style: const TextStyle(
                                    fontSize: 25,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              const Text(
                                'Revenez dans 24h pour remettre votre victoire en jeu !',
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ],
                      );
                    }
                    else {
                      Game limitedGame = viewModel.game!;

                      return Column(
                        children: [
                          GridWidget(
                            game: limitedGame,
                            currentInput: viewModel.currentInput,
                          ),
                          const Divider(
                            color: Colors.white,
                            endIndent: 90,
                            indent: 90,
                          ),
                          RowWidget(
                              rowLength: limitedGame.word!.wordLength(),
                              tryWord: Try(
                                  'goodWordTry',
                                  limitedGame.word!.word,
                                  List.generate(limitedGame.tries!.length,
                                      (index) => LetterState.valid))),
                          const Padding(padding: EdgeInsets.all(20)),
                          Wrap(
                            spacing: 5,
                            direction: Axis.vertical,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              const Text(
                                'Défaite !',
                                style: TextStyle(
                                    fontSize: 30,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              const Text('Il fallait trouver le mot',
                                  style: TextStyle(
                                      fontSize: 25, color: Colors.white)),
                              Text(viewModel.game!.word!.word,
                                  style: const TextStyle(
                                      fontSize: 25,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold)),
                              const Text(
                                'Retentez votre chance dans 24h !',
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          )
                        ],
                      );
                    }
                  }
                  else {
                    return Column(children: [
                      Align(
                        alignment: Alignment.topCenter,
                        child: IconButton(
                          icon: Image.asset('assets/images/hint_icon.png'),
                          iconSize: 50,
                          padding: const EdgeInsets.only(bottom: 30),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return Dialog(
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                  elevation: 16,
                                  child: SizedBox(
                                    height: 120.0,
                                    width: MediaQuery.of(context).size.width * 0.8,
                                    child: ListView(
                                      children: <Widget>[
                                        const SizedBox(height: 20),
                                        const Center(
                                          child: Text(
                                            "Solution",
                                            style: TextStyle(fontSize: 24, color: Colors.blue, fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        const SizedBox(height: 20),
                                        Center(
                                          child: Text(
                                            viewModel.game!.word!.word,
                                            style: const TextStyle(fontSize: 20, color: Colors.green),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ),
                      GridWidget(
                        game: viewModel.game!,
                        currentInput: viewModel.currentInput,
                      ),
                      const Padding(padding: EdgeInsets.only(top: 40)),
                      KeyboardWidget(
                        onKeyPressed: viewModel.onKeyboardKeyPressed,
                        overlay: viewModel.game!.getKeyboardOverlay(),
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
