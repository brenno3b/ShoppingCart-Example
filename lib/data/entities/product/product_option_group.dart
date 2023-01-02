import 'package:equatable/equatable.dart';

import 'product_option.dart';

class ProductOptionGroup extends Equatable {
  final int id;
  final String name;
  final String description;
  final bool isRequired;
  final ProductOption? groupValue;
  final List<ProductOption> options;

  const ProductOptionGroup({
    required this.id,
    required this.name,
    required this.description,
    required this.isRequired,
    required this.options,
    this.groupValue,
  });

  ProductOptionGroup copyWith({
    int? id,
    String? name,
    String? description,
    bool? isRequired,
    ProductOption? groupValue,
    List<ProductOption>? options,
  }) {
    return ProductOptionGroup(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      isRequired: isRequired ?? this.isRequired,
      groupValue: groupValue ?? this.groupValue,
      options: options ?? this.options,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        isRequired,
        groupValue,
        options,
      ];
}
