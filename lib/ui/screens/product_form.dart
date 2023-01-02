import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppingcart_example/logic/product_form.dart';
import 'package:shoppingcart_example/logic/index.dart';

import '../../data/entities/index.dart';

class ProductFormScreen extends StatelessWidget {
  const ProductFormScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ProductFormCubit>();
    final product = context.watch<ProductFormCubit>().state.item.product;

    return Scaffold(
      appBar: AppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 16.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              product.name,
              style: Theme.of(context).textTheme.headline6,
              textAlign: TextAlign.start,
            ),
          ),
          const SizedBox(height: 16.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              '\$${product.price}',
              style: Theme.of(context).textTheme.headline4,
              textAlign: TextAlign.start,
            ),
          ),
          const Divider(),
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) {
                final optionGroup = product.optionsGroup[index];
                return ProductOptionGroupSelection(optionGroup);
              },
              itemCount: product.optionsGroup.length,
            ),
          ),
          BlocBuilder<ProductFormCubit, ProductFormState>(builder: (_, state) {
            void onSubmit() {
              if (!state.isFormValid) return;

              if (state.mode == ProductFormMode.add) {
                final item = ShoppingCartItem(
                  total: state.item.total,
                  quantity: state.item.quantity,
                  product: state.item.product,
                );

                context.read<ShoppingCartCubit>().itemAdded(item);

                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    const SnackBar(content: Text('Item added to the cart')),
                  );
              } else {
                final item = context.read<ProductFormCubit>().state.item;

                context.read<ShoppingCartCubit>().itemEdited(item);

                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    const SnackBar(content: Text('Item edited')),
                  );
              }

              Navigator.pop(context);
            }

            void onRemoveTapped() {
              cubit.onQuantityChanged(state.item.quantity - 1);
            }

            void onAddTapped() {
              cubit.onQuantityChanged(state.item.quantity + 1);
            }

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                          onPressed:
                              state.item.quantity == 1 ? null : onRemoveTapped,
                          icon: const Icon(Icons.remove),
                        ),
                        Text('${state.item.quantity}'),
                        IconButton(
                          onPressed: onAddTapped,
                          icon: const Icon(Icons.add),
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: state.isFormValid ? onSubmit : null,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(state.mode == ProductFormMode.add
                            ? 'ADD PRODUCT'
                            : 'EDIT PRODUCT'),
                        const SizedBox(width: 32),
                        Text('\$${state.item.total.toStringAsFixed(2)}'),
                      ],
                    ),
                  ),
                ],
              ),
            );
          })
        ],
      ),
    );
  }
}

class ProductOptionGroupSelection extends StatelessWidget {
  const ProductOptionGroupSelection(this.optionGroup, {super.key});

  final ProductOptionGroup optionGroup;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ProductFormCubit>();

    void onOptionSelected(ProductOption? option) {
      if (option == null) return;

      cubit.onOptionSelected(optionGroup, option);
    }

    return BlocBuilder<ProductFormCubit, ProductFormState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              color: const Color(0xFFD6D6D6),
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    optionGroup.name,
                    style: Theme.of(context).textTheme.headline6,
                    textAlign: TextAlign.start,
                  ),
                  Text(optionGroup.description),
                ],
              ),
            ),
            ...optionGroup.options.map((option) {
              return RadioListTile<ProductOption>(
                title: Text(option.name),
                subtitle: Text('\$${option.price}'),
                groupValue: optionGroup.groupValue,
                value: option,
                onChanged: onOptionSelected,
              );
            }).toList()
          ],
        );
      },
    );
  }
}
