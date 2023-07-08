import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:paurakhi/src/app/screens/auth/login/login_screen.dart';
import 'package:paurakhi/src/app/screens/home/presentation/blog/bloc/blog_bloc.dart';
import 'package:paurakhi/src/app/screens/home/presentation/blog/blog_screen.dart';
import 'package:paurakhi/src/app/screens/home/presentation/finance/bloc/finance_bloc.dart';
import 'package:paurakhi/src/app/screens/home/presentation/finance/financeenquiry_screen.dart';
import 'package:paurakhi/src/app/screens/home/presentation/grants/bloc/grants_bloc.dart';
import 'package:paurakhi/src/app/screens/home/presentation/grants/grants_screen.dart';
import 'package:paurakhi/src/app/screens/home/presentation/history/get%20ticket/getticket_screen.dart';
import 'package:paurakhi/src/app/screens/home/presentation/news/bloc/news_bloc.dart';
import 'package:paurakhi/src/app/screens/home/presentation/news/news_screen.dart';
import 'package:paurakhi/src/core/extensions/colors_extension.dart';
import 'package:paurakhi/src/core/routes/drawerroutes.dart';
import 'package:paurakhi/src/core/routes/is_logged_in.dart';
import 'package:paurakhi/src/core/routes/profileroutes.dart';
import 'package:paurakhi/src/core/themes/appstyles.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EndDrawer extends StatelessWidget {
  const EndDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final TextStyle textStyle = AppStyles.text16PxBold;
    return Drawer(
        child: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Row(
              children: [
                IconButton(
                    icon: const Icon(Icons.menu),
                    onPressed: () {
                      Scaffold.of(context).closeEndDrawer();
                    }),
                const SizedBox(width: 100),
                Text(AppLocalizations.of(context)!.menu,
                    style: AppStyles.text18PxBold)
              ],
            ),
          ),
          ListTile(
            title: Text(AppLocalizations.of(context)!.home, style: textStyle),
            onTap: () async {
              //action on press
              final currentRoute = ModalRoute.of(context)?.settings.name;
              if (currentRoute == "/HomePage" || currentRoute == "/") {
                return;
              } else {
                Navigator.pop(context);
                Navigator.pop(context);
              }

              Scaffold.of(context).closeEndDrawer();
            },
          ),
          ListTile(
              title: Text(AppLocalizations.of(context)!.blog, style: textStyle),
              onTap: () async {
                //action on press
                final currentRoute = ModalRoute.of(context)?.settings.name;
                if (currentRoute != "/HomePage" &&
                    currentRoute != "/BlogScreen") {
                  Get.off(() => const BlogScreen());
                } else if (currentRoute == "/BlogScreen") {
                  return;
                } else {
                  DrawerRoutes.blogRoute();
                }
                BlocProvider.of<BlogBloc>(context).add(FetchBlogEvent());

                Scaffold.of(context).closeEndDrawer();
              }),
          ListTile(
            title: Text(AppLocalizations.of(context)!.news, style: textStyle),
            onTap: () async {
              final currentRoute = ModalRoute.of(context)?.settings.name;

              if (currentRoute != "/HomePage" &&
                  currentRoute != "/NewsScreen") {
                Get.off(() => const NewsScreen());
              } else if (currentRoute == "/NewsScreen") {
                return;
              } else {
                DrawerRoutes.newsRoute();
              }
              BlocProvider.of<NewsBloc>(context).add(FetchNewsEvent());

              Scaffold.of(context).closeEndDrawer();
            },
          ),
          ListTile(
            title:
                Text(AppLocalizations.of(context)!.finance, style: textStyle),
            onTap: () {
              //action on press
              final currentRoute = ModalRoute.of(context)?.settings.name;

              if (currentRoute != "/HomePage") {
                Get.off(() => const FinanceScreen());
              } else if (currentRoute == "/FinanceScreen") {
                return;
              } else {
                DrawerRoutes.financeRoute();
              }
              BlocProvider.of<FinanceBloc>(context).add(FetchFinanceEvent());

              Scaffold.of(context).closeEndDrawer();
            },
          ),
          ListTile(
            title: Text(AppLocalizations.of(context)!.grants, style: textStyle),
            onTap: () {
              //action on press
              final currentRoute = ModalRoute.of(context)?.settings.name;

              if (currentRoute != "/HomePage") {
                Get.off(() => const GrantsScreen());
              } else if (currentRoute == "/GrantsScreen") {
                return;
              } else {
                DrawerRoutes.grantsRoute();
              }
              BlocProvider.of<GrantsBloc>(context).add(FetchGrantsEvent());

              Scaffold.of(context).closeEndDrawer();
            },
          ),
          ListTile(
            title: Text(AppLocalizations.of(context)!.openticket,
                style: AppStyles.text16PxBold.textGreen),
            onTap: () {
              if (IsLoggedIn.isLoggedIn) {
                ProfileRoutes.openticketRoute();
              } else {
                Get.offAll(const LoginScreen());
              }
            },
          ),
          ListTile(
            title: Text(AppLocalizations.of(context)!.ticket_history,
                style: textStyle),
            onTap: () {
              ticketHistoryScreen(context);
            },
          ),
          ListTile(
            title: Text(AppLocalizations.of(context)!.privacy_policy,
                style: textStyle),
            onTap: () {
              //action on press
              final currentRoute = ModalRoute.of(context)?.settings.name;

              if (currentRoute != "/HomePage") {
                Get.off(() => const GrantsScreen());
              } else if (currentRoute == "/PrivacyPolicyTermsAndConditions") {
                return;
              } else {
                DrawerRoutes.termsAndConditions(context);
                // Get.to(() => );
              }
              Scaffold.of(context).closeEndDrawer();
            },
          ),
          ListTile(
            title: Text(AppLocalizations.of(context)!.terms_and_conditions,
                style: textStyle),
            onTap: () {
              //action on press
              final currentRoute = ModalRoute.of(context)?.settings.name;

              if (currentRoute != "/HomePage") {
                Get.off(() => const GrantsScreen());
              } else if (currentRoute == "/PrivacyPolicyTermsAndConditions") {
                return;
              } else {
                DrawerRoutes.privacyPolicy(context);
                // Get.to(() => );
              }
              Scaffold.of(context).closeEndDrawer();
            },
          ),
        ]),
      ),
    ));
  }
}
