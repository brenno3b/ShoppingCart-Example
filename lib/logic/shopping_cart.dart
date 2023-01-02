import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppingcart_example/data/entities/index.dart';

class ShoppingCartCubit extends Cubit<List<ShoppingCartItem>> {
  ShoppingCartCubit() : super([]);

  void itemAdded(ShoppingCartItem item) => emit([...state, item]);

  void itemEdited(ShoppingCartItem item) {
    final list = [...state]..removeWhere((element) => element.id == item.id);

    emit([...list, item]);
  }

  void itemRemoved(ShoppingCartItem item) {
    final list = [...state]..removeWhere((element) => element.id == item.id);

    emit(list);
  }
}
