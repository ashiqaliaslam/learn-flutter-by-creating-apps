import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      home: Scaffold(
        body: ShoppingList(
          products: [
            Product(name: 'Chip'),
            Product(name: 'Apple'),
            Product(name: 'Slanty'),
          ],
        ),
      ),
    ),
  );
}

class ShoppingList extends StatefulWidget {
  const ShoppingList({super.key, required this.products});

  final List<Product> products;

  @override
  State<ShoppingList> createState() => _ShoppingListState();
}

class _ShoppingListState extends State<ShoppingList> {
  final _shoppingCart = <Product>{};

  void _handleCartChanged(Product product, bool inCart) {
    if (!inCart) {
      _shoppingCart.add(product);
    } else {
      _shoppingCart.remove(product);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: widget.products.map((product) {
        return ShoppingListItem(
          product: product,
          inCart: _shoppingCart.contains(product),
          onChanged: _handleCartChanged,
        );
      }).toList(),
    );
  }
}

class ShoppingListItem extends StatelessWidget {
  const ShoppingListItem({
    super.key,
    required this.product,
    required this.inCart,
    required this.onChanged,
  });

  final Product product;
  final bool inCart;
  final CartChangedCallback onChanged;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(product.name),
    );
  }
}

class Product {
  const Product({required this.name});

  final String name;
}

typedef CartChangedCallback = Function(Product product, bool inCart);
