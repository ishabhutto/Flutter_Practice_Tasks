import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_cart/provider.dart';

class CustomColors {
  static const Color myCustomColor = Color.fromARGB(255, 46, 6, 58);
}

class Cart extends StatelessWidget {
  const Cart({super.key});

  @override
  Widget build(BuildContext context) {
    final cartItems = context.watch<CartProvider>().cartlist;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Cart',
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
      body: ListView.builder(
          itemCount: cartItems.length,
          itemBuilder: (context, index) {
            final products = cartItems[index];
            return Card(
                elevation: 4,
                margin: const EdgeInsets.all(16.0),
                child: ListTile(
                  title: Text(products.name),
                  subtitle: Text("${products.price}"),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      context.read<CartProvider>().remove(index);
                    },
                  ),
                ));
          }),
    );
  }
}
