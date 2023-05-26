import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paurakhi/main.dart';
import 'package:paurakhi/src/app/screens/home/presentation/profile/model/profile_model.dart';
import 'package:paurakhi/src/app/screens/home/presentation/tabbars/tab_bar.dart';
import 'package:paurakhi/src/app/screens/search/bloc/search_bloc.dart';
import 'package:paurakhi/src/app/screens/search/search_functionality.dart';
import 'package:paurakhi/src/core/API/ListingGreetingsAPI/listings_greetings_api.dart';
import 'package:paurakhi/src/core/extensions/colors_extension.dart';
import 'package:paurakhi/src/core/themes/appcolors.dart';
import 'package:paurakhi/src/core/themes/appstyles.dart';
import 'package:paurakhi/src/core/utils/enddrawer.dart';
import 'package:paurakhi/src/core/utils/searchwidget.dart';

import 'bloc/request_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String userName = Profile.firstName ?? "";

    return Scaffold(
        endDrawerEnableOpenDragGesture: true, // This!
        key: scaffoldKey,
        endDrawer: const EndDrawer(),
        body: BlocBuilder<SearchBloc, SearchState>(
          builder: (context, state) {
            if (state is SearchInitialState) {
              return RefreshIndicator(
                onRefresh: () {
                  print("dasda");
                  BlocProvider.of<SearchBloc>(context).add(ResetStartEvent());

                  return Future.delayed(const Duration(seconds: 1));
                },
                child: mainWidget(context, userName),
              );
            }
            if (state is ResetStartState) {
              return RefreshIndicator(
                  onRefresh: () {
                    BlocProvider.of<SearchBloc>(context).add(SearchInitialEvent());

                    return Future.delayed(const Duration(seconds: 1));
                  },
                  child: mainWidget(context, userName));
            }
            if (state is SearchStartState) {
              return const SearchFunctionality();
            }
            return const Center(child: LinearProgressIndicator(color: AppColors.primary));
          },
        ));
  }

  Widget mainWidget(BuildContext context, String userName) {
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      child: SizedBox(
          child: Column(children: [
        // ---------------------------------------------------------------------Search Widget
        searchWidget(context, scaffoldKey),
        const SizedBox(height: 24),

        // ----------------------------------------------------------------------User widget
        userWidget(context, userName, scaffoldKey),

        // ----------------------------------------------------------------------GridView Widget
        gridViewWidget(context),

        SizedBox(width: MediaQuery.of(context).size.width / 1.3, child: const Divider(thickness: 2, color: Color(0xFFE0E0E0))),

        const Tabbar(),
      ])),
    );
  }

