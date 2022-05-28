import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:motus_flutter/ui/screens/home/my_home_page_viewmodel.dart';

enum KeyState {
  unused,
  invalid,
  semivalid,
  valid
}

extension KeyStateExtension on KeyState {
  Color get color {
    switch (this) {
      case KeyState.valid:
        return Colors.green;
      case KeyState.semivalid:
        return Colors.orange;
      case KeyState.invalid:
        return Colors.blueGrey;
      case KeyState.unused:
        return Colors.transparent;
      default:
        return Colors.blue;
    }
  }
}

class KeyWidget extends StatefulWidget {
  KeyWidget({Key? key, required this.letter, required this.state, required this.onKeyPressed}) : super(key: key);

  final String letter;
  final KeyState state;
  final Function onKeyPressed;

  final Map<String, Icon> customKeyToIcon = {
    'ENTER': const Icon(Icons.arrow_forward, color: Colors.white, size: 20),
    'DELETE': const Icon(Icons.backspace, color: Colors.white, size: 20),
  };

  @override
  State<KeyWidget> createState() => _KeyWidgetState();
}

class _KeyWidgetState extends State<KeyWidget> {
  @override
  Widget build(BuildContext context) {
    if(widget.letter.startsWith('#')) {
      return Container(
        width: (MediaQuery.of(context).size.width / 15) * 2 + 10,
        height: 40,
        margin: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: widget.state.color,
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
            color: Colors.white,
            width: 1,
          ),
        ),
        child: Center(
          child: IconButton(
            icon: widget.customKeyToIcon[widget.letter.replaceAll('#', '')] ?? const Icon(Icons.arrow_forward, color: Colors.white, size: 20),
            onPressed: () {
              widget.onKeyPressed(widget.letter);
            },
          )
        ),
      );
    }
    return Container(
        // responsive width
        width: MediaQuery.of(context).size.width / 15,
        height: 40,
        margin: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: widget.state.color,
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
            color: Colors.white,
            width: 1,
          ),
        ),
        child: Center(
          child: TextButton(
            onPressed: () {
              widget.onKeyPressed(widget.letter);
            },
            child: Text(widget.letter, style: const TextStyle(fontSize: 15, color: Colors.white, fontWeight: FontWeight.bold)),
          )
        ),
      );
  }
}
