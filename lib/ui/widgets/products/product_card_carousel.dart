import 'package:flutter/material.dart';
class ProductCardCarouselWidget extends StatefulWidget {
  const ProductCardCarouselWidget({
    Key? key,
    required this.products,
  }) : super(key: key);

  final List<Widget> products;

  @override
  _ProductCardCarouselWidgetState createState() =>
      _ProductCardCarouselWidgetState();
}

class _ProductCardCarouselWidgetState extends State<ProductCardCarouselWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.all(8),
        children: widget.products,
      ),
    );
  }
}
