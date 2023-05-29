import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  static const List<Map<String, dynamic>> myMapList = [
    {"notification": "Fermentum et eget libero lectus. Amet, tellus aliquam, dignissim...", "isseen": true},
    {"notification": "Fermentum et eget libero lectus. Amet, tellus aliquam, dignissim...", "isseen": false},
    {"notification": "Fermentum et eget libero lectus. Amet, tellus aliquam, dignissim...", "isseen": true},
    {"notification": "Fermentum et eget libero lectus. Amet, tellus aliquam, dignissim...", "isseen": false},
    {"notification": "Fermentum et eget libero lectus. Amet, tellus aliquam, dignissim...", "isseen": true},
    {"notification": "Fermentum et eget libero lectus. Amet, tellus aliquam, dignissim...", "isseen": true},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            const SizedBox(height: 20),
            const Row(
              children: [SizedBox(width: 20), Text("Notification", style: TextStyle(fontSize: 27, fontWeight: FontWeight.w500))],
            ),
            const SizedBox(height: 20),
            notificationTile(context, myMapList),
          ],
        ),
      ),
      resizeToAvoidBottomInset: false,
    );
  }
}

Widget notificationTile(context, myMap) {
  return ListView.builder(
    physics: const NeverScrollableScrollPhysics(),
    shrinkWrap: true,
    itemCount: myMap.length,
    itemBuilder: (BuildContext context, int index) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: myMap[index]["isseen"] ? const Color(0xFFFFFFFF) : const Color(0xFFECECEC),
            ),
            height: 119,
            width: MediaQuery.of(context).size.width - 30,
            child: Center(
              child: ListTile(
                minVerticalPadding: 10,

                title: SizedBox(
                  height: 30,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Notification Title",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: myMap[index]["isseen"] ? const Color(0xFF2C2C2C) : const Color(0xFF646464),
                          )),
                      // const SizedBox(height: 1),
                    ],
                  ),
                ),
                subtitle: Text(myMap[index]["notification"].toString(),
                    style: TextStyle(
                      fontSize: 16,
                      color: myMap[index]["isseen"] ? const Color(0xFF2C2C2C) : const Color(0xFF646464),
                    )),
                // tileColor:
              ),
            ),
          ),
          const SizedBox(height: 10),
        ],
      );
    },
  );
}
