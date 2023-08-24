import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:paurakhi/src/app/screens/home/presentation/grants/bloc/grants_bloc.dart';
import 'package:paurakhi/src/app/screens/home/presentation/tabbars/bloc/tab_bloc_bloc.dart';
import 'package:paurakhi/src/app/screens/internetandSetverError/nointernetconnection.dart';
import 'package:paurakhi/src/core/utils/splash_screen.dart';
import 'package:provider/provider.dart';
import 'l10n/l10n.dart';
import 'src/app/screens/features/onboarding/pages/onboarding_page.dart';
import 'src/app/screens/features/preferences/onboarding_preferences.dart';
import 'src/app/screens/home/presentation/finance/bloc/finance_bloc.dart';
import 'src/app/screens/home/presentation/news/bloc/news_bloc.dart';
import 'src/app/screens/home/presentation/blog/bloc/blog_bloc.dart';
import 'src/app/screens/home/presentation/homescreen/bloc/request_bloc.dart';
import 'src/app/screens/home/presentation/profile/bloc/profile_bloc.dart';
import 'src/app/screens/home/presentation/request/bloc/getprdouct_bloc.dart';
import 'src/app/screens/internetandSetverError/check_internet_connection.dart';
import 'src/app/screens/search/bloc/search_bloc.dart';
import 'src/core/InitiallMethod/intial_method.dart';
import 'src/core/providers/location_provider.dart';
import 'src/core/utils/focuesnode.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
      overlays: SystemUiOverlay.values);

  IntialMethod.initialMethod();

  runApp(MyApp());
}

final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final NetworkService networkService = Get.put(NetworkService());
  @override
  Widget build(BuildContext context) {
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
              BlocProvider<GetprdouctBloc>(
                  create: (context) => GetprdouctBloc()),
              BlocProvider<RequestBloc>(create: (context) => RequestBloc()),
              BlocProvider<NewsBloc>(create: (context) => NewsBloc()),
              BlocProvider<BlogBloc>(create: (context) => BlogBloc()),
              BlocProvider<FinanceBloc>(create: (context) => FinanceBloc()),
              BlocProvider<GrantsBloc>(create: (context) => GrantsBloc()),
            ],
            child: GestureDetector(
              onTap: () {
                unFocusNode(context);
              },
              child: SafeArea(
                top: false,
                child: GetMaterialApp(
                  supportedLocales: L10n.all,
                  locale: const Locale("en"),
                  localizationsDelegates: const [
                    AppLocalizations.delegate,
                    GlobalMaterialLocalizations.delegate,
                    GlobalCupertinoLocalizations.delegate
                  ],
                  debugShowCheckedModeBanner: false,
                  theme: ThemeData(
                    fontFamily: "poppins",
                    primarySwatch: Colors.blue,
                    brightness: Brightness.light,
                  ),
                  home: FutureBuilder<void>(
                    future: networkService.checkInternetConnection(),
                    builder:
                        (BuildContext context, AsyncSnapshot<void> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        // Show a loading indicator while checking the connection
                        return const CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        return Obx(
                          () {
                            if (networkService.isConnected.value) {
                              return FutureBuilder(
                                future: checkIfOnboardingShown(),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const CircularProgressIndicator(); // Loading indicator
                                  } else {
                                    final onboardingShown =
                                        snapshot.data as bool;
                                    return onboardingShown
                                        ? const SplashScreen()
                                        : const OnBoardingPage();
                                  }
                                },
                              );
                            } else {
                              return const NoInternetConnectionPage();
                            }
                          },
                        );
                      }
                    },
                  ),
                ),
              ),
            )));
  }
}

class NetworkService extends GetxController {
  RxBool isConnected = false.obs;

  Future<void> checkInternetConnection() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      isConnected.value = true;
    } else {
      isConnected.value = false;
    }
  }
}

