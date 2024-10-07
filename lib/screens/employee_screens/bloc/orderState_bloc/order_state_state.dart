part of 'order_state_bloc.dart';

@immutable
sealed class OrderStateState {}

final class OrderStateInitial extends OrderStateState {}

final class RunningState extends OrderStateState {
  final int seconds;
  RunningState({required this.seconds});
}

final class StoppedState extends OrderStateState {}

final class LoadingState extends OrderStateState {}

final class SuccessState extends OrderStateState {
}


final class OrdersItemState extends OrderStateState {
  final List<Map<String, dynamic>> orderItem;
  OrdersItemState({required this.orderItem} );
}

// final class OrdersState extends OrderStateState {
//   final List orders;
//   final List status;
//   OrdersState({required this.orders, required this.status});
// }

final class ErrorState extends OrderStateState {
  final String msg;
  ErrorState({required this.msg});
}
