import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:motus_flutter/data/entities/word/word.dart';
import 'package:motus_flutter/ui/screens/home/my_home_page_viewmodel.dart';
import 'package:motus_flutter/ui/widgets/game/letter_widget.dart';
import 'package:motus_flutter/ui/widgets/game/row_widget.dart';

class GridWidget extends StatefulWidget {
  GridWidget({Key? key, required this.word}) : super(key: key);

  final Word word;

  @override
  State<GridWidget> createState() => _GridWidgetState();
}

class _GridWidgetState extends State<GridWidget> {

  late int currentRow = 3;
  late List<RowWidget> rows = [];

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(5, (index) {
          return RowWidget(word: widget.word,
              tryWord: widget.word
                  .word[0]);
        }).toList()
    );
  }
}
