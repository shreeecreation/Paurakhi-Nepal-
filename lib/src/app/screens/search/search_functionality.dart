import 'package:flutter/material.dart';
import 'package:paurakhi/main.dart';
import 'package:paurakhi/src/app/screens/search/search_dialog.dart';
import 'package:paurakhi/src/core/utils/searchwidget.dart';

class SearchFunctionality extends StatelessWidget {
  const SearchFunctionality({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
          child: Column(children: [
        // ---------------------------------------------------------------------Search Widget
        searchFilterWidget(context, scaffoldKey),
        const SizedBox(height: 10),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                  onPressed: () {
                    showOptionsDialog(context);
                  },
                  style: ElevatedButton.styleFrom(elevation: 0, backgroundColor: Colors.green),
                  child: const Row(
                    children: [Text("Filter"), Icon(Icons.arrow_drop_down_rounded)],
                  )),

              const SizedBox(width: 20),

              
            ],
          ),
        ),
      ])),
    );
  }
}
