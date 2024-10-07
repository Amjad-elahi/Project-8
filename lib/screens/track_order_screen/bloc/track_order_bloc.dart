import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:onze_cofe_project/data_layer/data_layer.dart';

import '../../../setup/setup_init.dart';

part 'track_order_event.dart';
part 'track_order_state.dart';

class TrackOrderBloc extends Bloc<TrackOrderEvent, TrackOrderState> {
  final supabase = getIt.get<DataLayer>().supabase;
  late int orderID;
  TrackOrderBloc() : super(TrackOrderInitial()) {
    on<TrackOrderEvent>((event, emit) {});

    on<GetTrackOrderStatusEvent>((event, emit) async {
      orderID = event.orderID ?? 00;
      try {
        if (orderID == 00) {
          emit(ErrorState(msg: "No orders yet"));
        }
        while (true) {
          final status = await getStatus();
          final index = getIndex(status);
          emit(SuccessState(index: index));
          await Future.delayed(const Duration(seconds: 1));
        }
      } catch (e) {
        emit(ErrorState(msg: "No orders yet"));
      }
    });
  }
  Future<String> getStatus() async {
    final status = await supabase
        .from('orders')
        .select('status')
        .eq('order_id', orderID)
        .single();

    return status['status'];
  }

  int getIndex(String status) {
    switch (status) {
      case 'Received':
        return 0;
      case 'In progress':
        return 1;
      case 'Done':
        return 2;
      default:
        return 0;
    }
  }
}
