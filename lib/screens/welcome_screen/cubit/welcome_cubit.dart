import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'welcome_state.dart';

class WelcomeCubit extends Cubit<WelcomeState> {
  int currentPage = 0;
  WelcomeCubit() : super(WelcomeInitial());

  void goToPage(int pageIndex) {
    currentPage = pageIndex;
    emit(WelcomeInitial());
  }

  void nextPage() {
    if (currentPage < 2) {
      currentPage++;
      emit(WelcomeInitial());
    }
  }
}
