import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'tab_bloc_event.dart';
part 'tab_bloc_state.dart';

class TabBlocBloc extends Bloc<TabBlocEvent, TabBlocState> {
  TabBlocBloc() : super(TabBlocInitial()) {
    on<TabInitialEvent>((event, emit) {
      emit(TabBlocInitial());
    });
    on<GetTabLengthEvent>((event, emit) {
      emit(GetTabLengthState());
    });
  }
}
