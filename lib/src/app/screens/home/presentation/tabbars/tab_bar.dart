import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paurakhi/src/app/screens/home/presentation/homescreen/bloc/request_bloc.dart';
import 'package:paurakhi/src/app/screens/home/presentation/request/addproductScreen/domain/dropdown.dart';
import 'package:paurakhi/src/app/screens/home/presentation/request/addproductScreen/domain/dropdown_api.dart';
import 'package:paurakhi/src/app/screens/home/presentation/request/bloc/getprdouct_bloc.dart';
import 'package:paurakhi/src/app/screens/home/presentation/tabbars/bloc/tab_bloc_bloc.dart';
import 'package:paurakhi/src/core/API/GetProductAPI/get_product_api.dart';
import 'package:paurakhi/src/core/API/GetProductAPI/get_product_model.dart';

import 'all.dart';
import 'loadmore_controller.dart';

class Tabbar extends StatefulWidget {
  const Tabbar({Key? key}) : super(key: key);

  @override
  State<Tabbar> createState() => _TabbarState();
}

class _TabbarState extends State<Tabbar> with TickerProviderStateMixin {
  TabController? _tabController;
  int tabBarLength = 0;
  int categoryIndex = 0;
  String mainCategoryIndex = "";
  int currentTabIndex1 = 0;
  int currentTabIndex2 = 0;

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
      BlocProvider.of<RequestBloc>(context).add(RequestStartEvent());
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
    tabBarLength = 0;
    categoryIndex = 0;
    mainCategoryIndex = "";
    currentTabIndex2 = 0;
    currentTabIndex1 = 0;

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TabBlocBloc, TabBlocState>(
      builder: (context, state) {
        if (state is GetTabLengthState) {
          return FutureBuilder<List<DropdownMenuItem>>(
            future: _loadDropdownItems(),
            builder: (BuildContext context,
                AsyncSnapshot<List<DropdownMenuItem>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                // return loadingIndicator(context);
              } else if (snapshot.hasError) {
                return const Center(
                    child: Text('Error loading dropdown items'));
              } else if (!snapshot.hasData) {
                return const Center(child: Text('No data'));
              }
              return BlocBuilder<RequestBloc, RequestState>(
                builder: (context, state) {
                  if (state is RequestStartState) {
                    LoadMoreController.currentPage = 1;
                    return futureBuilderSell();
                  }
                  if (state is RequestEndState) {
                    LoadMoreController.currentPage = 1;
                    return futureBuilderRequest();
                  }
                  return Center(
                    child: Image.asset(
                      "assets/images/paurakhi.png",
                      height: 100,
                      fit: BoxFit.fill,
                    ),
                  );
                },
              );
            },
          );
        }

        return const Text("");
      },
    );
  }

  SizedBox futureBuilderSell() {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
            child: FutureBuilder<List<DropdownMenuItem>>(
              future: DropdownList.returnDropdown(),
              builder: (BuildContext context,
                  AsyncSnapshot<List<DropdownMenuItem>> snapshot) {
                GetProductModel model = GetProductModel();
                model.page = 0;
                model.type = "sell";
                GetProductAPI.getProductSinglePage(model);
                BlocProvider.of<GetprdouctBloc>(context)
                    .add(GetProdcutFetchEvent());

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasData) {
                  final List<DropdownMenuItem> tabTextList = snapshot.data!;
                  return Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: TabBar(
                      controller: _tabController,
                      onTap: (value) {
                        currentTabIndex1 = value;
                        BlocProvider.of<GetprdouctBloc>(context)
                            .add(GetProdcutFetchEvent());
                        LoadMoreController.currentPage = 1;
                        mainCategoryIndex = tabTextList[value].value;
                      },
                      isScrollable: true,
                      labelPadding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 0,
                      ),
                      unselectedLabelColor: Colors.black,
                      labelColor: Colors.white,
                      splashBorderRadius: BorderRadius.circular(20),
                      indicator: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        color: Colors.green,
                      ),
                      tabs: tabTextList
                          .map(
                            (tabText) => SizedBox(
                              height: 30,
                              child: Tab(child: tabText.child),
                            ),
                          )
                          .toList(),
                    ),
                  );
                } else {
                  return const Text("");
                }
              },
            ),
          ),
          BlocBuilder<GetprdouctBloc, GetprdouctState>(
            builder: (context, state) {
              if (state is GetProdcutFetchState) {
                return SizedBox(
                  height: MediaQuery.of(context).size.height / 2.2,
                  child: TabBarView(
                    controller: _tabController,
                    physics: const NeverScrollableScrollPhysics(),
                    children: List.generate(
                      tabBarLength,
                      (index) => GestureDetector(
                        onTap: () {},
                        child: All(
                          category: mainCategoryIndex,
                          type: "sell",
                        ),
                      ),
                    ).toList(),
                  ),
                );
              }
              return const Text("");
            },
          ),
          const SizedBox(height: 60),
        ],
      ),
    );
  }

  SizedBox futureBuilderRequest() {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
            child: FutureBuilder<List<DropdownMenuItem>>(
              future: DropdownList.returnDropdown(),
              builder: (BuildContext context,
                  AsyncSnapshot<List<DropdownMenuItem>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasData) {
                  final List<DropdownMenuItem> tabTextList = snapshot.data!;
                  return Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: TabBar(
                      controller: _tabController,
                      onTap: (value) {
                        currentTabIndex2 = value;
                        BlocProvider.of<GetprdouctBloc>(context)
                            .add(GetProdcutFetchEvent());
                        LoadMoreController.currentPage = 1;
                        mainCategoryIndex = tabTextList[value].value;
                      },
                      isScrollable: true,
                      labelPadding: const EdgeInsets.symmetric(horizontal: 10),
                      unselectedLabelColor: Colors.black,
                      labelColor: Colors.white,
                      splashBorderRadius: BorderRadius.circular(20),
                      indicator: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        color: Colors.green,
                      ),
                      tabs: tabTextList
                          .map(
                            (tabText) => SizedBox(
                              height: 30,
                              child: Tab(child: tabText.child),
                            ),
                          )
                          .toList(),
                    ),
                  );
                } else {
                  return const Text("");
                }
              },
            ),
          ),
          BlocBuilder<GetprdouctBloc, GetprdouctState>(
            builder: (context, state) {
              if (state is GetProdcutFetchState) {
                return SizedBox(
                  height: MediaQuery.of(context).size.height / 2.5,
                  child: TabBarView(
                    controller: _tabController,
                    physics: const NeverScrollableScrollPhysics(),
                    children: List.generate(
                      tabBarLength,
                      (index) => GestureDetector(
                        onTap: () {},
                        child: All1(
                          category: mainCategoryIndex,
                          type: "request",
                        ),
                      ),
                    ).toList(),
                  ),
                );
              }
              return const Text("");
            },
          ),
        ],
      ),
    );
  }
}
