import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../data_layer/data_layer.dart';
import '../../../../setup/setup_init.dart';

part 'orders_list_event.dart';
part 'orders_list_state.dart';

class OrdersListBloc extends Bloc<OrdersListEvent, OrdersListState> {
  final supabase = getIt.get<DataLayer>().supabase;
  OrdersListBloc() : super(OrdersListInitial()) {
    on<OrdersListEvent>((event, emit) {});

    void initRealTimeListeners() {
      supabase
          .channel('public:orders')
          .onPostgresChanges(
              event: PostgresChangeEvent.all,
              schema: 'public',
              table: 'orders',
              callback: (payload) {
                print('Change received: ${payload.toString()}');
                add(GetOrdersEvent());
              })
          .subscribe();
    }

    initRealTimeListeners();

    on<GetOrdersEvent>((event, emit) async {
      emit(LoadingState());
      try {
        final orders = await supabase
            .from('orders')
            .select('*, users!orders_user_id_fkey(name)')
            .order('date');

        final orderStatus = orders.map((state) => state['status']).toList();
        emit(OrdersState(orders: orders, status: orderStatus));
      } catch (e) {
        emit(ErrorState(msg: e.toString()));
      }
    });
  }
}
