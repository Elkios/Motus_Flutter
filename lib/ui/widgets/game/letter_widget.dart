import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:motus_flutter/ui/screens/home/my_home_page_viewmodel.dart';

enum LetterState {
  valid,
  invalid,
  semivalid,
  empty
}

extension LetterStateExtension on LetterState {
  Color get color {
    switch (this) {
      case LetterState.valid:
        return Colors.green;
      case LetterState.semivalid:
        return Colors.orange;
      case LetterState.invalid:
        return Colors.transparent;
      case LetterState.empty:
        return Colors.transparent;
      default:
        return Colors.blue;
    }
  }
}

class LetterWidget extends StatefulWidget {
  const LetterWidget({Key? key, required this.letter, required this.state}) : super(key: key);

  final String letter;
  final LetterState state;

  @override
  State<LetterWidget> createState() => _LetterWidgetState();
}

class _LetterWidgetState extends State<LetterWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: 40,
        height: 40,
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: widget.state.color,
          border: Border.all(
            color: Colors.white,
            width: 1,
          ),
        ),
        child: Center(
          child: Text(widget.letter, style: const TextStyle(fontSize: 25, color: Colors.white, fontWeight: FontWeight.bold))
        ),
      );
  }
}
