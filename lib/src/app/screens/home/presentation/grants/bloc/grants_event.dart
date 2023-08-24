part of 'grants_bloc.dart';

@immutable
abstract class GrantsEvent {}

class FetchGrantsEvent extends GrantsEvent {}

class SearchGrantsEvent extends GrantsEvent {}

class SearchedGrantsEvent extends GrantsEvent {}
