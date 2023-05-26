import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paurakhi/src/core/API/BlogAPI/blog_api.dart';
import 'package:paurakhi/src/core/routes/homeroutes.dart';
import 'package:paurakhi/src/core/themes/appstyles.dart';
import 'package:paurakhi/src/core/utils/enddrawer.dart';
import 'package:paurakhi/src/core/utils/search_blog.dart';

import 'bloc/blog_bloc.dart';
import 'model/blog_model.dart';
import 'search/search_functionality.dart';

final GlobalKey<ScaffoldState> _scaffoldKeyBlog = GlobalKey<ScaffoldState>();

class BlogScreen extends StatelessWidget {
  const BlogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        endDrawerEnableOpenDragGesture: true, // This!
        key: _scaffoldKeyBlog,
        endDrawer: const EndDrawer(),
        body: BlocBuilder<BlogBloc, BlogState>(
          builder: (context, state) {
            if (state is SearchBlogState || state is SearchedBlogState) {
              return const SearchFunctionalityBlog();
            }
            if (state is FetchBlogState) {
              // return const LinearProgressIndicator();
              return SingleChildScrollView(
                  child: SizedBox(
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                // ---------------------------------------------------------------------Search Widget
                searchBlog(context, _scaffoldKeyBlog),
                const SizedBox(height: 24),
                Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: Text("Blogs", style: AppStyles.text22PxBold),
                ),

                const SizedBox(height: 10),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.0),
                  child: Divider(thickness: 1, color: Colors.grey),
                ),
                const SizedBox(height: 20),

                FutureBuilder<List<BlogModelandNewsModel>?>(
                    future: BlogandNewsAPI.getBlog(),
                    builder: (BuildContext context, AsyncSnapshot<List<BlogModelandNewsModel>?> snapshot) {
                      if (snapshot.hasData) {
                        // If the future is complete and has data, display the product data
                        final List<BlogModelandNewsModel> model = snapshot.data!;
                        return ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: model.length,
                          itemBuilder: (BuildContext context, int index) {
                            final BlogModelandNewsModel models = model[index];
                            return GestureDetector(
                                onTap: () {
                                  HomeRoutes.singlePageScreenBlog(models);
                                },
                                child: allBlog(context, models));
                          },
                        );
                      } else if (snapshot.hasError) {
                        // If the future has an error, display the error message
                        return Text('${snapshot.error}');
                      } else {
                        // If the future is not complete yet, display a loading indicator
                        return Center(child: Text("\nThere is no blogs available right now !", style: AppStyles.text16PxBold));
                      }
                    })
              ])));
            }
            return const CircularProgressIndicator();
          },
        ));
  }

  Widget allBlog(context, BlogModelandNewsModel model) {
    print(model.title);
    return GestureDetector(
      onTap: () {
        HomeRoutes.singlePageScreenBlog(model);
      },
      child: Stack(children: [
        Container(
            height: 150,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(12.0)),
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
                          image: model.blogImage == null
                              ? const AssetImage("assets/images/logo2.png") as ImageProvider<Object>
                              : NetworkImage(model.blogImage),
                          fit: BoxFit.fill)),
                  child: ClipRRect(borderRadius: BorderRadius.circular(10.0), child: Align(alignment: Alignment.bottomRight, child: Container())),
                ),
                const SizedBox(width: 5),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    SizedBox(width: MediaQuery.of(context).size.width / 2, child: Text(model.title, style: AppStyles.text20PxBold)),
                    const SizedBox(height: 10),
                    SizedBox(width: MediaQuery.of(context).size.width / 2, child: Text(model.createdAt, style: AppStyles.text13Px)),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SizedBox(
                            width: MediaQuery.of(context).size.width / 2,
                            child: Text(textAlign: TextAlign.end, "- ${model.author}", style: AppStyles.text14Px)),
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
