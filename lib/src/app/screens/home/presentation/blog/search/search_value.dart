import 'package:paurakhi/src/app/screens/home/presentation/finance/search/search_value.dart';
import 'package:paurakhi/src/app/screens/home/presentation/grants/search/search_value.dart';
import 'package:paurakhi/src/app/screens/home/presentation/news/search/search_value.dart';

class SearchValueBlog {
  static String searchValue = "";
}

void clearAllSearchValue() {
  SearchValueBlog.searchValue = "";
  SearchValueNews.searchValue = "";
  SearchValueGrants.searchValue = "";
  SearchValueFinance.searchValue = "";
}
