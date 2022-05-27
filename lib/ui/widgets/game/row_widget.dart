import 'dart:io';

import 'package:flutter/material.dart';
import 'package:motus_flutter/data/entities/letterState/letter_state.dart';
import 'package:motus_flutter/data/entities/try/try.dart';
import 'package:motus_flutter/ui/widgets/game/letter_widget.dart';

class RowWidget extends StatefulWidget {
  RowWidget(
      {Key? key, required this.rowLength, this.tryWord, this.currentInput, this.overlay})
      : super(key: key);

  Try? tryWord;
  String? currentInput;
  List<String>? overlay;
  int rowLength;

  @override
  State<RowWidget> createState() => _RowWidgetState();
}

class _RowWidgetState extends State<RowWidget> {
  @override
  Widget build(BuildContext context) {
    List<LetterWidget> letters = [];

    if (widget.tryWord != null) {
      widget.tryWord!.lettersState.asMap().forEach((index, letterState) {
        letters.add(LetterWidget(
            letter: widget.tryWord!.word.characters.elementAt(index),
            state: letterState));
      });
    } else if (widget.currentInput != null) {
      letters = List.generate(widget.rowLength, (index) {
        return LetterWidget(
          letter: widget.currentInput!.length > index
              ? widget.currentInput![index]
              : widget.overlay![index],
          state: index == 0 ? LetterState.valid : LetterState.empty,
        );
      }).toList();
    } else {
      letters = List.generate(widget.rowLength, (index) {
        return const LetterWidget(
          letter: '',
          state: LetterState.empty,
        );
      }).toList();
    }
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: letters);
  }
}
