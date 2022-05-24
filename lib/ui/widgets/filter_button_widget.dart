import 'package:flutter/material.dart';

class FilterButtonWidget extends StatefulWidget {
  const FilterButtonWidget({Key? key, required this.name, required this.icon})
      : super(key: key);

  final String name;
  final IconData icon;

  @override
  _FilterButtonWidgetState createState() => _FilterButtonWidgetState();
}

class _FilterButtonWidgetState extends State<FilterButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return Chip(
        backgroundColor: Colors.transparent,
        avatar: CircleAvatar(
          backgroundColor: Colors.white,
          child: CircleAvatar(
            backgroundColor: Colors.grey.shade300,
            child: Icon(
              widget.icon,
              color: Colors.black,
              size: 15,
            ),
          ),
        ),
        label: Text(
          widget.name,
        ));
  }
}
