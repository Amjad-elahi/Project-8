import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:onze_cofe_project/data_layer/data_layer.dart';
import 'package:onze_cofe_project/setup/setup_init.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  List<Map<String, dynamic>> cartItems; // List of items in the cart
  double priceTotal; 

  CartCubit(this.cartItems)
      : priceTotal = _calculateTotalPrice(cartItems),
        super(CartSuccess(totalPrice: _calculateTotalPrice(cartItems), cartItems: cartItems));

  static double _calculateTotalPrice(List<Map<String, dynamic>> items) {
    return items.fold(0.0, (total, item) => total + (item['price'] * item['quantity']));
  }

  void increaseQuantity(int productId) {
    try {
      final index = cartItems.indexWhere((item) => item['product_id'] == productId);
      if (index != -1) {
        // Call addToCart function with the current item
        getIt.get<DataLayer>().addToCart(item: cartItems[index]);

        // Update the cartItems and priceTotal
        priceTotal = _calculateTotalPrice(cartItems);

        emit(CartSuccess(totalPrice: priceTotal, cartItems: cartItems));
      }
    } catch (e) {
      emit(CartError(message: e.toString()));
    }
  }

  void decreaseQuantity(int productId) {
    try {
      final index = cartItems.indexWhere((item) => item['product_id'] == productId);
      if (index != -1) {
        // Call decrementItemQuantity function with the current item
        getIt.get<DataLayer>().decrementItemQuantity(item: cartItems[index]);

        // Update the cartItems and priceTotal
        priceTotal = _calculateTotalPrice(cartItems);

        emit(CartSuccess(totalPrice: priceTotal, cartItems: cartItems));
      }
    } catch (e) {
      emit(CartError(message: e.toString()));
    }
  }
}