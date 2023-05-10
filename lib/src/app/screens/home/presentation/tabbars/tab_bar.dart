import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paurakhi/src/app/screens/home/presentation/request/addproductScreen/domain/dropdown.dart';
import 'package:paurakhi/src/app/screens/home/presentation/request/addproductScreen/domain/dropdown_api.dart';
import 'package:paurakhi/src/app/screens/home/presentation/tabbars/bloc/tab_bloc_bloc.dart';
import 'package:paurakhi/src/core/API/GetProductAPI/get_product_api.dart';
import 'package:paurakhi/src/core/API/GetProductAPI/get_product_model.dart';

import 'all.dart';

class Tabbar extends StatefulWidget {
  const Tabbar({super.key});

  @override
  State<Tabbar> createState() => _TabbarState();
}

class _TabbarState extends State<Tabbar> with TickerProviderStateMixin  {
  TabController? _tabController;
  int tabBarLength = 0;
  @override
  void dispose() {
    // TODO: implement dispose
    _tabController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TabBlocBloc, TabBlocState>(
      builder: (context, state) {
        if (state is TabBlocInitial) {
          DropdownList.returnCategoryOnly();
          var a = DropDownAPI.categoryAPI();
          a.then((value) {
            tabBarLength = value.length;
            _tabController = TabController(length: tabBarLength, vsync: this);
            BlocProvider.of<TabBlocBloc>(context).add(GetTabLengthEvent());
          });
        }

        if (state is GetTabLengthState) {
          return SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                    child: FutureBuilder<List<String>>(
                        future: DropdownList.returnCatergory(),
                        builder: (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
                          GetProductModel model = GetProductModel();
                          model.page = 0;
                          model.type = "sell";

                          GetProductAPI.getProduct(model);
                          if (snapshot.hasData) {
                            final List<String> tabTextList = snapshot.data!;
                            return TabBar(
                              isScrollable: true,
                              labelPadding: const EdgeInsets.symmetric(horizontal: 10),
                              unselectedLabelColor: Colors.black,
                              labelColor: Colors.white,
                              splashBorderRadius: BorderRadius.circular(20),
                              indicator: ShapeDecoration(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)), color: Colors.green),
                              tabs: tabTextList.map((tabText) => Tab(child: Text(tabText))).toList(),
                              controller: _tabController,
                              indicatorSize: TabBarIndicatorSize.tab,
                            );
                          } else {
                            return const Center(child: CircularProgressIndicator());
                          }
                        }),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 2,
                    child: TabBarView(
                      controller: _tabController,
                      children: List.generate(tabBarLength, (index) => const All()),
                    ),
                  ),
                ],
              ));
        }
        return const CircularProgressIndicator();
      },
    );
  }
}
