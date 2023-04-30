import 'package:flutter/material.dart';
import 'package:paurakhi/src/core/themes/appstyles.dart';
import 'package:paurakhi/src/core/utils/searchwidget.dart';

class FinanceAction extends StatelessWidget {
  const FinanceAction({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(
            color: Colors.black, //change your color here
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          flexibleSpace: SizedBox(
              width: MediaQuery.of(context).size.width - 50, child: Align(alignment: Alignment.topLeft, child: searchWidgetSinglePage(context))),
        ),
        body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text("Farm Loan For Agriculture Nabil Bank", style: AppStyles.text30PxBold),
                    const SizedBox(height: 10),
                    Text(
                        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas id sit eu tellus sed cursus eleifend id porta. Lorem adipiscing mus vestibulum consequat porta eu ultrices feugiat. Et, faucibus ut amet turpis. Facilisis faucibus semper cras purus.\n \n Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas id sit eu tellus sed cursus eleifend id porta. \n \n Fermentum et eget libero lectus. Amet, tellus aliquam, dignissim enim placerat purus nunc, ac ipsum. Ac pretium.Fermentum et eget libero lectus. Amet, tellus aliquam, dignissim enim placerat purus nunc, ac ipsum. Ac pretium.",
                        style: AppStyles.text14Px),
                    const SizedBox(height: 20),
                    Center(
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                        ),
                        child: DataTable(
                          columns: const [
                            DataColumn(label: Text('Name')),
                            DataColumn(label: Text('Age')),
                            DataColumn(label: Text('Email')),
                          ],
                          rows: const [
                            DataRow(cells: [
                              DataCell(Text('John')),
                              DataCell(Text('35')),
                              DataCell(Text('john@example.com')),
                            ]),
                            DataRow(cells: [
                              DataCell(Text('Mary')),
                              DataCell(Text('42')),
                              DataCell(Text('mary@example.com')),
                            ]),
                            DataRow(cells: [
                              DataCell(Text('Tom')),
                              DataCell(Text('28')),
                              DataCell(Text('tom@example.com')),
                            ]),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: SizedBox(
                          height: 50,
                          width: MediaQuery.of(context).size.width - 50,
                          child: ElevatedButton(
                              onPressed: () {
                                // addProduct(context);
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF34A853),
                                  shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15)))),
                              child: Text("Enquire Now", style: AppStyles.text16PxSemiBold))),
                    )
                  ])),
            )));
  }
}
