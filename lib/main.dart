import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:paurakhi/src/app/screens/home/presentation/tabbars/bloc/tab_bloc_bloc.dart';
import 'package:paurakhi/src/app/screens/internetandSetverError/nointernetconnection.dart';
import 'package:paurakhi/src/core/routes/is_logged_in.dart';
import 'package:paurakhi/src/core/utils/splash_screen.dart';
import 'package:provider/provider.dart';
import 'src/app/screens/home/presentation/finance/bloc/finance_bloc.dart';
import 'src/app/screens/home/presentation/news/bloc/news_bloc.dart';
import 'src/app/screens/home/presentation/blog/bloc/blog_bloc.dart';
import 'src/app/screens/home/presentation/homescreen/bloc/request_bloc.dart';
import 'src/app/screens/home/presentation/profile/bloc/profile_bloc.dart';
import 'src/app/screens/home/presentation/request/bloc/getprdouct_bloc.dart';
import 'src/app/screens/internetandSetverError/check_internet_connection.dart';
import 'src/app/screens/search/bloc/search_bloc.dart';
import 'src/core/API/userIfno/getuserinfo.dart';
import 'src/core/InitiallMethod/intial_method.dart';
import 'src/core/providers/location_provider.dart';
import 'src/core/utils/focuesnode.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  IntialMethod.initialMethod();
  runApp(const MyApp());
}

final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    // final networkProvider = Provider.of<NetworkProvider>(context); // Retrieve the provided instance
    Future<bool> _checkInternetConnection(BuildContext context) async {
      final networkProvider = Provider.of<NetworkProvider>(context, listen: false);
      return networkProvider.checkInternetConnection();
    }

    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => LocationProvider()),
          ChangeNotifierProvider(create: (_) => NetworkProvider()),
        ],
        child: MultiBlocProvider(
            providers: [
              BlocProvider<TabBlocBloc>(create: (context) => TabBlocBloc()),
              BlocProvider<SearchBloc>(create: (context) => SearchBloc()),
              BlocProvider<ProfileBloc>(create: (context) => ProfileBloc()),
              BlocProvider<GetprdouctBloc>(create: (context) => GetprdouctBloc()),
              BlocProvider<RequestBloc>(create: (context) => RequestBloc()),
              BlocProvider<NewsBloc>(create: (context) => NewsBloc()),
              BlocProvider<BlogBloc>(create: (context) => BlogBloc()),
              BlocProvider<FinanceBloc>(create: (context) => FinanceBloc()),
            ],
            child: GestureDetector(
              onTap: () {
                unFocusNode(context);
              },
              child: SafeArea(
                child: GetMaterialApp(
                  debugShowCheckedModeBanner: false,
                  theme: ThemeData(primarySwatch: Colors.blue, brightness: Brightness.light),
                  home: Consumer<NetworkProvider>(builder: (context, networkProvider, child) {
                    return FutureBuilder<bool>(
                      future: networkProvider.checkInternetConnection(),
                      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
                        if (snapshot.connectionState == ConnectionState.none) {
                          // Default case: show an empty Container widget
                          return Container();
                        }
                        if (snapshot.connectionState == ConnectionState.done) {
                          if (snapshot.hasError) {
                            // If an error occurred while fetching data, show an error message
                            return Text('Error: ${snapshot.error}');
                          } else if (snapshot.data == true) {
                            GetUserInfo.getUserInfo();
                            IsLoggedIn.isLoggedIn = true;
                            return const SplashScreen();
                          } else {
                            IsLoggedIn.isLoggedIn = false;
                            return const NoInternetConnectionPage();
                          }
                        } else {
                          return const NoInternetConnectionPage();
                        }
                      },
                    );
                  }),
                ),
              ),
            )));
  }
}
