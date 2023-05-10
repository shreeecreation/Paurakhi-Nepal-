import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:paurakhi/src/app/screens/auth/login/login_screen.dart';
import 'package:paurakhi/src/app/screens/home/presentation/tabbars/bloc/tab_bloc_bloc.dart';
import 'package:paurakhi/src/core/env/envmodels.dart';
import 'src/app/screens/home/presentation/home_page.dart';
import 'src/app/screens/search/bloc/search_bloc.dart';
import 'src/core/API/CheckLogin/check_login.dart';
import 'src/core/utils/focuesnode.dart';

Future<void> main() async {
  await dotenv.load(fileName: Environment.fileName);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: Colors.white));
  await dotenv.load();
  runApp(const MyApp());
}

final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TabBlocBloc>(create: (context) => TabBlocBloc()),
        BlocProvider<SearchBloc>(create: (context) => SearchBloc()),
      ],
      child: GestureDetector(
        onTap: () {
          unFocusNode(context);
        },
        child: SafeArea(
          child: GetMaterialApp(
              debugShowCheckedModeBanner: false,
              theme: ThemeData(primarySwatch: Colors.blue, brightness: Brightness.light),
              home: FutureBuilder<bool>(
                future: CheckLogin.checkLogin(),
                builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    // While data is being fetched, show a loading indicator
                    return const CircularProgressIndicator();
                  } else if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasError) {
                      // If an error occurred while fetching data, show an error message
                      return Text('Error: ${snapshot.error}');
                    } else if (snapshot.data == true) {
                      return const HomePage();
                    } else {
                      // If the boolean value is false, show a red X
                      return const LoginScreen();
                    }
                  } else {
                    // Default case: show an empty Container widget
                    return Container();
                  }
                },
              )),
        ),
      ),
    );
  }
}
