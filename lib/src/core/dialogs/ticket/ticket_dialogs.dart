import 'package:flutter/material.dart';

import 'package:paurakhi/src/core/themes/appstyles.dart';
import 'package:paurakhi/src/core/utils/focuesnode.dart';

class OpenTicketDialogs {
  static void successCreateTicket(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          content: SizedBox(
            height: 250.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Icon(Icons.info_outline, color: Colors.green, size: 50),
                const SizedBox(height: 15),
                SizedBox(
                    width: 220,
                    child: Center(child: Text('Created Ticket Successfully !', textAlign: TextAlign.center, style: AppStyles.text16PxSemiBold))),
                const SizedBox(height: 10),
                SizedBox(
                    width: 220,
                    child: Center(
                        child: Text('Visit Ticket History to see your tickets', textAlign: TextAlign.center, style: AppStyles.text14PxSemiBold))),
                const SizedBox(height: 10),
                SizedBox(
                  height: 40,
                  width: MediaQuery.of(context).size.width / 1.5,
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.pop(context);
                        unFocusNode(context);
                      },
                      style: ElevatedButton.styleFrom(
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10), side: const BorderSide(color: Colors.green, width: 1.5)),
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.green),
                      child: const Text('Ok')),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
