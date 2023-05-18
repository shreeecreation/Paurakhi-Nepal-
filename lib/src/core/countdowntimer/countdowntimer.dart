import 'package:flutter/material.dart';
import 'package:paurakhi/src/core/API/ForgotPasswordAPI/forgot_password_api.dart';

class CoutDownTimerManager {
  static var phoneNo = "";
  static Widget coutDownTimer() {
    int countdownDuration = 60;
    final Stream<int> countdownStream = Stream<int>.periodic(const Duration(seconds: 1), (count) => count + 1).takeWhile((count) => count <= 60);
    return Center(
      child: StreamBuilder<int>(
        stream: countdownStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final remainingSeconds = countdownDuration - snapshot.data!;
            final isButtonDisabled = remainingSeconds > 0;
            return Row(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(width: 7),
                TextButton(
                  onPressed: isButtonDisabled
                      ? null
                      : () async {
                          countdownDuration = 60;
                          await ForgotPasswordAPI.verifyNumberForgot(phoneNo, context);
                        },
                  child: Text(isButtonDisabled ? 'Wait...' : 'Request Again'),
                ),
                Text(
                  '${remainingSeconds.toString()} seconds ',
                  style: const TextStyle(fontSize: 14.0),
                ),
              ],
            );
          } else {
            return const Text('Loading...');
          }
        },
      ),
    );
  }
}
