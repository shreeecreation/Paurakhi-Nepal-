import 'package:flutter/material.dart';
import 'package:paurakhi/src/core/routes/authroutes.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ChooseGooleAccountScreen extends StatelessWidget {
  final String authUrl;

  ChooseGooleAccountScreen({Key? key, required this.authUrl}) : super(key: key);

  var webViewController = WebViewController()
    ..canGoBack()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..setBackgroundColor(const Color.fromARGB(255, 255, 255, 255))
    ..setNavigationDelegate(
      NavigationDelegate(
        onProgress: (int progress) {},
        onPageStarted: (String url) {},
        onPageFinished: (String url) {
          // AuthRoutes.googleAuthFieldRoute();
        },
        onWebResourceError: (WebResourceError error) {
          // print(error);
        },
        onUrlChange: (change) {
          var url = change.url;
          var first54Characters = url!.substring(0, 51);
          if (first54Characters ==
              "http://paurakhi.dripiz.com/auth/user/callback?code=") {
            AuthRoutes.googleAuthFieldRoute();
          } else {}
        },
        onNavigationRequest: (NavigationRequest request) {
          return NavigationDecision.navigate;
        },
      ),
    );

  @override
  Widget build(BuildContext context) {
    webViewController.setUserAgent(
        'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.82 Mobile Safari/537.36');
    return Scaffold(
        appBar: AppBar(toolbarHeight: 0),
        body: WebViewWidget(
            controller: webViewController..loadRequest(Uri.parse(authUrl))));
  }
}
