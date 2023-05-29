part of 'blog_bloc.dart';

@immutable
abstract class BlogState {}

class BlogInitial extends BlogState {}
class FetchBlogState extends BlogState{}


class SearchBlogState extends BlogState{}


class SearchedBlogState extends BlogState{}