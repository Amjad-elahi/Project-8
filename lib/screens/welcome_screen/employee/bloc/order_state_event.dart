part of 'order_state_bloc.dart';

@immutable
sealed class OrderStateEvent {}


final class StartTimerEvent extends OrderStateEvent {}

final class RunTimerEvent extends OrderStateEvent {}
final class StopTimerEvent extends OrderStateEvent {}