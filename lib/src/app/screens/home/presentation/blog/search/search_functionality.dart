import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paurakhi/main.dart';
import 'package:paurakhi/src/app/screens/home/presentation/blog/bloc/blog_bloc.dart';
import 'package:paurakhi/src/app/screens/home/presentation/blog/search/search_value.dart';
import 'package:paurakhi/src/core/utils/search_blog.dart';

import 'blog_result.dart';

class SearchFunctionalityBlog extends StatelessWidget {
  const SearchFunctionalityBlog({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        child: Column(children: [
      // --------------------------------------------------------------------- Search Widget
      searchFilterWidget(context, scaffoldKey),
      const SizedBox(height: 10),

      BlocBuilder<BlogBloc, BlogState>(
        builder: (context, state) {
          if (state is SearchBlogState) {
            return BlogSearchResult(title: SearchValueBlog.searchValue);
          }
          return const Text("\nNo results found ");
        },
      )
    ]));
  }
}
