part of 'tab_bloc_bloc.dart';

@immutable
abstract class TabBlocEvent {}
class TabInitialEvent extends TabBlocEvent{}
class GetTabLengthEvent extends TabBlocEvent{}
