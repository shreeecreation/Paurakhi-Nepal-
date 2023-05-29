import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'finance_event.dart';
part 'finance_state.dart';

class FinanceBloc extends Bloc<FinanceEvent, FinanceState> {
  FinanceBloc() : super(FinanceInitial()) {
    on<FinanceEvent>((event, emit) {
      emit(FinanceInitial());

      // TODO: implement event handler
    });
    on<FetchFinanceEvent>((event, emit) {
      emit(FetchFinanceState());
    });

    on<SearchFinanceEvent>((event, emit) {
      emit(SearchFinanceState());
    });

    on<SearchedFinanceEvent>((event, emit) {
      emit(SearchedFinanceState());
    });
  }
}
