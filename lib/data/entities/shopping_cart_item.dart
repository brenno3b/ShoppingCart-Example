import 'package:equatable/equatable.dart';
import 'package:shoppingcart_example/data/entities/product/index.dart';
import 'package:uuid/uuid.dart';

class ShoppingCartItem extends Equatable {
  final String id;
  final double total;
  final int quantity;
  final Product product;

  ShoppingCartItem({
    required this.total,
    required this.quantity,
    required this.product,
    String? id,
  }) : id = id ?? const Uuid().v1();

  ShoppingCartItem copyWith({
    String? id,
    double? total,
    int? quantity,
    Product? product,
  }) {
    return ShoppingCartItem(
      id: id ?? this.id,
      total: total ?? this.total,
      quantity: quantity ?? this.quantity,
      product: product ?? this.product,
    );
  }

  @override
  List<Object?> get props => [id, total, quantity, product];

}