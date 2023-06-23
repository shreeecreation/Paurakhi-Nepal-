import 'dart:async';

import 'package:flutter/material.dart';
import 'package:paurakhi/src/core/API/GetProductAPI/get_product_api.dart';
import 'package:paurakhi/src/core/themes/appcolors.dart';
import 'package:paurakhi/src/core/themes/appstyles.dart';
import 'package:paurakhi/src/core/utils/evey_product_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'loadmore_controller.dart';
import 'productmodel.dart';

final GlobalKey<_AllState> key = GlobalKey<_AllState>();

class All extends StatefulWidget {
  final String category;
  final String type;

  const All({Key? key, required this.category, required this.type}) : super(key: key);

  @override
  _AllState createState() => _AllState();

  static List<ProductModel> items = [];
}

class _AllState extends State<All> {
  bool isLoading = false;
  bool isDisposed = false;
  bool showImage = true; // Flag to control the visibility of the image

  @override
  void dispose() {
    isDisposed = true;
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    All.items = [];
    _getProducts(clearItems: true);
    _startTimer(); // Start the timer when the state is initialized
  }

  @override
  void didUpdateWidget(All oldWidget) {
    if (widget.category != oldWidget.category) {
      _getProducts(clearItems: true);
    }
    super.didUpdateWidget(oldWidget);
  }

  Future<void> _getProducts({required bool clearItems}) async {
    setState(() {
      isLoading = true;
    });

    final ServerResponseProduct? response = await GetProductAPI.getProductCategory(
      widget.category,
      widget.type,
      LoadMoreController.currentPage,
    );

    if (!isDisposed) {
      setState(() {
        isLoading = false;
        if (response != null) {
          if (clearItems) {
            All.items = response.data;
          } else {
            All.items.addAll(response.data);
          }
        }
      });
    }
  }

  void _loadMore() {
    setState(() {
      LoadMoreController.currentPage++;
    });
    _getProducts(clearItems: false);
  }

  void _startTimer() {
    Timer(const Duration(milliseconds: 1500), () {
      setState(() {
        showImage = false; // Hide the image after 500 milliseconds
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const ClampingScrollPhysics(),
      child: Column(
        children: [
          if (showImage) // Show the image for 500 milliseconds
            Column(
              children: [
                const SizedBox(height: 40),
                SizedBox(height: 80, width: 80, child: Image.asset('assets/images/paurakhi.gif')),
              ],
            ), // Replace 'assets/loading_image.png' with your actual image path
          if (!showImage)
            ListView.builder(
              cacheExtent: 999999,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: All.items.length,
              itemBuilder: (BuildContext context, int index) {
                final ProductModel datum = All.items[index];
                return everyProductWidgetProduct(context, datum);
              },
            ),
          const SizedBox(height: 10),
          if (All.items.isEmpty && !showImage)
            Center(
              child: Column(
                children: [
                  const SizedBox(height: 40),
                  Text("No product found !", style: AppStyles.text18PxMedium),
                ],
              ),
            ),
          if (All.items.length > 9)
            SizedBox(
              height: 40,
              width: 120,
              child: ElevatedButton(
                onPressed: isLoading ? null : _loadMore,
                style: ElevatedButton.styleFrom(
                  backgroundColor: isLoading ? Colors.grey : AppColors.textGreen,
                ),
                child: Text(isLoading ? AppLocalizations.of(context)!.loading : AppLocalizations.of(context)!.load_more),
              ),
            ),
          const SizedBox(height: 100),
        ],
      ),
    );
  }
}

class All1 extends StatefulWidget {
  final String category;
  final String type;

  const All1({Key? key, required this.category, required this.type}) : super(key: key);

  @override
  _All1State createState() => _All1State();

  static List<ProductModel> items = [];
}

class _All1State extends State<All1> {
  bool isLoading = false;
  bool isDisposed = false;

  @override
  void dispose() {
    isDisposed = true;
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    All.items = [];
    _getProducts(clearItems: true);
  }

  @override
  void didUpdateWidget(All1 oldWidget) {
    if (widget.category != oldWidget.category) {
      _getProducts(clearItems: true);
    }
    super.didUpdateWidget(oldWidget);
  }

  Future<void> _getProducts({required bool clearItems}) async {
    setState(() {
      isLoading = true;
    });

    final ServerResponseProduct? response = await GetProductAPI.getProductCategory(
      widget.category,
      widget.type,
      LoadMoreController.currentPage,
    );

    if (!isDisposed) {
      setState(() {
        isLoading = false;
        if (response != null) {
          if (clearItems) {
            All.items = response.data;
          } else {
            All.items.addAll(response.data);
          }
        }
      });
    }
  }

  void _loadMore() {
    setState(() {
      LoadMoreController.currentPage++;
    });
    _getProducts(clearItems: false);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          ListView.builder(
            cacheExtent: 999999,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: All.items.length,
            itemBuilder: (BuildContext context, int index) {
              final ProductModel datum = All.items[index];
              return everyProductWidgetProduct(context, datum);
            },
          ),
          if (All.items.isEmpty)
            Center(
                child: Column(
              children: [
                const SizedBox(height: 40),
                Text("No product found !", style: AppStyles.text18PxMedium),
              ],
            )),
          if (All.items.length > 9) // Add this condition
            SizedBox(
              height: 40,
              width: 120,
              child: ElevatedButton(
                onPressed: isLoading ? null : _loadMore,
                style: ElevatedButton.styleFrom(
                  backgroundColor: isLoading ? Colors.grey : AppColors.textGreen,
                ),
                child: Text(isLoading ? AppLocalizations.of(context)!.loading : AppLocalizations.of(context)!.load_more),
              ),
            ),
          const SizedBox(height: 100),
        ],
      ),
    );
  }
}
