import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paurakhi/main.dart';
import 'package:paurakhi/src/app/screens/home/presentation/news/bloc/news_bloc.dart';
import 'package:paurakhi/src/app/screens/home/presentation/news/search/search_value.dart';

import '../../../../../../core/utils/search_news.dart';
import 'news_result.dart';

class SearchFunctionalityNews extends StatelessWidget {
  const SearchFunctionalityNews({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        child: Column(children: [
      // --------------------------------------------------------------------- Search Widget
      searchFilterWidget(context, scaffoldKey),
      const SizedBox(height: 10),

      BlocBuilder<NewsBloc, NewsState>(
        builder: (context, state) {
          if (state is SearchedNewsState) {
            return NewsSearchResult(title: SearchValueNews.searchValue);
          }
          return const Text("\nNo results found ");
        },
      )
    ]));
  }
}
