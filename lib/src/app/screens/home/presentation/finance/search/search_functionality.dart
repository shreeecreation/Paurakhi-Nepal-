import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paurakhi/main.dart';
import 'package:paurakhi/src/app/screens/home/presentation/finance/search/search_value.dart';
import 'package:paurakhi/src/app/screens/home/presentation/finance/bloc/finance_bloc.dart';
import 'package:paurakhi/src/core/themes/appstyles.dart';
import 'package:paurakhi/src/core/utils/search_finance.dart';

import 'finance_result.dart';

class SearchFunctionalityFinance extends StatelessWidget {
  const SearchFunctionalityFinance({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        child: Column(children: [
      // --------------------------------------------------------------------- Search Widget
      searchFilterWidgetFinance(context, scaffoldKey),
      const SizedBox(height: 10),

      BlocBuilder<FinanceBloc, FinanceState>(
        builder: (context, state) {
          if (state is SearchedFinanceState) {
            return FinanceSearchResult(title: SearchValueFinance.searchValue);
          }
          // return const Text("\nNo results found ");
          return SizedBox(
            height: 300,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.info,
                    size: 100, color: Color.fromARGB(87, 76, 175, 79)),
                const SizedBox(height: 10),
                Text(
                  "No Finance found !",
                  style: AppStyles.text20PxSemiBold,
                ),
              ],
            ),
          );
        },
      )
    ]));
  }
}
