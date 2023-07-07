import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'grants_event.dart';
part 'grants_state.dart';

class GrantsBloc extends Bloc<GrantsEvent, GrantsState> {
  GrantsBloc() : super(GrantsInitial()) {
    on<GrantsEvent>((event, emit) {
      emit(GrantsInitial());

      // TODO: implement event handler
    });
    on<FetchGrantsEvent>((event, emit) {
      emit(FetchGrantsState());
    });

    on<SearchGrantsEvent>((event, emit) {
      emit(SearchGrantsState());
    });

    on<SearchedGrantsEvent>((event, emit) {
      emit(SearchedGrantsState());
    });
  }
}
