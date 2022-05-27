import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:motus_flutter/data/entities/game/game.dart';
import 'package:motus_flutter/data/entities/word/word.dart';
import 'package:motus_flutter/ui/screens/home/my_home_page_viewmodel.dart';
import 'package:motus_flutter/ui/widgets/game/letter_widget.dart';
import 'package:motus_flutter/ui/widgets/game/row_widget.dart';

class GridWidget extends StatefulWidget {
  GridWidget({Key? key, required this.game, required this.currentInput}) : super(key: key);

  final Game game;
  String currentInput;

  @override
  State<GridWidget> createState() => _GridWidgetState();
}

class _GridWidgetState extends State<GridWidget> {

  late int currentRow = 0;

  @override
  Widget build(BuildContext context) {

    late List<RowWidget> rows = [];

    currentRow = widget.game.tries!.length;

    rows = List.generate(5, (index) {
      if(index < widget.game.tries!.length) {
        return RowWidget(rowLength: widget.game.word!.wordLength(), tryWord: widget.game.tries![index]);
      } else if (index == currentRow){
        return RowWidget(rowLength: widget.game.word!.wordLength(), currentInput: widget.currentInput);
      } else {
        return RowWidget(rowLength: widget.game.word!.wordLength());
      }
    });

    //rows.add(RowWidget(rowLength: widget.game.word!.wordLength(), currentInput: widget.currentInput));

    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: rows
    );
  }
}
