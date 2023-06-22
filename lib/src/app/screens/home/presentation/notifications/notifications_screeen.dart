import 'package:flutter/material.dart';
import 'package:paurakhi/src/core/API/Notification%20API/get_time_ago.dart';
import 'package:paurakhi/src/core/API/Notification%20API/model/notification_model.dart';
import 'package:paurakhi/src/core/API/Notification%20API/notification_api.dart';
import 'package:paurakhi/src/core/themes/appstyles.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final List<NotificationModel> _notifications = [];
  int _currentPage = 1;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadNotifications();
  }

  Future<void> _loadNotifications() async {
    setState(() {
      _isLoading = true;
    });

    try {
      List<NotificationModel> newNotifications = await GetNotificationAPI.getNotification(_currentPage);
      setState(() {
        _notifications.addAll(newNotifications);
        _currentPage++;
      });
    } catch (e) {
      print('Error fetching notifications: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              const SizedBox(height: 20),
              const Row(
                children: [SizedBox(width: 20), Text("Notification", style: TextStyle(fontSize: 27, fontWeight: FontWeight.w500))],
              ),
              const SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  itemCount: _notifications.length + 1,
                  itemBuilder: (context, index) {
                    if (index == _notifications.length) {
                      if (_isLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else {
                        return GestureDetector(
                          onTap: _loadNotifications,
                          child: const Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Text(
                              'Load More',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue,
                              ),
                            ),
                          ),
                        );
                      }
                    } else {
                      NotificationModel notification = _notifications[index];
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: const Color(0xFFECECEC)),
                            height: 119,
                            width: MediaQuery.of(context).size.width - 30,
                            child: Center(
                              child: ListTile(
                                leading: const Icon(Icons.notifications_active, color: Colors.green),
                                minVerticalPadding: 10,
                                title: SizedBox(
                                  height: 30,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(notification.type,
                                          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: Color.fromARGB(255, 0, 0, 0))),
                                    ],
                                  ),
                                ),
                                trailing: Text(getTimeAgo(notification.createdAt), style: AppStyles.text12Px),
                                subtitle: Text(notification.message, style: const TextStyle(fontSize: 16, color: Color(0xFF646464))),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                        ],
                      );
                    }
                  },
                ),
              ),
              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
      resizeToAvoidBottomInset: false,
    );
  }
}
