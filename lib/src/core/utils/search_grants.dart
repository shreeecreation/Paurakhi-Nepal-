//TODO search functionality
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paurakhi/src/app/screens/home/presentation/grants/bloc/grants_bloc.dart';
import 'package:paurakhi/src/app/screens/home/presentation/grants/search/search_value.dart';
import 'package:paurakhi/src/core/utils/focuesnode.dart';

Widget searchGrants(BuildContext context, key) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      GestureDetector(
        onTap: () {
          // BlocProvider.of<GrantsBloc>(context).add(SearchGrantsEvent());
        },
        child: SizedBox(
          width: MediaQuery.of(context).size.width - 20,
          child: TextFormField(
              onTap: () async {
                // unFocusNode(context);
                // try {
                BlocProvider.of<GrantsBloc>(context).add(SearchGrantsEvent());
                // } catch (e) {
                //   print("Dasdasd");
                //   print(e);
                // }
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
                SearchValueGrants.searchValue = value;

                BlocProvider.of<GrantsBloc>(context).add(SearchedGrantsEvent());
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
                        BlocProvider.of<GrantsBloc>(context).add(FetchGrantsEvent());
                      }))),
        ),
      ),
    ],
  );
}
