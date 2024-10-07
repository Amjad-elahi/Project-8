part of 'track_order_bloc.dart';

@immutable
sealed class TrackOrderState {}

final class TrackOrderInitial extends TrackOrderState {}

final class LoadingState extends TrackOrderState {}

final class SuccessState extends TrackOrderState {
  final int index;
  SuccessState({required this.index});
}
final class ErrorState extends TrackOrderState {
  final String msg;
  ErrorState({required this.msg});
}