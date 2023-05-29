part of 'getprdouct_bloc.dart';

@immutable
abstract class GetprdouctEvent {}

class GetProdcutInitialEvent extends GetprdouctEvent {}

class GetProdcutFetchEvent extends GetprdouctEvent {}
