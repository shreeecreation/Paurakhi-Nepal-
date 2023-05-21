part of 'blog_bloc.dart';

@immutable
abstract class BlogEvent {}

class FetchBlogEvent extends BlogEvent {}

class SearchBlogEvent extends BlogEvent {}

class SearchedBlogEvent extends BlogEvent {}
