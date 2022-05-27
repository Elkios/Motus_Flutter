import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:motus_flutter/data/entities/word/word.dart';
import 'package:motus_flutter/ui/screens/home/my_home_page_viewmodel.dart';
import 'package:motus_flutter/ui/widgets/game/letter_widget.dart';
import 'package:motus_flutter/ui/widgets/keyboard/keyboard_key_widget.dart';

class RowWidget extends StatefulWidget {
  const RowWidget({Key? key, required this.word, required this.tryWord}) : super(key: key);

  final Word word;
  final String tryWord;

  @override
  State<RowWidget> createState() => _RowWidgetState();
}

class _RowWidgetState extends State<RowWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children:
          // generate word length LetterWidget
          List.generate(widget.word.wordLength(), (index) {
            return LetterWidget(
              // char at index of tryWord
              letter: widget.tryWord.length > index ? widget.tryWord[index] : '',
              state: index == 0 ? LetterState.valid : LetterState.empty,
            );
          }).toList(),

    );
  }
}
