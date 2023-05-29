import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'news_event.dart';
part 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  NewsBloc() : super(NewsInitial()) {
    on<NewsEvent>((event, emit) {
      emit(NewsInitial());

      // TODO: implement event handler
    });
    on<FetchNewsEvent>((event, emit) {
      emit(FetchNewsState());
    });

    on<SearchNewsEvent>((event, emit) {
      emit(SearchNewsState());
    });

    on<SearchedNewsEvent>((event, emit) {
      emit(SearchedNewsState());
    });
  }
}
