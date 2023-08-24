import 'package:flutter/material.dart';
import 'package:paurakhi/src/core/themes/appstyles.dart';
import 'package:restart_app/restart_app.dart';

class NoInternetConnectionPage extends StatelessWidget {
  const NoInternetConnectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/nointernet.jpg",
              height: MediaQuery.of(context).size.height / 3,
            ),
            const SizedBox(height: 20),
            Text(
              "Oops! \n No Internet Connection",
              style: AppStyles.text18PxMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            SizedBox(
                height: 45,
                width: MediaQuery.of(context).size.width / 1.5,
                child: ElevatedButton(
                    onPressed: () async {
                      Restart.restartApp();
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF34A853),
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10)))),
                    child:
                        Text("Try Again", style: AppStyles.text16PxSemiBold)))
          ]),
    ));
  }
}
