import 'dart:async';
import 'package:flutter/material.dart';
import 'package:paurakhi/src/core/API/otp/otpconfirm.dart';

class CoutDownTimerManager {
  static var phoneNo = "";
  static bool isButtonDisabled = false;
  static StreamController<int>? _countdownController;
  static Stream<int>? countdownStream;

  static void startCountdown() {
    _countdownController = StreamController<int>();
    countdownStream = _countdownController!.stream;
    int countdownDuration = 60;
    Timer.periodic(const Duration(seconds: 1), (timer) {
      countdownDuration--;
      if (countdownDuration >= 0) {
        _countdownController!.add(countdownDuration);
      } else {
        timer.cancel();
        isButtonDisabled = false;
      }
    });
  }

  static Widget coutDownTimer() {
    startCountdown();

    return Center(
      child: StreamBuilder<int>(
        stream: countdownStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final remainingSeconds = snapshot.data!;
            isButtonDisabled = remainingSeconds > 0;
            return Row(
              children: [
                const SizedBox(width: 7),
                TextButton(
                  onPressed: isButtonDisabled
                      ? null
                      : () async {
                          if (!isButtonDisabled) {
                            isButtonDisabled = true;
                            await ConfirmOTP.resendOTP2FA(context);
                            startCountdown();
                          }
                        },
                  child: Text(isButtonDisabled ? 'Wait...' : 'Request Again'),
                ),
                Text(
                  '${remainingSeconds.toString()} seconds',
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

class CoutDownTimerManagerVerify {
  static var phoneNo = "";
  static bool isButtonDisabled = false;
  static StreamController<int>? _countdownController;
  static Stream<int>? countdownStream;

  static void startCountdown() {
    _countdownController = StreamController<int>();
    countdownStream = _countdownController!.stream;
    int countdownDuration = 5;
    Timer.periodic(const Duration(seconds: 1), (timer) {
      countdownDuration--;
      if (countdownDuration >= 0) {
        _countdownController!.add(countdownDuration);
      } else {
        timer.cancel();
        isButtonDisabled = false;
      }
    });
  }

  static Widget coutDownTimer() {
    startCountdown();

    return Center(
      child: StreamBuilder<int>(
        stream: countdownStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final remainingSeconds = snapshot.data!;
            isButtonDisabled = remainingSeconds > 0;
            return Row(
              children: [
                const SizedBox(width: 7),
                TextButton(
                  onPressed: isButtonDisabled
                      ? null
                      : () async {
                          if (!isButtonDisabled) {
                            isButtonDisabled = true;
                            await ConfirmOTP.verifyAccountResendOtp(context);
                            startCountdown();
                          }
                        },
                  child: Text(isButtonDisabled ? 'Wait...' : 'Request Again'),
                ),
                Text(
                  '${remainingSeconds.toString()} seconds',
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
