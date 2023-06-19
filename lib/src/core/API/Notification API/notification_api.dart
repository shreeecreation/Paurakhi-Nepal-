import 'package:http/http.dart' as http;
import 'package:eventsource/eventsource.dart';
import 'package:paurakhi/src/core/API/AllAPIEndPoint/all_api_endpoint.dart';
import 'package:paurakhi/src/core/API/CookieManager/managecookie.dart';
import 'package:paurakhi/src/core/env/envmodels.dart';

class SSEManager {
  static List<String> notificationList = [];
  static Future<void> startListening() async {
    var cookie = await ManageCookie.getCookie();
    final headers = {'Cookie': cookie};

    while (true) {
      try {
        final eventSource = await EventSource.connect(
          Uri.parse("${Environment.apiUrl}/${AllAPIEndPoint.notificationAPI}"),
          headers: headers,
        );

        eventSource.asBroadcastStream().listen((Event event) {
          print("EventSource connection opened");
        });

        eventSource.onMessage.listen((Event event) {
          print("Start listening");
          final notification = event.data;

          // Add the notification to the list
          
          notificationList.add(notification ?? "abcd");

          print('New notification: $notification');
        });

        eventSource.onError.listen((Event event) {
          print('Error: $event');
        });

        await Future.delayed(const Duration(seconds: 5)); // Delay before reconnecting
      } catch (error) {
        print('Error occurred during the EventSource connection: $error');
        await Future.delayed(const Duration(seconds: 5)); // Delay before reconnecting
      }
    }
    // }
// static http.Client client = http.Client();
//   static void startListening()async {
//      print("Subscribing..");
//      var cookie = await ManageCookie.getCookie();
//     final headers = {'Cookie': cookie};

//   try {

//   var request = new http.Request("GET",
//           Uri.parse("${Environment.apiUrl}/${AllAPIEndPoint.notificationAPI}"),

//   );
//   request.headers["Cache-Control"] = "no-cache";
//   request.headers["Accept"] = "text/event-stream";

//   Future<http.StreamedResponse> response = client.send(request);

//   response.asStream().listen((streamedResponse) {
//     print("Received streamedResponse.statusCode:${streamedResponse.statusCode}");
//     streamedResponse.stream.listen((data) {
//       print("Received data:$data");
//     });

//   });
// } catch(e) {
//   print("Caught $e");
//   }
//   }
  }
}
