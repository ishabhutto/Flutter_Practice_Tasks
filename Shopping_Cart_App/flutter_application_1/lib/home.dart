import 'package:flutter/material.dart';
import 'package:shopping_cart/cart.dart';
import 'package:provider/provider.dart';
import 'package:shopping_cart/provider.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class CustomColors {
  static const Color myCustomColor = Color.fromARGB(255, 46, 6, 58);
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final items = context.watch<CartProvider>().itemslist;
    // final cartItems = context.watch<CartProvider>().cartlist;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Our Products',
          style: TextStyle(
            color: Colors.white,
            fontSize: 27,
          ),
        ),
        backgroundColor: CustomColors.myCustomColor,
        actions: const [
          Icon(Icons.search),
          SizedBox(width: 25),
          Icon(Icons.notifications),
          SizedBox(width: 25),
          Icon(Icons.shopping_cart),
          SizedBox(width: 70),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final products = items[index];
                    return Card(
                        elevation: 4,
                        margin: const EdgeInsets.all(16.0),
                        child: ListTile(
                          title: Text(products.name),
                          subtitle: Text("${products.price}"),
                          trailing: IconButton(
                            icon: const Icon(Icons.shopping_cart),
                            onPressed: () {
                              context
                                  .read<CartProvider>()
                                  .cartItems
                                  .add(products);
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Added to Cart'),
                                  duration: Duration(seconds: 2),
                                ),
                              );
                            },
                          ),
                        ));
                  }),
            ),
            const SizedBox(height: 15.0),
            Align(
                alignment: Alignment.bottomRight,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const Cart()));
                  },
                  icon: const Icon(Icons.shopping_bag),
                  label:
                      const Text('View Cart', style: TextStyle(fontSize: 14)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: CustomColors.myCustomColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 16),
                    minimumSize: const Size(100, 40),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
