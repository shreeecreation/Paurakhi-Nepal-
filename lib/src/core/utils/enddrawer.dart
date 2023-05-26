import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paurakhi/src/app/screens/home/presentation/blog/bloc/blog_bloc.dart';
import 'package:paurakhi/src/app/screens/home/presentation/blog/blog_screen.dart';
import 'package:paurakhi/src/app/screens/home/presentation/finance/bloc/finance_bloc.dart';
import 'package:paurakhi/src/app/screens/home/presentation/finance/financeenquiry_screen.dart';
import 'package:paurakhi/src/app/screens/home/presentation/history/get%20ticket/getticket_screen.dart';
import 'package:paurakhi/src/app/screens/home/presentation/news/bloc/news_bloc.dart';
import 'package:paurakhi/src/app/screens/home/presentation/news/news_screen.dart';
import 'package:paurakhi/src/core/extensions/colors_extension.dart';
import 'package:paurakhi/src/core/routes/drawerroutes.dart';
import 'package:paurakhi/src/core/routes/profileroutes.dart';
import 'package:paurakhi/src/core/themes/appstyles.dart';

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
                Text("Menu ", style: AppStyles.text18PxBold)
              ],
            ),
          ),
          ListTile(
            title: Text("Home", style: textStyle),
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
              title: Text("Blog", style: textStyle),
              onTap: () async {
                //action on press
                final currentRoute = ModalRoute.of(context)?.settings.name;

                if (currentRoute != "/HomePage" && currentRoute != "/BlogScreen") {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const BlogScreen()),
                  );
                } else if (currentRoute == "/BlogScreen") {
                  return;
                } else {
                  DrawerRoutes.blogRoute();
                }
                BlocProvider.of<BlogBloc>(context).add(FetchBlogEvent());

                Scaffold.of(context).closeEndDrawer();
              }),
          ListTile(
            title: Text("News", style: textStyle),
            onTap: () async {
              final currentRoute = ModalRoute.of(context)?.settings.name;

              if (currentRoute != "/HomePage") {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const NewsScreen()),
                );
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
            title: Text("Finance", style: textStyle),
            onTap: () {
              //action on press
              final currentRoute = ModalRoute.of(context)?.settings.name;

              if (currentRoute != "/HomePage" && currentRoute != "/FinanceScreen") {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const FinanceScreen()),
                );
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
            title: Text("Grants", style: textStyle),
            onTap: () {},
          ),
          ListTile(
            title: Text("Open Ticket", style: AppStyles.text16PxBold.textGreen),
            onTap: () {
              ProfileRoutes.openticketRoute();
            },
          ),
          ListTile(
            title: Text("Ticket History", style: textStyle),
            onTap: () {
              ticketHistoryScreen(context);
            },
          ),
        ]),
      ),
    ));
  }
}
