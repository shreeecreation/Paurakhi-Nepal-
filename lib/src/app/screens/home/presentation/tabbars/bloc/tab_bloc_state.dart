part of 'tab_bloc_bloc.dart';

@immutable
abstract class TabBlocState {}

class TabBlocInitial extends TabBlocState {}

class GetTabInitialState extends TabBlocState {}

class GetTabLengthState extends TabBlocState {}
