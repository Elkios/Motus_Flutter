import 'package:flutter/material.dart';

class ProductCardWidget extends StatefulWidget {
  const ProductCardWidget({
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
  _ProductCardWidgetState createState() => _ProductCardWidgetState();
}

class _ProductCardWidgetState extends State<ProductCardWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 220,
      child: Column(
        children: [
          SizedBox(
            height: 200,
            width: double.infinity,
            child: Image.asset(
              widget.image,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.w900,
                    )),
                Text(widget.description,
                    style: const TextStyle(fontSize: 12, color: Colors.grey)),
                Row(
                  children: [
                    Text('\$${widget.price}',
                        style: const TextStyle(
                          fontWeight: FontWeight.w900,
                        )),
                    const Spacer(),
                    // IconButton(
                    //   icon: const Icon(Icons.add),
                    //   onPressed: () {},
                    // )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
