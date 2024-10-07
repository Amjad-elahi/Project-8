part of 'orders_list_bloc.dart';

@immutable
sealed class OrdersListEvent {}
final class GetOrdersEvent extends OrdersListEvent {}