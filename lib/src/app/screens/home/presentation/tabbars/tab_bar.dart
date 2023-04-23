import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:flutter/material.dart';
import 'package:paurakhi/src/core/themes/appstyles.dart';

import 'all.dart';

class Tabbar extends StatelessWidget {
  const Tabbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 2,
      child: ContainedTabBarView(
        tabs: [
          Text('All', style: AppStyles.text14Px),
          Text('Finance', style: AppStyles.text14Px),
          Text('Grants', style: AppStyles.text14Px),
          Text('Products', style: AppStyles.text14Px),
          Text('Tools', style: AppStyles.text14Px)
        ],
        tabBarProperties: TabBarProperties(
          unselectedLabelColor: Colors.black,
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          indicator:
              ContainerTabIndicator(radius: BorderRadius.circular(8.0), borderColor: Colors.black, borderWidth: 2, color: const Color(0xFF34A853)),
        ),
        views: const [All(), All(), All(), All(), All()],
        onChange: (index) => {},
      ),
    );
  }
}
