import 'package:flutter/material.dart';
import 'package:paurakhi/main.dart';
import 'package:paurakhi/src/app/screens/home/presentation/tabbars/tab_bar.dart';
import 'package:paurakhi/src/core/extensions/colors_extension.dart';
import 'package:paurakhi/src/core/themes/appstyles.dart';
import 'package:paurakhi/src/core/utils/enddrawer.dart';
import 'package:paurakhi/src/core/utils/searchwidget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String userName = "कुशल काफ्ले";
    Map<String, String> myMap = {'Listings': '7120+', 'Users': '7120+', 'Grant Proceded': '7120+', 'Loan Passed': '7120+'};
    return Scaffold(
        endDrawerEnableOpenDragGesture: true, // This!
        key: scaffoldKey,
        endDrawer: const EndDrawer(),
        body: SingleChildScrollView(
          child: SizedBox(
              child: Column(children: [
            // ---------------------------------------------------------------------Search Widget
            searchWidget(
              context,scaffoldKey
            ),
            const SizedBox(height: 24),

            // ----------------------------------------------------------------------User widget
            userWidget(context, userName, scaffoldKey),

            // ----------------------------------------------------------------------GridView Widget
            gridViewWidget(context, myMap),

            SizedBox(width: MediaQuery.of(context).size.width / 1.3, child: const Divider(thickness: 2, color: Color(0xFFE0E0E0))),

            const Tabbar(),
          ])),
        ));
  }

// TODO GirdView Widget
  Widget gridViewWidget(BuildContext context, Map<String, String> myMap) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SizedBox(
          height: 200,
          child: Center(
            child: Row(
              children: [
                const SizedBox(width: 10),
                Container(
                    height: 180,
                    width: MediaQuery.of(context).size.width / 1.8,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: const Color(0xFF34A853))),
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
                        const SizedBox(width: 10),
                        GridView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: myMap.length,
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
                                          child: Text(myMap.entries.elementAt(index).key, style: AppStyles.text14Px.white),
                                        ),
                                        Center(
                                          child: Text(myMap.entries.elementAt(index).value, style: AppStyles.text14PxBold.white),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2, mainAxisSpacing: 4.0, crossAxisSpacing: 1.0, childAspectRatio: 0.6)),
                        const SizedBox(width: 10),
                      ],
                    )),
              ],
            ),
          )),
    );
  }

//TODO User Widget manage
  Widget userWidget(BuildContext context, String userName, scaffoldkey) {
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
          const SizedBox(width: 20),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)), backgroundColor: const Color(0xFF34A853), elevation: 0),
              onPressed: () {},
              child: const Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [Text("Sell"), Icon(Icons.arrow_drop_down)]))
        ]));
  }
}
