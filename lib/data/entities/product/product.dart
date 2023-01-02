import 'package:equatable/equatable.dart';

import 'product_option_group.dart';

class Product extends Equatable {
  final int id;
  final String name;
  final double price;
  final List<ProductOptionGroup> optionsGroup;

  const Product({
    required this.id,
    required this.name,
    required this.price,
    required this.optionsGroup,
  });

  Product copyWith({
    int? id,
    String? name,
    double? price,
    List<ProductOptionGroup>? optionsGroup,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      optionsGroup: optionsGroup ?? this.optionsGroup,
    );
  }

  @override
  List<Object?> get props => [id, name, price, optionsGroup];
}