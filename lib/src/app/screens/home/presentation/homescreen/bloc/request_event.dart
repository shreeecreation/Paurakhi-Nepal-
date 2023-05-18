part of 'request_bloc.dart';

@immutable
abstract class RequestEvent {}
class RequestStartEvent extends RequestEvent{}
class RequestInitialEvent extends RequestEvent{}