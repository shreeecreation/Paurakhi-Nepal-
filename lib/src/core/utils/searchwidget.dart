//TODO search functionality
import 'package:flutter/material.dart';

Widget searchWidget(BuildContext context,scaffoldkey) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      SizedBox(
        width: MediaQuery.of(context).size.width - 20,
        child: TextField(
            decoration: InputDecoration(
                border: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.circular(9.0)),
                hintText: 'Search...',
                filled: true,
                fillColor: const Color(0xFFF4F4F4),
                contentPadding: const EdgeInsets.all(8.0),
                suffixIcon: IconButton(
                    onPressed: () {
                
              scaffoldkey.currentState.openEndDrawer();

                    },
                    icon: const Icon(Icons.menu)),
                prefixIcon: const Icon(Icons.search))),
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
