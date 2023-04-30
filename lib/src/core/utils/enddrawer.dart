import 'package:flutter/material.dart';
import 'package:paurakhi/main.dart';
import 'package:paurakhi/src/core/routes/drawerroutes.dart';
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
            title: Text("Blog", style: textStyle),
            onTap: () {
              //action on press
              DrawerRoutes.blogRoute();
              Scaffold.of(context).closeEndDrawer();
            },
          ),
          ListTile(
            title: Text("Home", style: textStyle),
            onTap: () {
              //action on press
            },
          ),
          ListTile(
            title: Text("News", style: textStyle),
            onTap: () {
              //action on press
            },
          ),
          SafeArea(
              child: Column(
            children: [
              ExpansionTile(
                title: Text("Category ", style: textStyle),
                childrenPadding: const EdgeInsets.only(left: 60), //children padding
                children: [
                  ListTile(
                    title: Text("Finance", style: textStyle),
                    onTap: () {},
                  ),
                  ListTile(
                    title: Text("Grants", style: textStyle),
                    onTap: () {},
                  ),
                  ListTile(
                    title: Text("Products", style: textStyle),
                    onTap: () {},
                  ),
                  ListTile(
                    title: Text("Tools", style: textStyle),
                    onTap: () {},
                  ),
                  ListTile(
                    title: Text("Trending", style: textStyle),
                    onTap: () {},
                  ),
                ],
              ),
              ListTile(
                title: Text("Agriculture Value Chain", style: textStyle),
                onTap: () {},
              ),
              ListTile(
                title: Text("Open Ticket", style: textStyle),
                onTap: () {},
              ),
              ListTile(
                title: Text("Ticket History", style: textStyle),
                onTap: () {},
              ),
            ],
          )),
        ]),
      ),
    ));
  }
}

class EndDrawer1 extends StatelessWidget {
  const EndDrawer1({super.key});

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
            title: Text("Blog", style: textStyle),
            onTap: () {
              DrawerRoutes.blogRoute();
              //action on press
            },
          ),
          ListTile(
            title: Text("Home", style: textStyle),
            onTap: () {
              //action on press
            },
          ),
          ListTile(
            title: Text("News", style: textStyle),
            onTap: () {
              //action on press
            },
          ),
          SafeArea(
              child: Column(
            children: [
              ExpansionTile(
                title: Text("Category ", style: textStyle),
                childrenPadding: const EdgeInsets.only(left: 60), //children padding
                children: [
                  ListTile(
                    title: Text("Finance", style: textStyle),
                    onTap: () {},
                  ),
                  ListTile(
                    title: Text("Grants", style: textStyle),
                    onTap: () {},
                  ),
                  ListTile(
                    title: Text("Products", style: textStyle),
                    onTap: () {},
                  ),
                  ListTile(
                    title: Text("Tools", style: textStyle),
                    onTap: () {},
                  ),
                  ListTile(
                    title: Text("Trending", style: textStyle),
                    onTap: () {},
                  ),
                ],
              ),
              ListTile(
                title: Text("Agriculture Value Chain", style: textStyle),
                onTap: () {},
              ),
              ListTile(
                title: Text("Open Ticket", style: textStyle),
                onTap: () {},
              ),
              ListTile(
                title: Text("Ticket History", style: textStyle),
                onTap: () {},
              ),
            ],
          )),
        ]),
      ),
    ));
  }
}
