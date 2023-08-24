import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paurakhi/src/core/API/BlogAPI/blog_api.dart';
import 'package:paurakhi/src/core/env/envmodels.dart';
import 'package:paurakhi/src/core/routes/homeroutes.dart';
import 'package:paurakhi/src/core/themes/appcolors.dart';
import 'package:paurakhi/src/core/themes/appstyles.dart';
import 'package:paurakhi/src/core/utils/enddrawer.dart';
import 'package:paurakhi/src/core/utils/search_blog.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'bloc/blog_bloc.dart';
import 'model/blog_model.dart';
import 'search/search_functionality.dart';

final GlobalKey<ScaffoldState> _scaffoldKeyBlog = GlobalKey<ScaffoldState>();

class BlogScreen extends StatefulWidget {
  const BlogScreen({super.key});

  @override
  State<BlogScreen> createState() => _BlogScreenState();
}

class _BlogScreenState extends State<BlogScreen> {
  bool isLoading = false;
  int currentPage = 1;
  bool isDisposed = false;
  List<BlogModelNewsFinanceModel> items = [];

  @override
  void dispose() {
    isDisposed = true;
    super.dispose();
  }

  Future<void> _getProducts({required bool clearItems}) async {
    setState(() {
      isLoading = true;
    });

    final List<BlogModelNewsFinanceModel>? response =
        await BlogNewsFinanceAPI.getAPI(
      "blog",
      currentPage,
    );

    if (!isDisposed) {
      setState(() {
        isLoading = false;
        if (response != null) {
          if (clearItems) {
            items = response;
          } else {
            items.addAll(response);
          }
        }
      });
    }
  }

  void _loadMore() {
    setState(() {
      currentPage++;
    });
    _getProducts(clearItems: false);
  }

  @override
  void initState() {
    super.initState();
    _getProducts(clearItems: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        endDrawerEnableOpenDragGesture: true, // This!
        key: _scaffoldKeyBlog,
        endDrawer: const EndDrawer(),
        body: BlocBuilder<BlogBloc, BlogState>(
          builder: (context, state) {
            if (state is SearchBlogState || state is SearchedBlogState) {
              return SingleChildScrollView(
                  child: SizedBox(
                      height: MediaQuery.of(context).size.height,
                      child: const SearchFunctionalityBlog()));
            }
            if (state is FetchBlogState) {
              // return const LinearProgressIndicator();
              return SingleChildScrollView(
                  child: SizedBox(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                    // ---------------------------------------------------------------------Search Widget
                    searchBlog(context, _scaffoldKeyBlog),
                    const SizedBox(height: 24),
                    Padding(
                      padding: const EdgeInsets.only(left: 12.0),
                      child: Text(AppLocalizations.of(context)!.blog,
                          style: AppStyles.text22PxBold),
                    ),

                    const SizedBox(height: 10),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.0),
                      child: Divider(thickness: 1, color: Colors.grey),
                    ),
                    const SizedBox(height: 20),

                    items.isEmpty
                        ? SizedBox(
                            height: 300,
                            child: Center(
                              child: Text(
                                "No Blog Found !",
                                style: AppStyles.text20PxSemiBold,
                              ),
                            ),
                          )
                        : ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: items.length,
                            itemBuilder: (BuildContext context, int index) {
                              final BlogModelNewsFinanceModel model =
                                  items[index];
                              return allBlog(context, model);
                            },
                          ),
                    const SizedBox(height: 20),
                    items.length > 9
                        ? Center(
                            child: SizedBox(
                              height: 35,
                              width: 100,
                              child: ElevatedButton(
                                onPressed: isLoading ? null : _loadMore,
                                style: ElevatedButton.styleFrom(
                                  elevation: 0.2,
                                  backgroundColor: isLoading
                                      ? Colors.grey
                                      : AppColors.textGreen,
                                ),
                                child: Text(isLoading
                                    ? AppLocalizations.of(context)!.loading
                                    : AppLocalizations.of(context)!.load_more),
                              ),
                            ),
                          )
                        : const Text(""),

                    const SizedBox(height: 20),
                  ])));
            }
            return const CircularProgressIndicator();
          },
        ));
  }

  Widget allBlog(context, BlogModelNewsFinanceModel model) {
    return GestureDetector(
      onTap: () {
        HomeRoutes.singlePageScreenBlog(model);
      },
      child: Stack(children: [
        Container(
            height: 150,
            width: MediaQuery.of(context).size.width,
            decoration:
                BoxDecoration(borderRadius: BorderRadius.circular(12.0)),
            child: const Card(elevation: 0.2, color: Color(0xFFF4FBF3))),
        Column(
          children: [
            const SizedBox(height: 20),
            Row(
              children: [
                const SizedBox(width: 15),
                Container(
                  height: 120,
                  width: 126,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      image: DecorationImage(
                          // ignore: unnecessary_null_comparison
                          image: model.blogImage == null
                              ? const AssetImage("assets/images/logo2.png")
                                  as ImageProvider<Object>
                              : NetworkImage(
                                  "${Environment.apiUrl}/public/images/${model.blogImage}"),
                          fit: BoxFit.fill)),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Align(
                          alignment: Alignment.bottomRight,
                          child: Container())),
                ),
                const SizedBox(width: 5),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    SizedBox(
                        width: MediaQuery.of(context).size.width / 2,
                        child:
                            Text(model.title, style: AppStyles.text20PxBold)),
                    const SizedBox(height: 10),
                    SizedBox(
                        width: MediaQuery.of(context).size.width / 2,
                        child:
                            Text(model.createdAt, style: AppStyles.text13Px)),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SizedBox(
                            width: MediaQuery.of(context).size.width / 2,
                            child: Text(
                                textAlign: TextAlign.end,
                                "- ${model.author}",
                                style: AppStyles.text14Px)),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ]),
    );
  }
}
