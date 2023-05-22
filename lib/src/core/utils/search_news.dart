import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paurakhi/src/app/screens/home/presentation/News/bloc/news_bloc.dart';
import 'package:paurakhi/src/app/screens/home/presentation/News/search/search_value.dart';
import 'package:paurakhi/src/core/API/Search/search_api.dart';
import 'focuesnode.dart';

Widget searchNews(BuildContext context, key) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      GestureDetector(
        onTap: () {
          BlocProvider.of<NewsBloc>(context).add(SearchNewsEvent());
        },
        child: SizedBox(
            width: MediaQuery.of(context).size.width - 20,
            child: TextFormField(
                onTap: () {
                  // unFocusNode(context);
                  try {
                    BlocProvider.of<NewsBloc>(context).add(SearchNewsEvent());
                  } catch (e) {
                    print(e);
                  }
                },
                decoration: InputDecoration(
                    border: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.circular(9.0)),
                    hintText: 'Search...',
                    filled: true,
                    fillColor: const Color(0xFFF4F4F4),
                    contentPadding: const EdgeInsets.all(8.0),
                    suffixIcon: IconButton(
                        onPressed: () {
                          unFocusNode(context);
                          key.currentState!.openEndDrawer();
                        },
                        icon: const Icon(Icons.menu)),
                    prefixIcon: IconButton(icon: const Icon(Icons.search), onPressed: () {})))),
      )
    ],
  );
}

Widget searchWidgetSinglePage(BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      SizedBox(
        width: MediaQuery.of(context).size.width - 50,
        child: TextField(
            decoration: InputDecoration(
                border: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.circular(9.0)),
                hintText: 'Search...',
                filled: true,
                fillColor: const Color(0xFFF4F4F4),
                contentPadding: const EdgeInsets.all(8.0),
                suffixIcon: const Icon(Icons.menu),
                prefixIcon: const Icon(Icons.search))),
      ),
    ],
  );
}

Widget searchFilterWidget(BuildContext context, key) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      SizedBox(
        width: MediaQuery.of(context).size.width - 20,
        child: GestureDetector(
          onTap: () {},
          child: TextFormField(
              onFieldSubmitted: (value) async {
                SearchValueNews.searchValue = value;
                await SearchAPI.getSearchedNews(value);

                WidgetsBinding.instance.addPostFrameCallback((_) {
                  BlocProvider.of<NewsBloc>(context).add(SearchedNewsEvent());
                });
              },
              decoration: InputDecoration(
                  border: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.circular(9.0)),
                  hintText: 'Search...',
                  filled: true,
                  fillColor: const Color(0xFFF4F4F4),
                  contentPadding: const EdgeInsets.all(8.0),
                  prefixIcon: IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () {
                        BlocProvider.of<NewsBloc>(context).add(FetchNewsEvent());
                      }))),
        ),
      ),
    ],
  );
}
