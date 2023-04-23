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
    return SingleChildScrollView(
    physics: const BouncingScrollPhysics(),

      child: Column(
        children: [
          const SizedBox(height: 20),
          const Row(
            children: [SizedBox(width: 25), Text("Notification", style: TextStyle(fontSize: 28, fontWeight: FontWeight.w500))],
          ),
          const SizedBox(height: 20),
          notificationTile(context, myMapList),
        ],
      ),
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
                title: Text("Notification Title",
                    style: TextStyle(
                      fontSize: 22.7,
                      fontWeight: FontWeight.w400,
                      color: myMap[index]["isseen"] ? const Color(0xFF2C2C2C) : const Color(0xFF646464),
                    )),
                subtitle: Text(myMap[index]["notification"].toString(),
                    style: TextStyle(
                      fontSize: 18,
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
