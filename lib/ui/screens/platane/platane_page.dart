import 'package:flutter/material.dart';
import 'package:motus_flutter/ui/widgets/filter_button_widget.dart';
import 'package:motus_flutter/ui/widgets/products/product_card_carousel.dart';
import 'package:motus_flutter/ui/widgets/products/product_card_widget.dart';
import 'package:motus_flutter/ui/widgets/products/purchase_card_widget.dart';

class PlatanePage extends StatefulWidget {
  const PlatanePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _PlatanePageState();
}

class _PlatanePageState extends State<PlatanePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const TextField(
          decoration: InputDecoration(
              prefixIcon: Icon(Icons.search),
              hintText: 'Search for a product brand ...',
              border: InputBorder.none),
        ),
      ),
      body: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(children: [
            SizedBox(
                height: 40,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.all(8),
                  children: const [
                    FilterButtonWidget(
                        name: "Fruit", icon: Icons.mark_email_read),
                    FilterButtonWidget(
                        name: "Meat", icon: Icons.mark_email_read),
                    FilterButtonWidget(
                        name: "Baker", icon: Icons.mark_email_read),
                    FilterButtonWidget(
                        name: "Fruit", icon: Icons.mark_email_read),
                    FilterButtonWidget(
                        name: "Meat", icon: Icons.mark_email_read),
                    FilterButtonWidget(
                        name: "Baker", icon: Icons.mark_email_read),
                  ],
                )),
            Row(
              children: [
                const Text('Recommended Pinned',
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const Spacer(),
                TextButton(
                    onPressed: () {},
                    child: Text(
                      'See all',
                      style: TextStyle(
                          color: Colors.grey.shade500,
                          fontWeight: FontWeight.w600),
                    )),
              ],
            ),
            const ProductCardCarouselWidget(products: [
              PurchaseCardWidget(
                  name: 'Beach Party',
                  price: 125.0,
                  description: 'little description of beach party',
                  image: 'assets/images/beach_party.jpg'),
              PurchaseCardWidget(
                  name: 'Beach Party',
                  price: 125.0,
                  description: 'little description of beach party',
                  image: 'assets/images/beach_party.jpg'),
              PurchaseCardWidget(
                  name: 'Beach Party',
                  price: 125.0,
                  description: 'little description of beach party',
                  image: 'assets/images/beach_party.jpg'),
              PurchaseCardWidget(
                  name: 'Beach Party',
                  price: 125.0,
                  description: 'little description of beach party',
                  image: 'assets/images/beach_party.jpg'),
              PurchaseCardWidget(
                  name: 'Beach Party',
                  price: 125.0,
                  description: 'little description of beach party',
                  image: 'assets/images/beach_party.jpg'),
            ]),
            Row(
              children: [
                const Text('Fruit Result',
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const Spacer(),
                Text(
                  '200 items',
                  style: TextStyle(
                      color: Colors.grey.shade500, fontWeight: FontWeight.w600),
                )
              ],
            ),
            const ProductCardCarouselWidget(products: [
              ProductCardWidget(
                  name: 'Beach Party',
                  price: 125.0,
                  description: 'little description of beach party',
                  image: 'assets/images/beach_party.jpg'),
              ProductCardWidget(
                  name: 'Beach Party',
                  price: 125.0,
                  description: 'little description of beach party',
                  image: 'assets/images/beach_party.jpg'),
              ProductCardWidget(
                  name: 'Beach Party',
                  price: 125.0,
                  description: 'little description of beach party',
                  image: 'assets/images/beach_party.jpg'),
              ProductCardWidget(
                  name: 'Beach Party',
                  price: 125.0,
                  description: 'little description of beach party',
                  image: 'assets/images/beach_party.jpg'),
              ProductCardWidget(
                  name: 'Beach Party',
                  price: 125.0,
                  description: 'little description of beach party',
                  image: 'assets/images/beach_party.jpg'),
            ]),
          ])),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.explore), label: 'Explore'),
          BottomNavigationBarItem(icon: Icon(Icons.feed), label: 'Feed'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
