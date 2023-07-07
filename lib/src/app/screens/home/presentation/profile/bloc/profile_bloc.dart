import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitial()) {
    on<ProfileEvent>((event, emit) {});
    on<ProfileLoadEvent>((event, emit) {
      emit(ProfileLoadedState());
    });

    on<ProfileLoading>((event, emit) {
      emit(ProfileInitial());
    });
  }
}
