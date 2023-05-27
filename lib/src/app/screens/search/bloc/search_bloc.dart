import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchInitialState()) {
    on<SearchInitialEvent>((event, emit) {
      emit(SearchInitialState()); // TODO: implement event handler
    });

    on<SearchStartEvent>(
      (event, emit) {
        emit(SearchStartState());
      },
    );

      on<ResetStartEvent>(
      (event, emit) {
        emit(ResetStartState());
      },
    );
    on<SearchedEvent>((event,emit){
      emit(SearchedState());
    });
  }
}
