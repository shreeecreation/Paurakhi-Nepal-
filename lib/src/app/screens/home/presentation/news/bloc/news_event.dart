part of 'news_bloc.dart';

@immutable
abstract class NewsEvent {}

class FetchNewsEvent extends NewsEvent {}

class SearchNewsEvent extends NewsEvent {}

class SearchedNewsEvent extends NewsEvent {}
