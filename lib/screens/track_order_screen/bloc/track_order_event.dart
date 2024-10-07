part of 'track_order_bloc.dart';

@immutable
sealed class TrackOrderEvent {}

final class GetTrackOrderStatusEvent extends TrackOrderEvent {
  final int? orderID;
  GetTrackOrderStatusEvent({required this.orderID});
}
