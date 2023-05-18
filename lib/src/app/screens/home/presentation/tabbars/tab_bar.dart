import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paurakhi/src/app/screens/home/presentation/homescreen/bloc/request_bloc.dart';
import 'package:paurakhi/src/app/screens/home/presentation/request/addproductScreen/domain/dropdown.dart';
import 'package:paurakhi/src/app/screens/home/presentation/request/addproductScreen/domain/dropdown_api.dart';
import 'package:paurakhi/src/app/screens/home/presentation/request/bloc/getprdouct_bloc.dart';
import 'package:paurakhi/src/app/screens/home/presentation/tabbars/bloc/tab_bloc_bloc.dart';
import 'package:paurakhi/src/core/API/GetProductAPI/get_product_api.dart';
import 'package:paurakhi/src/core/API/GetProductAPI/get_product_model.dart';
import 'package:paurakhi/src/core/themes/appcolors.dart';

import 'all.dart';

class Tabbar extends StatefulWidget {
  const Tabbar({super.key});

  @override
  State<Tabbar> createState() => _TabbarState();
}

class _TabbarState extends State<Tabbar> with TickerProviderStateMixin {
  TabController? _tabController;
  int tabBarLength = 0;
  int categoryIndex = 0;
  String mainCategoryIndex = "1";
  Future<List<DropdownMenuItem>> _loadDropdownItems() async {
    return await DropdownList.returnDropdown();
  }

  @override
  void initState() {
    super.initState();
    var a = DropDownAPI.categoryAPI();
    a.then((value) {
      tabBarLength = value.length;
      _tabController = TabController(length: tabBarLength, vsync: this);
      _tabController!.animation!.addListener(_handleTabSelection);
      BlocProvider.of<TabBlocBloc>(context).add(GetTabLengthEvent());
      BlocProvider.of<GetprdouctBloc>(context).add(GetProdcutFetchEvent());
    });
  }

  void _handleTabSelection() {
    if (_tabController!.indexIsChanging) {
      categoryIndex = _tabController!.index;
    }
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TabBlocBloc, TabBlocState>(
      builder: (context, state) {
        if (state is GetTabLengthState) {
          return FutureBuilder<List<DropdownMenuItem>>(
              future: _loadDropdownItems(),
              builder: (BuildContext context, AsyncSnapshot<List<DropdownMenuItem>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: LinearProgressIndicator(color: AppColors.primary));
                } else if (snapshot.hasError) {
                  return const Center(child: Text('Error loading dropdown items'));
                } else if (!snapshot.hasData) {
                  return const Center(child: Text('No data'));
                }
                return BlocBuilder<RequestBloc, RequestState>(
                  builder: (context, state) {
                    if (state is RequestStartState) {
                      return futureBuilder(context, "request");
                    }
                    if (state is RequestEndState) {
                      return futureBuilder(context, "sell");
                    }
                    if (state is RequestInitial) {
                      return futureBuilder(context, "sell");
                    }
                    return const CircularProgressIndicator();
                  },
                );
              });
        }

        return const Center(child: LinearProgressIndicator(color: AppColors.primary));
      },
    );
  }

  SizedBox futureBuilder(BuildContext context, String type) {
    return SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              child: FutureBuilder<List<DropdownMenuItem>>(
                  future: DropdownList.returnDropdown(),
                  builder: (BuildContext context, AsyncSnapshot<List<DropdownMenuItem>> snapshot) {
                    GetProductModel model = GetProductModel();
                    model.page = 0;
                    model.type = type;
                    GetProductAPI.getProductSinglePage(model);
                    if (snapshot.hasData) {
                      final List<DropdownMenuItem> tabTextList = snapshot.data!;
                      return Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: TabBar(
                            controller: _tabController,
                            onTap: (value) {
                              BlocProvider.of<GetprdouctBloc>(context).add(GetProdcutFetchEvent());

                              mainCategoryIndex = tabTextList[value].value;
                            },
                            isScrollable: true,
                            labelPadding: const EdgeInsets.symmetric(horizontal: 10),
                            unselectedLabelColor: Colors.black,
                            labelColor: Colors.white,
                            splashBorderRadius: BorderRadius.circular(20),
                            indicator: ShapeDecoration(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)), color: Colors.green),
                            tabs: tabTextList.map((tabText) => Tab(child: tabText.child)).toList(),
                            indicatorSize: TabBarIndicatorSize.tab),
                      );
                    } else {
                      return const Text("");
                    }
                  }),
            ),
            BlocBuilder<GetprdouctBloc, GetprdouctState>(
              builder: (context, state) {
                if (state is GetProdcutFetchState) {
                  return SizedBox(
                      height: MediaQuery.of(context).size.height / 2.5,
                      child: TabBarView(
                        controller: _tabController,
                        physics: const NeverScrollableScrollPhysics(),
                        children: List.generate(tabBarLength, (index) => All(category: mainCategoryIndex)),
                      ));
                }
                return const Center(
                    child: LinearProgressIndicator(
                  color: AppColors.textGreen,
                  backgroundColor: Colors.white,
                ));
              },
            )
          ],
        ));
  }
}
