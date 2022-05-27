import 'package:flutter/material.dart';
import 'package:motus_flutter/data/entities/letterState/letter_state.dart';

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
