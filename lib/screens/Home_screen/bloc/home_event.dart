part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

final class LoadScreenEvent extends HomeEvent {}

final class FilterSelectedEvent extends HomeEvent {
  final String selectedFilter;
  FilterSelectedEvent({required this.selectedFilter});
}

final class SearchEvent extends HomeEvent {}
