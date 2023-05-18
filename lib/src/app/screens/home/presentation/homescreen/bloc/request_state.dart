part of 'request_bloc.dart';

@immutable
abstract class RequestState {}

class RequestInitial extends RequestState {}
class RequestStartState extends RequestState{}
class RequestEndState extends RequestState{}