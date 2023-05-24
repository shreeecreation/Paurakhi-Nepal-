import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paurakhi/src/app/screens/home/presentation/blog/model/blog_model.dart';
import 'package:paurakhi/src/app/screens/home/presentation/homescreen/home_screen.dart';
import 'package:paurakhi/src/core/API/BlogAPI/blog_api.dart';
import 'package:paurakhi/src/core/themes/appstyles.dart';
import 'package:paurakhi/src/core/utils/enddrawer.dart';
import 'package:paurakhi/src/core/utils/search_news.dart';

import 'bloc/news_bloc.dart';
import 'search/search_functionality.dart';


final GlobalKey<ScaffoldState> _scaffoldKeyNews = GlobalKey<ScaffoldState>();
class NewsScreen extends StatelessWidget {
  const NewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        endDrawerEnableOpenDragGesture: true, // This!
        key: _scaffoldKeyNews,
        endDrawer: const EndDrawer(),
        body: BlocBuilder<NewsBloc, NewsState>(
          builder: (context, state) {
            if (state is SearchNewsState || state is SearchedNewsState) {
              return const SearchFunctionalityNews();
            }
            if (state is FetchNewsState) {
              // return const LinearProgressIndicator();
              return SingleChildScrollView(
                  child: SizedBox(
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                // ---------------------------------------------------------------------Search Widget
                searchNews(context, _scaffoldKeyNews),
                const SizedBox(height: 24),
                Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: Text("Newss", style: AppStyles.text22PxBold),
                ),

                const SizedBox(height: 10),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.0),
                  child: Divider(thickness: 1, color: Colors.grey),
                ),
                const SizedBox(height: 20),

                FutureBuilder<List<BlogModelandNewsModel>?>(
                    future: BlogandNewsAPI.getNews(),
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
                                  // HomeRoutes.singlePageScreenNews(models);
                                },
                                child: allNews(context, models));
                          },
                        );
                      } else if (snapshot.hasError) {
                        // If the future has an error, display the error message
                        return Text('${snapshot.error}');
                      } else {
                        // If the future is not complete yet, display a loading indicator
                        return Center(child: Text("\nThere is no Newss available right now !", style: AppStyles.text16PxBold));
                      }
                    })
              ])));
            }
            return const CircularProgressIndicator();
          },
        ));
  }

  Widget allNews(context, BlogModelandNewsModel model) {
    return Stack(children: [
      Container(
          height: 150,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(12.0)),
          child: const Card(elevation: 0.2, color: Color(0xFFF4FBF3))),
      Column(
        children: [
          const SizedBox(height: 20),
          GestureDetector(
            onTap: () {},
            child: Row(
              children: [
                const SizedBox(width: 15),
                Container(
                  height: 120,
                  width: 126,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      image: const DecorationImage(image: AssetImage("assets/images/nepalflag.png"), fit: BoxFit.cover)),
                  child: ClipRRect(borderRadius: BorderRadius.circular(10.0), child: Align(alignment: Alignment.bottomRight, child: Container())),
                ),
                const SizedBox(width: 5),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    SizedBox(width: MediaQuery.of(context).size.width / 2, child: Text(model.tittle, style: AppStyles.text20PxBold)),
                    const SizedBox(height: 10),
                    SizedBox(width: MediaQuery.of(context).size.width / 2, child: Text(model.createdAt, style: AppStyles.text14Px)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ]);
  }
}
