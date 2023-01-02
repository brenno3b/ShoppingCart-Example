import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppingcart_example/data/entities/index.dart';

class ProductFormCubit extends Cubit<ProductFormState> {
  ProductFormCubit({required ProductFormState state}) : super(state);

  onOptionSelected(ProductOptionGroup optionGroup, ProductOption option) {
    final newOptionGroup = state.item.product.optionsGroup
        .where((element) => element.id == optionGroup.id)
        .first
        .copyWith(groupValue: option);

    final optionsGroup = [...state.item.product.optionsGroup]
      ..removeWhere((element) => element.id == newOptionGroup.id)
      ..add(newOptionGroup);

    final product = state.item.product.copyWith(optionsGroup: optionsGroup);

    emit(
      state.copyWith(
          item: state.item.copyWith(
            product: product,
            total: _calcTotal(product) * state.item.quantity,
          ),
          isFormValid: _validate(product)),
    );
  }

  onQuantityChanged(int quantity) {
    if (quantity < 1) return;

    emit(state.copyWith(
      isFormValid: _validate(state.item.product),
      item: state.item.copyWith(
        total: _calcTotal(state.item.product) * quantity,
        quantity: quantity,
      ),
    ));
  }

  double _calcTotal(Product product) {
    final basePrice = product.price;

    double optionsPrice = 0.0;

    for (var optionGroup in product.optionsGroup) {
      final groupValue = optionGroup.groupValue;
      if (groupValue == null) continue;

      optionsPrice += groupValue.price;
    }

    return basePrice + optionsPrice;
  }

  bool _validate(Product product) {
    bool isValid = true;

    for (var optionGroup in product.optionsGroup) {
      if (optionGroup.isRequired && optionGroup.groupValue == null) {
        isValid = false;
      }
    }

    return isValid;
  }
}

enum ProductFormMode { add, edit }

class ProductFormState extends Equatable {
  final ProductFormMode mode;
  final bool isFormValid;
  final ShoppingCartItem item;

  const ProductFormState({
    required this.mode,
    required this.isFormValid,
    required this.item,
  });

  ProductFormState copyWith({
    ProductFormMode? mode,
    bool? isFormValid,
    ShoppingCartItem? item,
  }) {
    return ProductFormState(
      mode: mode ?? this.mode,
      isFormValid: isFormValid ?? this.isFormValid,
      item: item ?? this.item,
    );
  }

  @override
  List<Object?> get props => [mode, isFormValid, item];
}
