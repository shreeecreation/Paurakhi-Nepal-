import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paurakhi/main.dart';
import 'package:paurakhi/src/app/screens/home/presentation/news/bloc/news_bloc.dart';
import 'package:paurakhi/src/app/screens/home/presentation/news/search/search_value.dart';
import 'package:paurakhi/src/core/themes/appstyles.dart';

import '../../../../../../core/utils/search_news.dart';
import 'news_result.dart';

class SearchFunctionalityNews extends StatelessWidget {
  const SearchFunctionalityNews({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
          child: Column(children: [
        // --------------------------------------------------------------------- Search Widget
        searchFilterWidget(context, scaffoldKey),
        const SizedBox(height: 10),

        BlocBuilder<NewsBloc, NewsState>(
          builder: (context, state) {
            if (state is SearchedNewsState) {
              return NewsSearchResult(title: SearchValueNews.searchValue);
            }
            return SizedBox(
              height: 300,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.info,
                      size: 100, color: Color.fromARGB(87, 76, 175, 79)),
                  const SizedBox(height: 10),
                  Text(
                    "No News found !",
                    style: AppStyles.text20PxSemiBold,
                  ),
                ],
              ),
            );
          },
        )
      ])),
    );
  }
}
