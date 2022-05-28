import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:motus_flutter/ui/screens/home/my_home_page_viewmodel.dart';
import 'package:motus_flutter/ui/widgets/keyboard/keyboard_key_widget.dart';

class KeyboardWidget extends StatefulWidget {
  KeyboardWidget({Key? key, required this.onKeyPressed, required this.overlay}) : super(key: key);

  List<List<String>> azerty = [
    ['a', 'z', 'e', 'r', 't', 'y', 'u', 'i', 'o', 'p'],
    ['q', 's', 'd', 'f', 'g', 'h', 'j', 'k', 'l', 'm'],
    ['#delete', 'w', 'x', 'c', 'v', 'b', 'n', '#enter'],
  ];

  final Function onKeyPressed;
  final Map<String, KeyState> overlay;

  @override
  State<KeyboardWidget> createState() => _KeyWidgetState();
}

class _KeyWidgetState extends State<KeyboardWidget> {

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children:
        widget.azerty.map((row) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: row.map<Widget>((letter) {
              return KeyWidget(letter: letter.toUpperCase(), state: widget.overlay[letter] ?? KeyState.unused, onKeyPressed: widget.onKeyPressed);
            }).toList(),
          );
        }).toList(),
    );
  }
}
