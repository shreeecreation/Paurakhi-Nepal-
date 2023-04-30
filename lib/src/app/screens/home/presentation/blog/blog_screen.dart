import 'package:flutter/material.dart';
import 'package:paurakhi/src/core/utils/enddrawer.dart';
import 'package:paurakhi/src/core/utils/searchwidget.dart';

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

class BlogScreen extends StatelessWidget {
  const BlogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        endDrawerEnableOpenDragGesture: true, // This!
        key: _scaffoldKey,
        endDrawer: const EndDrawer(),
        body: SingleChildScrollView(
            child: SizedBox(
                child: Column(children: [
          // ---------------------------------------------------------------------Search Widget
          searchWidget(context,_scaffoldKey),
          const SizedBox(height: 24),
        ]))));
  }
}
