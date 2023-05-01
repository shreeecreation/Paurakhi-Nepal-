import 'package:flutter/material.dart';

class Tabbar extends StatefulWidget {
  const Tabbar({super.key});

  @override
  State<Tabbar> createState() => _TabbarState();
}

class _TabbarState extends State<Tabbar> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 6,
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: const TabBar(tabs: [
                  Text("All"),
                  Text("Product"),
                  Text("Grants"),
                  Text("Tools"),
                  Text("Finance"),
                  Text("Tools"),
                ]),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: const TabBarView(children: [
                  Icon(Icons.key),
                  Icon(Icons.key),
                  Icon(Icons.key),
                  Icon(Icons.key),
                  Icon(Icons.key),
                  Icon(Icons.key),
                ]),
              ),
            ],
          ),
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