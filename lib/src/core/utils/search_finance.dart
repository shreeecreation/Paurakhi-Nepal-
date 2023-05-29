//TODO search functionality
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paurakhi/src/app/screens/home/presentation/finance/bloc/finance_bloc.dart';
import 'package:paurakhi/src/app/screens/home/presentation/finance/search/search_value.dart';
import 'package:paurakhi/src/core/API/Search/search_api.dart';
import 'focuesnode.dart';

Widget searchFinance(BuildContext context, key) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      GestureDetector(
        onTap: () {
          BlocProvider.of<FinanceBloc>(context).add(SearchFinanceEvent());
        },
        child: SizedBox(
          width: MediaQuery.of(context).size.width - 20,
          child: TextFormField(
              onTap: () {
                // unFocusNode(context);

                BlocProvider.of<FinanceBloc>(context).add(SearchFinanceEvent());
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

Widget searchFilterWidgetFinance(BuildContext context, key) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      SizedBox(
        width: MediaQuery.of(context).size.width - 20,
        child: GestureDetector(
          onTap: () {},
          child: TextFormField(
              onFieldSubmitted: (value) async {
                SearchValueFinance.searchValue = value;
                await SearchAPI.getSearchedFinance(value);

                WidgetsBinding.instance.addPostFrameCallback((_) {
                  BlocProvider.of<FinanceBloc>(context).add(SearchedFinanceEvent());
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
                        BlocProvider.of<FinanceBloc>(context).add(FetchFinanceEvent());
                      }))),
        ),
      ),
    ],
  );
}
