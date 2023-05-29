part of 'finance_bloc.dart';

@immutable
abstract class FinanceState {}

class FinanceInitial extends FinanceState {}
class FetchFinanceState extends FinanceState{}


class SearchFinanceState extends FinanceState{}


class SearchedFinanceState extends FinanceState{}