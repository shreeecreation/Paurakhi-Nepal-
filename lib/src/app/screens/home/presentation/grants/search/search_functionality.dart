import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paurakhi/main.dart';
import 'package:paurakhi/src/app/screens/home/presentation/grants/bloc/grants_bloc.dart';
import 'package:paurakhi/src/app/screens/home/presentation/grants/search/search_value.dart';
import 'package:paurakhi/src/core/themes/appstyles.dart';
import 'package:paurakhi/src/core/utils/search_grants.dart';

// import '../../../../../../core/utils/search_Grants.dart';
import 'grants_result.dart';

class SearchFunctionalityGrants extends StatelessWidget {
  const SearchFunctionalityGrants({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        child: Column(children: [
      // --------------------------------------------------------------------- Search Widget
      searchFilterWidget(context, scaffoldKey),
      const SizedBox(height: 10),

      BlocBuilder<GrantsBloc, GrantsState>(
        builder: (context, state) {
          if (state is SearchedGrantsState) {
            return GrantsSearchResult(title: SearchValueGrants.searchValue);
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
                    "No Grants found !",
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
