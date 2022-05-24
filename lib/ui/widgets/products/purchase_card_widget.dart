import 'package:flutter/material.dart';

class PurchaseCardWidget extends StatefulWidget {
  const PurchaseCardWidget({
    Key? key,
    required this.name,
    required this.price,
    required this.description,
    required this.image,
  }) : super(key: key);

  final String name;
  final double price;
  final String description;
  final String image;

  get products => null;

  @override
  _PurchaseCardWidgetState createState() => _PurchaseCardWidgetState();
}

class _PurchaseCardWidgetState extends State<PurchaseCardWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      child: Column(
        children: [
          // Container(
          //   height: 200,
          //   width: double.infinity,
          //   child: Image.asset(
          //     widget.image,
          //     fit: BoxFit.cover,
          //   ),
          // ),
          Stack(alignment: Alignment.bottomLeft, children: <Widget>[
            Image.asset(
              widget.image,
              fit: BoxFit.cover,
            ),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.black),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        ))),
                    onPressed: () => {},
                    child: const Text(
                      "Purchase now",
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ))),
          ]),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(widget.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.w900,
                        )),
                    const Spacer(),
                    Text('\$${widget.price}',
                        style: const TextStyle(
                          fontWeight: FontWeight.w900,
                        )),
                  ],
                ),
                Text(widget.description,
                    style: const TextStyle(fontSize: 12, color: Colors.grey)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
