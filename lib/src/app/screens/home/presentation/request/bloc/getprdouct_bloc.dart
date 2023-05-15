import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'getprdouct_event.dart';
part 'getprdouct_state.dart';

class GetprdouctBloc extends Bloc<GetprdouctEvent, GetprdouctState> {
  GetprdouctBloc() : super(GetprdouctInitial()) {
    on<GetprdouctEvent>((event, emit) {
      emit(GetprdouctInitial());

      // TODO: implement event handler
    });
    on<GetProdcutFetchEvent>((event, emit) {
      emit(GetProdcutFetchState());
    });
  }
}
