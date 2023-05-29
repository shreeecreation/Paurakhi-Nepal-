import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'blog_event.dart';
part 'blog_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  BlogBloc() : super(BlogInitial()) {
    on<BlogEvent>((event, emit) {
      emit(BlogInitial());

      // TODO: implement event handler
    });
    on<FetchBlogEvent>((event, emit) {
      emit(FetchBlogState());
    });

    on<SearchBlogEvent>((event, emit) {
      emit(SearchBlogState());
    });

    on<SearchedBlogEvent>((event, emit) {
      emit(SearchedBlogState());
    });
  }
}
