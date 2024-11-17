import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'currency_state_event.dart';
part 'currency_state_state.dart';

class CurrencyStateBloc extends Bloc<CurrencyStateEvent, CurrencyStateState> {
  CurrencyStateBloc() : super(CurrencyStateInitial()) {
    on<CurrencyStateEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
