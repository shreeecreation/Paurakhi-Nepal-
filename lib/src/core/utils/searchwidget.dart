//TODO search functionality
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paurakhi/src/app/screens/home/presentation/tabbars/bloc/tab_bloc_bloc.dart';
import 'package:paurakhi/src/app/screens/search/domain/search_value.dart';
import 'package:paurakhi/src/core/API/Search/search_api.dart';
import '../../app/screens/search/bloc/search_bloc.dart';

Widget searchWidget(BuildContext context, key) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      GestureDetector(
        onTap: () {
          BlocProvider.of<SearchBloc>(context).add(SearchStartEvent());
        },
        child: SizedBox(
          width: MediaQuery.of(context).size.width - 20,
          child: TextFormField(
              readOnly: true,
              onTap: () {
                // unFocusNode(context);

                BlocProvider.of<SearchBloc>(context).add(SearchStartEvent());
              },
              decoration: InputDecoration(
                  border: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.circular(9.0)),
                  hintText: 'Search...',
                  filled: true,
                  fillColor: const Color(0xFFF4F4F4),
                  contentPadding: const EdgeInsets.all(8.0),
                  suffixIcon: IconButton(
                      onPressed: () {
                        // unFocusNode(context);
                        key.currentState!.openEndDrawer();
                      },
                      icon: const Icon(Icons.menu)),
                  prefixIcon: IconButton(icon: const Icon(Icons.search), onPressed: () {}))),
        ),
      ),
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
                SearchValue.searchValue = value;
                await SearchAPI.getSearchedProduct(SearchValue.category, value, SearchValue.type);
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  BlocProvider.of<SearchBloc>(context).add(SearchStartEvent());
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
                        SearchValue.searchValue = "";

                        BlocProvider.of<TabBlocBloc>(context).add(TabInitialEvent());
                        BlocProvider.of<SearchBloc>(context).add(SearchInitialEvent());
                      }))),
        ),
      ),
    ],
  );
}
