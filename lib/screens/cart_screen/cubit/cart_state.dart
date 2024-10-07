part of 'cart_cubit.dart';

@immutable
sealed class CartState {}

final class CartInitial extends CartState {
  CartInitial();
}

final class CartLoading extends CartState {}

final class CartSuccess extends CartState {
  final double totalPrice;
  final List<Map<String, dynamic>> cartItems; // List of items in the cart

  CartSuccess({
    required this.totalPrice,
    required this.cartItems, // Updated to hold the list of cart items
  });
}

final class CartError extends CartState {
  final String message;

  CartError({required this.message});
}
