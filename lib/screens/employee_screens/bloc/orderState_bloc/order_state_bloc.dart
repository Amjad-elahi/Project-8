import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../data_layer/data_layer.dart';
import '../../../../setup/setup_init.dart';

part 'order_state_event.dart';
part 'order_state_state.dart';

class OrderStateBloc extends Bloc<OrderStateEvent, OrderStateState> {
  Timer? timer;
  final supabase = getIt.get<DataLayer>().supabase;

  OrderStateBloc() : super(OrderStateInitial()) {
    // void initRealTimeListeners() {
    //   supabase
    //       .channel('public:orders')
    //       .onPostgresChanges(
    //           event: PostgresChangeEvent.all,
    //           schema: 'public',
    //           table: 'orders',
    //           callback: (payload) {
    //             print('Change received: ${payload.toString()}');
    //             add(GetOrdersEvent());
    //           })
    //       .subscribe();
    // }

    // initRealTimeListeners();

    on<StartTimerEvent>((event, emit) async {
      try {
        final orderID = event.orderID;
        await supabase
            .from('orders')
            .update({'status': 'In progress'}).eq('order_id', orderID);

        final orderWaitingTime = await supabase
            .from('orders')
            .select()
            .eq('order_id', orderID)
            .single();

        final seconds = orderWaitingTime['order_time'];
        final minutes = (orderWaitingTime['order_time'] * 60);
        print(seconds);
        print(minutes);

        startTimer(minutes);
        emit(RunningState(seconds: minutes));
      } on AuthException catch (e) {
        emit(ErrorState(msg: e.message));
      } on PostgrestException catch (e) {
        emit(ErrorState(msg: e.message));
      } catch (e) {
        emit(ErrorState(msg: e.toString()));
      }
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

    on<StopTimerEvent>((event, emit) async {
      timer?.cancel();
      final orderID = event.orderID;
      await supabase
          .from('orders')
          .update({'status': 'Done'}).eq('order_id', orderID);
    });

    on<GetOrdersItemEvent>((event, emit) async {
      emit(LoadingState());
      try {
        final orderItems = await getOrderItems(event.orderID);
        emit(OrdersItemState(
          orderItem: List<Map<String, dynamic>>.from(orderItems),
        ));
      } on AuthException catch (e) {
        emit(ErrorState(msg: e.message));
      } on PostgrestException catch (e) {
        emit(ErrorState(msg: e.message));
      } catch (e) {
        emit(ErrorState(msg: e.toString()));
      }
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

  Future<List<Map<String, dynamic>>> getOrderItems(int orderID) async {
    try {
      /* 
    * join tables
    * select all column from orders_items and image_url, name and price from product
    */
      final orderItems = await supabase
          .from('order_items')
          .select('*, product (image_url, name, price)')
          .eq('order_id', orderID);

      return orderItems;
    } catch (e) {
      print('Error fetching order items: $e');
      return [];
    }
  }
}
