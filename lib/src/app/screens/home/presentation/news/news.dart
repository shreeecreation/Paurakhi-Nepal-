import 'package:flutter/material.dart';
import 'package:paurakhi/src/core/themes/appstyles.dart';
import 'package:paurakhi/src/core/utils/enddrawer.dart';
import 'package:paurakhi/src/core/utils/searchwidget.dart';

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

class NewsScreen extends StatelessWidget {
  const NewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        endDrawerEnableOpenDragGesture: true, // This!
        key: _scaffoldKey,
        endDrawer: const EndDrawer(),
        body: SingleChildScrollView(
            child: SizedBox(
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          // ---------------------------------------------------------------------Search Widget
          searchWidget(context, _scaffoldKey),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.only(left: 12.0),
            child: Text("Latest News ", style: AppStyles.text22PxBold),
          ),
          gridViewWidget(context),
          const SizedBox(height: 10),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.0),
            child: Divider(thickness: 1, color: Colors.grey),
          ),
          const SizedBox(height: 20),

          allNews(context),
          allNews(context),
          allNews(context),
          allNews(context),
        ]))));
  }

  Widget gridViewWidget(
    BuildContext context,
  ) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SizedBox(
          height: 200,
          child: Center(
            child: Row(
              children: [
                const SizedBox(width: 16),
                SizedBox(
                    height: 170,
                    child: Row(
                      children: [
                        const SizedBox(width: 10),
                        GridView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: 5,
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                child: recentCard(),
                              );
                            },
                            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent: 200, childAspectRatio: 0.85, crossAxisSpacing: 20, mainAxisSpacing: 20)),
                        const SizedBox(width: 10),
                      ],
                    )),
              ],
            ),
          )),
    );
  }

  Column recentCard() {
    return Column(
      children: [
        Stack(children: [
          Container(
              height: 120,
              width: 200,
              decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(17),
                  image: const DecorationImage(image: AssetImage("assets/images/nepalflag.png")))),
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(137, 255, 255, 255),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Center(child: Text("Grant")),
                    )),
                const SizedBox(width: 5),
                Container(
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(137, 255, 255, 255),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Center(child: Text("International")),
                    )),
              ],
            ),
          ),
        ]),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(width: 200, child: Text("Farmer Focus: 4 tips for caring for seasonal staff", style: AppStyles.text16PxBold)),
          ],
        )
      ],
    );
  }

  Widget allNews(context) {
    return Stack(children: [
      Container(
          height: 150,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(12.0)),
          child: const Card(elevation: 0.2, color: Color(0xFFF4FBF3))),
      Column(
        children: [
          const SizedBox(height: 20),
          GestureDetector(
            onTap: () {},
            child: Row(
              children: [
                const SizedBox(width: 15),
                Container(
                  height: 120,
                  width: 126,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      image: const DecorationImage(image: AssetImage("assets/images/nepalflag.png"), fit: BoxFit.cover)),
                  child: ClipRRect(borderRadius: BorderRadius.circular(10.0), child: Align(alignment: Alignment.bottomRight, child: Container())),
                ),
                const SizedBox(width: 5),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        //TODO get tag

                        Container(
                            decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(6)), color: Color(0xFFD9D9D9)),
                            height: 40,
                            width: 70,
                            child: const Center(child: Text("Product"))),
                        const SizedBox(width: 10),

                        //TODO get tag
                        Container(
                            decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(6)), color: Color(0xFFD9D9D9)),
                            height: 40,
                            width: 70,
                            child: const Center(child: Text("Fertilizer"))),
                      ],
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                        width: MediaQuery.of(context).size.width / 2,
                        child: Text("Rs. Urea Fertilizer | High Quality | 100KG Package", style: AppStyles.text18PxBold)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ]);
  }
}
