part of 'news_bloc.dart';

@immutable
abstract class NewsState {}

class NewsInitial extends NewsState {}
class FetchNewsState extends NewsState{}


class SearchNewsState extends NewsState{}


class SearchedNewsState extends NewsState{}