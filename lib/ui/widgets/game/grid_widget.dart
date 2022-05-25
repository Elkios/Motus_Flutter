import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:motus_flutter/data/entities/word/word.dart';
import 'package:motus_flutter/ui/screens/home/my_home_page_viewmodel.dart';
import 'package:motus_flutter/ui/widgets/game/letter_widget.dart';
import 'package:motus_flutter/ui/widgets/game/row_widget.dart';

class GridWidget extends StatefulWidget {
  GridWidget({Key? key, required this.word}) : super(key: key);

  final Word word;
  RowWidget? currentRow;

  @override
  State<GridWidget> createState() => _GridWidgetState();
}

class _GridWidgetState extends State<GridWidget> {

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children:
        /*widget.word.word.split('').map<Widget>((letter) {
          return LetterWidget(letter: letter, state: LetterState.empty);
        }).toList(),*/
        // generate 5 rows
        List.generate(5, (index) {
          return RowWidget(word: widget.word);
        }).toList(),
    );
  }
}
