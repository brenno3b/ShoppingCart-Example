import 'package:equatable/equatable.dart';

class ProductOption extends Equatable {
  final int id;
  final String name;
  final double price;

  const ProductOption({
    required this.id,
    required this.name,
    required this.price,
  });

  ProductOption copyWith({
    int? id,
    String? name,
    double? price,
  }) {
    return ProductOption(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
    );
  }

  @override
  List<Object?> get props => [id, name, price];
}