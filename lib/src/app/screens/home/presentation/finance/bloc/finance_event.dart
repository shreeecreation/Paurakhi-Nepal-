part of 'finance_bloc.dart';

@immutable
abstract class FinanceEvent {}

class FetchFinanceEvent extends FinanceEvent {}

class SearchFinanceEvent extends FinanceEvent {}

class SearchedFinanceEvent extends FinanceEvent {}
