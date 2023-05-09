import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'tab_bloc_event.dart';
part 'tab_bloc_state.dart';

class TabBlocBloc extends Bloc<TabBlocEvent, TabBlocState> {
  TabBlocBloc() : super(TabBlocInitial()) {
    on<TabBlocEvent>((event, emit) {});
    on<GetTabLengthEvent>((event, emit) {
      emit(GetTabLengthState());
    });
  }
}
