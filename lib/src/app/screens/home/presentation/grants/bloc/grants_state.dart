part of 'grants_bloc.dart';

@immutable
abstract class GrantsState {}

class GrantsInitial extends GrantsState {}
class FetchGrantsState extends GrantsState{}


class SearchGrantsState extends GrantsState{}


class SearchedGrantsState extends GrantsState{}