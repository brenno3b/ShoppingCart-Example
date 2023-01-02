import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppingcart_example/data/entities/index.dart';
import 'package:shoppingcart_example/logic/index.dart';
import 'package:shoppingcart_example/ui/screens/product_form.dart';

import '../../logic/product_form.dart';

class ShoppingCartScreen extends StatelessWidget {
  const ShoppingCartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ShoppingCartCubit>();

    return Scaffold(
      appBar: AppBar(title: const Text('My Cart'), centerTitle: true),
      body: BlocBuilder<ShoppingCartCubit, List<ShoppingCartItem>>(
        builder: (context, state) {
          if (state.isEmpty) {
            return const Center(child: Text('There are no items in your cart'));
          }

          return ListView.builder(
            itemBuilder: (context, index) {
              final item = state[index];

              void onItemTapped() {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => BlocProvider(
                      create: (_) => ProductFormCubit(
                        state: ProductFormState(
                          mode: ProductFormMode.edit,
                          isFormValid: true,
                          item: item,
                        )
                      ),
                      child: const ProductFormScreen(),
                    ),
                  ),
                );
              }


              return Dismissible(
                key: ValueKey(item),
                direction: DismissDirection.endToStart,
                onDismissed: (_) {
                  cubit.itemRemoved(item);

                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(
                      const SnackBar(
                        content: Text('Item removed from the cart'),
                      ),
                    );
                },
                child: ListTile(
                  title: Text(item.product.name),
                  subtitle: Text('Quantity: ${item.quantity}'),
                  trailing: Text('Total: \$${item.total.toStringAsFixed(2)}'),
                  onTap: onItemTapped,
                ),
              );
            },
            itemCount: state.length,
          );
        },
      ),
    );
  }
}
