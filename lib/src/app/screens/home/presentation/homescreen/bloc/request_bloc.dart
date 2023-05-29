import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'request_event.dart';
part 'request_state.dart';

class RequestBloc extends Bloc<RequestEvent, RequestState> {
  RequestBloc() : super(RequestInitial()) {
    on<RequestEvent>((event, emit) {
      emit(RequestInitial());
      // TODO: implement event handler
    });

    on<RequestStartEvent>((event, emit) {
      emit(RequestStartState());
    });
    on<RequestInitialEvent>((event, emit) {
      emit(RequestEndState());
    });
  }
}
