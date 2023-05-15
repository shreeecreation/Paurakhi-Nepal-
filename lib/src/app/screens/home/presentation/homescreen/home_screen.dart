import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paurakhi/main.dart';
import 'package:paurakhi/src/app/screens/home/presentation/tabbars/tab_bar.dart';
import 'package:paurakhi/src/app/screens/search/bloc/search_bloc.dart';
import 'package:paurakhi/src/app/screens/search/search_functionality.dart';
import 'package:paurakhi/src/core/API/ListingGreetingsAPI/listings_greetings_api.dart';
import 'package:paurakhi/src/core/extensions/colors_extension.dart';
import 'package:paurakhi/src/core/themes/appcolors.dart';
import 'package:paurakhi/src/core/themes/appstyles.dart';
import 'package:paurakhi/src/core/utils/enddrawer.dart';
import 'package:paurakhi/src/core/utils/searchwidget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String userName = "कुशल काफ्ले";

    return Scaffold(
        endDrawerEnableOpenDragGesture: true, // This!
        key: scaffoldKey,
        endDrawer: const EndDrawer(),
        body: BlocBuilder<SearchBloc, SearchState>(
          builder: (context, state) {
            if (state is SearchInitialState) {
              return SingleChildScrollView(
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

            if (state is SearchStartState) {
              return const SearchFunctionality();
            }
            return const Center(child: LinearProgressIndicator(color: AppColors.primary));
          },
        ));
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
                    Map<String, dynamic> data = snapshot.data!['data'];
                    Map<String, dynamic> listing = data ['listing'];

                    String user = listing['user'].toString();
                    String listingValue = listing['listing'].toString();
                    String grantsProcessed = listing['grants_processed'].toString();
                    String loanPassed = listing['loan_passed'].toString();

                    Map<String, String> listingsMap = {
                      "Users": user,
                      "Value": listingValue,
                      "Grant Proceeded": grantsProcessed,
                      "loanPassed": loanPassed
                    };

                    return Row(
                      children: [
                        const SizedBox(width: 10),
                        Container(
                            height: 180,
                            width: MediaQuery.of(context).size.width / 1.8,
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: const Color(0xFF34A853)),
                            child: Text(data['notification_tittle'].toString())),
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
                                GridView.builder(
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
                                                child: Text(listingsMap.entries.elementAt(index).value, style: AppStyles.text14PxBold.white),
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
                                const SizedBox(width: 10),
                                const SizedBox(width: 10),
                              ],
                            )),
                      ],
                    );
                  }
                  return const CircularProgressIndicator();
                }),
          )),
    );
  }

//TODO User Widget manage
  Widget userWidget(BuildContext context, String userName, scaffoldkey) {
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(value: "Sell", child: Text("Sell", style: AppStyles.text16PxBold)),
      DropdownMenuItem(value: "Request", child: Text("Request", style: AppStyles.text16PxBold)),
    ];
    String? selectedValue = "Sell";
    return SizedBox(
        height: 50,
        width: MediaQuery.of(context).size.width,
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          Row(
            children: [
              const SizedBox(width: 11),
              Text("नमस्कार $userName", style: AppStyles.text24PxBold),
              Image.asset("assets/images/nepalflag.png", scale: 5)
            ],
          ),
          const SizedBox(width: 5),
          Center(
            child: SizedBox(
              height: 50,
              width: 115,
              child: DropdownButtonFormField(
                  itemHeight: 50,
                  style: AppStyles.text14PxSemiBold,
                  decoration: InputDecoration(
                    border: UnderlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    filled: true,
                    fillColor: Colors.green,
                  ),
                  iconEnabledColor: Colors.white,
                  validator: (value) => value == null ? "Sell" : null,
                  dropdownColor: const Color.fromARGB(255, 57, 115, 48),
                  value: selectedValue,
                  onChanged: (String? newValue) {
                    selectedValue = newValue!;
                  },
                  items: menuItems),
            ),
          ),
        ]));
  }
}
