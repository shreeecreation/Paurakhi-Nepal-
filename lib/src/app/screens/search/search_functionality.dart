import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paurakhi/main.dart';
import 'package:paurakhi/src/core/utils/searchwidget.dart';

import 'bloc/search_bloc.dart';
import 'domain/search_value.dart';
import 'search_widget.dart';

class SearchFunctionality extends StatelessWidget {
  const SearchFunctionality({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
          child: Column(children: [
        // --------------------------------------------------------------------- Search Widget
        searchFilterWidget(context, scaffoldKey),
        const SizedBox(height: 10),

        BlocBuilder<SearchBloc, SearchState>(
          builder: (context, state) {
            if (state is SearchStartState) {
              return SearchWidget(name: SearchValue.searchValue);
            }
            return const Text("dasdasdasd");
          },
        ),
        // SizedBox(
        //     height: 70,
        //     child: Center(
        //         child: SizedBox(
        //             child: Column(
        //       mainAxisAlignment: MainAxisAlignment.center,
        //       children: [
        //         Image.asset(
        //           "assets/images/search.png",
        //           height: 50,
        //           // width: MediaQuery.of(context).size.width / 2,
        //           fit: BoxFit.fill,
        //         ),
        //         Text("Search your desire product !", style: AppStyles.text14PxBold),
        //       ],
        //     )))),

        const SizedBox(height: 20)
      ])),
    );
  }
}
