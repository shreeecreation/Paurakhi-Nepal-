import 'package:flutter/material.dart';

import 'all.dart';

class Tabbar extends StatefulWidget {
  const Tabbar({super.key});

  @override
  State<Tabbar> createState() => _TabbarState();
}

class _TabbarState extends State<Tabbar> with SingleTickerProviderStateMixin {
  TabController? _tabController;
  @override
  void initState() {
    _tabController = TabController(length: 5, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              child: TabBar(
                isScrollable: true,
                labelPadding: const EdgeInsets.symmetric(horizontal: 20),
                unselectedLabelColor: Colors.black,
                labelColor: Colors.white,
                splashBorderRadius: BorderRadius.circular(20),
                indicator: ShapeDecoration(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)), color: Colors.green),
                tabs: const [
                  Tab(
                    child: Text("All"),
                  ),
                  Tab(
                    child: Text("Grants"),
                  ),
                  Tab(
                    child: Text("Products"),
                  ),
                  Tab(
                    child: Text("Finance"),
                  ),
                  Tab(
                    child: Text("Tools"),
                  ),
                ],
                controller: _tabController,
                indicatorSize: TabBarIndicatorSize.tab,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 2,
              child: TabBarView(
                controller: _tabController,
                children: const [
                  All(),
                  All(),
                  All(),
                  All(),
                  All(),
                ],
              ),
            ),
          ],
        ));
  }
}


      //  SizedBox(
      //       height: 40,
      //       width: 85,
      //       child: Padding(
      //           padding: const EdgeInsets.only(top: 2.0, left: 2.0, right: 2.0),
      //           child: ElevatedButton(
      //               onPressed: null,
      //               style: ElevatedButton.styleFrom(
      //                   disabledBackgroundColor: Colors.transparent,
      //                   elevation: 0,
      //                   shape: RoundedRectangleBorder(
      //                       borderRadius: BorderRadius.circular(7), side: const BorderSide(color: Color(0xFFBDBDBD), width: 1.5)),
      //                   backgroundColor: Colors.white),
      //               child: const Text('Finance'))),
      //     ),