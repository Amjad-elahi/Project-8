part of 'order_state_bloc.dart';

@immutable
sealed class OrderStateState {}

final class OrderStateInitial extends OrderStateState {}

final class RunningState extends OrderStateState {
  final int seconds;
  RunningState({required this.seconds});
}

final class StoppedState extends OrderStateState {}