// TODO GirdView Widget
  Widget gridViewWidget(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SizedBox(
          height: 200,
          child: Center(
            child: FutureBuilder(
                future: ListingsGreetingsAPI.listingsAndGreetings(),
                builder: (BuildContext context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
                  if (snapshot.hasData) {
                    Map<String, dynamic>? data = snapshot.data != null ? snapshot.data!['data'] : null;
                    Map<String, dynamic>? listing = data?['listing'] as Map<String, dynamic>?;
                    Map<String, dynamic>? notification = data?['notification'] as Map<String, dynamic>?;

                    if (listing != null && notification != null) {
                      String user = listing['user']?.toString() ?? 'N/A';
                      String listingValue = listing['listing']?.toString() ?? 'N/A';
                      String grantsProcessed = listing['grants_processed']?.toString() ?? 'N/A';
                      String loanPassed = listing['loan_passed']?.toString() ?? 'N/A';
                      String notificationTitle = notification['notification_tittle']?.toString() ?? 'N/A';
                      String notificationBody = notification['notification_body']?.toString() ?? 'N/A';
                      String notificationSubTitle = notification['notification_sub_tittle']?.toString() ?? 'N/A';

                      Map<String, String> listingsMap = {
                        "Users": user,
                        "Value": listingValue,
                        "Grants": grantsProcessed,
                        "Loan Passed": loanPassed,
                      };

                      return Row(
                        children: [
                          const SizedBox(width: 10),
                          Container(
                              height: 180,
                              width: MediaQuery.of(context).size.width / 1.5,
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: const Color(0xFF34A853)),
                              child: Padding(
                                padding: const EdgeInsets.all(18.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(notificationTitle, style: AppStyles.text24PxBold.white),
                                    const SizedBox(height: 1),
                                    Text(notificationSubTitle, style: AppStyles.text18PxSemiBold.white),
                                    const SizedBox(height: 5),
                                    Text(notificationBody, style: AppStyles.text14Px.white),
                                  ],
                                ),
                              )),
                          const SizedBox(width: 16),
                          Container(
                              height: 170,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                  boxShadow: [
                                    BoxShadow(color: Colors.grey.withOpacity(0.5), spreadRadius: 4, blurRadius: 6, offset: const Offset(0, 2)),
                                  ],
                                  color: const Color.fromARGB(255, 225, 228, 224)),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: GridView.builder(
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      itemCount: listingsMap.length,
                                      itemBuilder: (BuildContext context, int index) {
                                        return GestureDetector(
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 2),
                                            child: Container(
                                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: const Color(0xFF34A853)),
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Center(
                                                    child: Text(listingsMap.entries.elementAt(index).key, style: AppStyles.text14Px.white),
                                                  ),
                                                  Center(
                                                    child:
                                                        Text("${listingsMap.entries.elementAt(index).value} +", style: AppStyles.text14PxBold.white),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2, mainAxisSpacing: 4.0, crossAxisSpacing: 1.0, childAspectRatio: 0.6),
                                    ),
                                  ),
                                ],
                              )),
                          const SizedBox(width: 10),
                        ],
                      );
                    }
                  }
                  return const CircularProgressIndicator(
                    color: Colors.green,
                  );
                }),
          )),
    );
  }

//TODO User Widget manage
  Widget userWidget(BuildContext context, String userName, scaffoldkey) {
    final List<String> genderItems = [
      'Sell',
      'Request',
    ];
    final formKey = GlobalKey<FormState>();

    return Form(
      key: formKey,
      child: SizedBox(
          height: 50,
          width: MediaQuery.of(context).size.width,
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            Row(
              children: [
                const SizedBox(width: 11),
                Text("Greetings $userName", style: AppStyles.text24PxBold),
                Image.asset("assets/images/nepalflag.png", scale: 5)
              ],
            ),
            const SizedBox(width: 5),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.green,
              ),
              height: 42,
              width: 110,
              child: DropdownButtonFormField2(
                value: "Sell",
                decoration: InputDecoration(
                  isDense: true,
                  fillColor: Colors.green,
                  contentPadding: EdgeInsets.zero,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
                ),
                isExpanded: true,
                style: AppStyles.text14PxMedium.white,
                items: genderItems
                    .map((item) => DropdownMenuItem<String>(
                          value: item,
                          child: Text(
                            item,
                            style: AppStyles.text12PxBold.white,
                          ),
                        ))
                    .toList(),
                validator: (value) {
                  if (value == null) {
                    return 'Select';
                  }
                  return null;
                },
                onChanged: (value) {
                  if (value == "Sell") {
                    BlocProvider.of<RequestBloc>(context).add(RequestStartEvent());
                  } else {
                    BlocProvider.of<RequestBloc>(context).add(RequestInitialEvent());
                  }
                },
                onSaved: (value) {},
                buttonStyleData: const ButtonStyleData(
                  height: 60,
                  width: 40,
                  padding: EdgeInsets.only(left: 20, right: 10),
                ),
                iconStyleData: const IconStyleData(
                  icon: Icon(Icons.arrow_drop_down, color: Colors.white),
                  iconSize: 30,
                ),
                dropdownStyleData: DropdownStyleData(
                  decoration: BoxDecoration(
                    color: AppColors.textGreen,
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
            ),
          ])),
    );
  }
}
