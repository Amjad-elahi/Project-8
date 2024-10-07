part of 'orders_list_bloc.dart';

@immutable
sealed class OrdersListState {}

final class OrdersListInitial extends OrdersListState {}


final class OrdersState extends OrdersListState {
  final List orders;
  final List status;
  OrdersState({required this.orders, required this.status});
}

final class ErrorState extends OrdersListState {
  final String msg;
  ErrorState({required this.msg});
}


final class LoadingState extends OrdersListState {}

final class SuccessState extends OrdersListState {
}