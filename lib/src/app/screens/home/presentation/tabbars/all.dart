import 'package:flutter/material.dart';
import 'package:paurakhi/src/core/utils/evey_product_widget.dart';

class All extends StatelessWidget {
  const All({super.key});
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          everyProductWidget(context),
          everyProductWidget(context),
          everyProductWidget(context),
        ],
      ),
    );
  }
}
