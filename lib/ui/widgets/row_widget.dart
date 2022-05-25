import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:motus_flutter/data/entities/word/word.dart';
import 'package:motus_flutter/ui/screens/home/my_home_page_viewmodel.dart';
import 'package:motus_flutter/ui/widgets/letter_widget.dart';

class RowWidget extends StatefulWidget {
  const RowWidget({Key? key, required this.word}) : super(key: key);

  final Word word;

  @override
  State<RowWidget> createState() => _RowWidgetState();
}

class _RowWidgetState extends State<RowWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children:
        widget.word.word.split('').map<Widget>((letter) {
          return LetterWidget(letter: letter, state: LetterState.valid);
        }).toList(),

    );
  }
}