// import 'package:connectivity/connectivity.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_localizations/flutter_localizations.dart';
// import 'package:get/get.dart';
// import 'package:paurakhi/src/app/screens/home/presentation/grants/bloc/grants_bloc.dart';
// import 'package:paurakhi/src/app/screens/home/presentation/tabbars/bloc/tab_bloc_bloc.dart';
// import 'package:paurakhi/src/app/screens/internetandSetverError/nointernetconnection.dart';
// import 'package:paurakhi/src/core/utils/splash_screen.dart';
// import 'package:provider/provider.dart';
// import 'l10n/l10n.dart';
// import 'src/app/screens/home/presentation/finance/bloc/finance_bloc.dart';
// import 'src/app/screens/home/presentation/news/bloc/news_bloc.dart';
// import 'src/app/screens/home/presentation/blog/bloc/blog_bloc.dart';
// import 'src/app/screens/home/presentation/homescreen/bloc/request_bloc.dart';
// import 'src/app/screens/home/presentation/profile/bloc/profile_bloc.dart';
// import 'src/app/screens/home/presentation/request/bloc/getprdouct_bloc.dart';
// import 'src/app/screens/internetandSetverError/check_internet_connection.dart';
// import 'src/app/screens/search/bloc/search_bloc.dart';
// import 'src/core/InitiallMethod/intial_method.dart';
// import 'src/core/env/envmodels.dart';
// import 'src/core/providers/language_provider.dart';
// import 'src/core/providers/location_provider.dart';
// import 'src/core/utils/focuesnode.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// void main() {
//   WidgetsFlutterBinding.ensureInitialized();
//   IntialMethod.initialMethod();
//   runApp(MyApp());
// }

// final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

// class MyApp extends StatelessWidget {
//   MyApp({super.key});

//   final NetworkService networkService = Get.put(NetworkService());
//   @override
//   Widget build(BuildContext context) {
//     LocalizationManager.getCurrentLocale().then((value) => print(value));
//     IntialMethod.initialMethod();

//     return FutureBuilder(
//         future: LocalizationManager.getCurrentLocale(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const CircularProgressIndicator();
//           } else if (snapshot.hasError) {
//             return Text('Error: ${snapshot.error}');
//           }
//           if (snapshot.hasData) {
//             return MultiProvider(
//                 providers: [
//                   ChangeNotifierProvider(create: (_) => LocationProvider()),
//                   ChangeNotifierProvider(create: (_) => NetworkProvider()),
//                 ],
//                 child: MultiBlocProvider(
//                     providers: [
//                       BlocProvider<TabBlocBloc>(create: (context) => TabBlocBloc()),
//                       BlocProvider<SearchBloc>(create: (context) => SearchBloc()),
//                       BlocProvider<ProfileBloc>(create: (context) => ProfileBloc()),
//                       BlocProvider<GetprdouctBloc>(create: (context) => GetprdouctBloc()),
//                       BlocProvider<RequestBloc>(create: (context) => RequestBloc()),
//                       BlocProvider<NewsBloc>(create: (context) => NewsBloc()),
//                       BlocProvider<BlogBloc>(create: (context) => BlogBloc()),
//                       BlocProvider<FinanceBloc>(create: (context) => FinanceBloc()),
//                       BlocProvider<GrantsBloc>(create: (context) => GrantsBloc()),
//                     ],
//                     child: GestureDetector(
//                       onTap: () {
//                         unFocusNode(context);
//                       },
//                       child: SafeArea(
//                         child: GetMaterialApp(
//                           supportedLocales: L10n.all,
//                           locale: Locale(LocalizationManager.storedLocale),
//                           localizationsDelegates: const [
//                             AppLocalizations.delegate,
//                             GlobalMaterialLocalizations.delegate,
//                             GlobalCupertinoLocalizations.delegate
//                           ],
//                           debugShowCheckedModeBanner: false,
//                           theme: ThemeData(
//                             primarySwatch: Colors.blue,
//                             brightness: Brightness.light,
//                           ),
//                           home: FutureBuilder<void>(
//                             future: networkService.checkInternetConnection(),
//                             builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
//                               if (snapshot.connectionState == ConnectionState.waiting) {
//                                 // Show a loading indicator while checking the connection
//                                 return const CircularProgressIndicator();
//                               } else if (snapshot.hasError) {
//                                 // If an error occurred while checking the connection, display an error message
//                                 return Text('Error: ${snapshot.error}');
//                               } else {
//                                 return Obx(
//                                   () {
//                                     if (networkService.isConnected.value) {
//                                       // If there is an active internet connection
//                                       return const SplashScreen();
//                                     } else {
//                                       // If there is no internet connection
//                                       return const NoInternetConnectionPage();
//                                     }
//                                   },
//                                 );
//                               }
//                             },
//                           ),
//                         ),
//                       ),
//                     )));
//           }
//           return const CircularProgressIndicator();
//         });
//   }
// }

// class NetworkService extends GetxController {
//   RxBool isConnected = false.obs;

//   Future<void> checkInternetConnection() async {
//     var connectivityResult = await Connectivity().checkConnectivity();
//     if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {
//       isConnected.value = true;
//     } else {
//       isConnected.value = false;
//     }
//   }
// }
