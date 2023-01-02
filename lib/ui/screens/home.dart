import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppingcart_example/data/entities/index.dart';
import 'package:shoppingcart_example/logic/product_form.dart';
import 'package:shoppingcart_example/ui/screens/shopping_cart.dart';

import 'product_form.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  final _products = const [
    Product(
      id: 1,
      name: 'Caffe Latte',
      price: 2.95,
      optionsGroup: [
        ProductOptionGroup(
          id: 1,
          name: 'Size',
          description: 'Choose one size',
          isRequired: true,
          options: [
            ProductOption(
              id: 1,
              price: 0.0,
              name: 'Small',
            ),
            ProductOption(
              id: 2,
              price: 0.60,
              name: 'Medium',
            ),
            ProductOption(
              id: 3,
              price: 1.00,
              name: 'Large',
            ),
          ],
        ),
      ],
    ),
    Product(
      id: 2,
      name: 'Caffe Mocha',
      price: 3.45,
      optionsGroup: [
        ProductOptionGroup(
          id: 1,
          name: 'Size',
          description: 'Choose one size',
          isRequired: true,
          options: [
            ProductOption(
              id: 1,
              price: 0.0,
              name: 'Small',
            ),
            ProductOption(
              id: 2,
              price: 0.50,
              name: 'Medium',
            ),
          ],
        ),
      ],
    ),
    Product(
      id: 3,
      name: 'White Chocolate Mocha',
      price: 3.75,
      optionsGroup: [
        ProductOptionGroup(
          id: 1,
          name: 'Size',
          description: 'Choose one size',
          isRequired: true,
          options: [
            ProductOption(
              id: 1,
              price: 0.0,
              name: 'Small',
            ),
            ProductOption(
              id: 2,
              price: 0.80,
              name: 'Medium',
            ),
            ProductOption(
              id: 3,
              price: 1.40,
              name: 'Large',
            ),
            ProductOption(
              id: 4,
              price: 2.0,
              name: 'Extra Large',
            ),
          ],
        ),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ShoppingCart Example'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const ShoppingCartScreen(),
                ),
              );
            },
            icon: const Icon(Icons.shopping_cart_rounded),
          )
        ],
      ),
      body: ListView(
        children: _products.map((product) {
          void onItemTapped() {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => BlocProvider(
                  create: (_) => ProductFormCubit(
                    state: ProductFormState(
                      mode: ProductFormMode.add,
                      isFormValid: false,
                      item: ShoppingCartItem(
                        quantity: 1,
                        product: product,
                        total: product.price,
                      ),
                    ),
                  ),
                  child: const ProductFormScreen(),
                ),
              ),
            );
          }

          return ListTile(
            title: Text(product.name),
            subtitle: Text('\$${product.price}'),
            onTap: onItemTapped,
          );
        }).toList(),
      ),
    );
  }
}
