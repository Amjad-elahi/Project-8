import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'order_state_event.dart';
part 'order_state_state.dart';

class OrderStateBloc extends Bloc<OrderStateEvent, OrderStateState> {
  Timer? timer;

  OrderStateBloc() : super(OrderStateInitial()) {
    on<OrderStateEvent>((event, emit) {});

    on<StartTimerEvent>((event, emit) {
      startTimer(60);
      emit(RunningState(seconds: 60));
    });

    on<RunTimerEvent>((event, emit) {
      if (state is RunningState) {
        final seconds = (state as RunningState).seconds - 1;
        if (seconds > 0) {
          emit(RunningState(seconds: seconds));
        } else {
          emit(StoppedState());
        }
      }
    });

    on<StopTimerEvent>((event, emit) {
      timer?.cancel();
    });
  }

  void startTimer(int seconds) {
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      add(RunTimerEvent());
    });
  }

  @override
  Future<void> close() {
    timer?.cancel();
    return super.close();
  }
}
