part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class SuccessState extends HomeState {}

final class LoadingState extends HomeState {}
final class SearchItemState extends HomeState {}


final class ErrorState extends HomeState {
  final String msg;
  ErrorState({required this.msg});
}