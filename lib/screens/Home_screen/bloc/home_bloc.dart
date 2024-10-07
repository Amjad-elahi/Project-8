import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:onze_cofe_project/data_layer/data_layer.dart';
import 'package:onze_cofe_project/setup/setup_init.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final supabase = getIt.get<DataLayer>().supabase;
  List<Map<String, dynamic>> filteredQuery = [];
  String searchQuery = '';
  String? selectedFilter = 'All';
  List<Map<String, dynamic>> items = [];
  HomeBloc() : super(HomeInitial()) {
    //will load first when landing on home screen
    on<LoadScreenEvent>((event, emit) async {
      emit(LoadingState());
      try {
        final productIDResponse = await supabase.from("product").select();

        items = List<Map<String, dynamic>>.from(productIDResponse);
        filteredQuery = items
            .where((e) => e['name']
                .toString()
                .toLowerCase()
                .contains(searchQuery.toLowerCase()))
            .toList();

        emit(SuccessState());
      } on AuthException catch (e) {
        emit(ErrorState(msg: e.message));
      } on PostgrestException catch (e) {
        emit(ErrorState(msg: e.message));
      } catch (e) {
        emit(ErrorState(msg: e.toString()));
      }
    });
    //

    on<SearchEvent>((event, emit) {
      filteredQuery = items
          .where((e) => e['name']
              .toString()
              .trim()
              .toLowerCase()
              .contains(searchQuery.trim().toLowerCase()))
          .toList();

      emit(SearchItemState());
    });

    ///search
    on<FilterSelectedEvent>((event, emit) async {
      emit(LoadingState());
      try {
        final productIDResponse = await supabase
            .from("product")
            .select()
            .eq("category", event.selectedFilter);

        filteredQuery = List<Map<String, dynamic>>.from(productIDResponse);

        emit(SuccessState());
      } on AuthException catch (e) {
        emit(ErrorState(msg: e.message));
      } on PostgrestException catch (e) {
        emit(ErrorState(msg: e.message));
      } catch (e) {
        emit(ErrorState(msg: e.toString()));
      }
    });
  }
}
