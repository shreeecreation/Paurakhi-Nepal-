import 'package:flutter/material.dart';
import 'package:paurakhi/src/core/themes/appstyles.dart';

import 'quotation/quotation_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.center, children: [
            const SizedBox(height: 20),
            Row(
              children: [
                IconButton(onPressed: () {}, icon: const Icon(Icons.arrow_back)),
                const SizedBox(width: 15),
                const Text("My Profile", style: TextStyle(fontSize: 26, fontWeight: FontWeight.w500)),
              ],
            ),
            const SizedBox(height: 15),
            userProfile(context),
            const SizedBox(height: 20),
            editProfile(context),
            changePassword(context),
            quotationhistory(context),
            financeenrquiry(context),
            notificationHistory(context),
            logOut(context)
          ]),
        ));
  }

  Padding editProfile(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: MediaQuery.of(context).size.width - 30,
        child: ListTile(
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
          tileColor: Colors.white,
          title: const Text("Edit Profile"),
          trailing: const Icon(Icons.keyboard_arrow_right_outlined, size: 30),
          onTap: () {
            quotationBottomSheet(context);
          },
        ),
      ),
    );
  }
}

Padding changePassword(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: SizedBox(
      width: MediaQuery.of(context).size.width - 30,
      child: ListTile(
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
        tileColor: Colors.white,
        title: const Text("Change Password"),
        trailing: const Icon(Icons.keyboard_arrow_right_outlined, size: 30),
        onTap: () {
          quotationBottomSheet(context);
        },
      ),
    ),
  );
}

Padding quotationhistory(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: SizedBox(
      width: MediaQuery.of(context).size.width - 30,
      child: ListTile(
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
        tileColor: Colors.white,
        title: const Text("Quotation History"),
        trailing: const Icon(Icons.keyboard_arrow_right_outlined, size: 30),
        onTap: () {
          quotationBottomSheet(context);
        },
      ),
    ),
  );
}

Padding financeenrquiry(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: SizedBox(
      width: MediaQuery.of(context).size.width - 30,
      child: ListTile(
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
        tileColor: Colors.white,
        title: const Text("Finance Enquiry History"),
        trailing: const Icon(Icons.keyboard_arrow_right_outlined, size: 30),
        onTap: () {
          quotationBottomSheet(context);
        },
      ),
    ),
  );
}

Padding notificationHistory(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: SizedBox(
      width: MediaQuery.of(context).size.width - 30,
      child: ListTile(
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
        tileColor: Colors.white,
        title: const Text("Notification History"),
        trailing: const Icon(Icons.keyboard_arrow_right_outlined, size: 30),
        onTap: () {
          quotationBottomSheet(context);
        },
      ),
    ),
  );
}

Padding logOut(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: SizedBox(
      width: MediaQuery.of(context).size.width - 30,
      child: ListTile(
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
        tileColor: Colors.white,
        title: const Text("Log Out"),
        trailing: const Icon(Icons.keyboard_arrow_right_outlined, size: 30),
        onTap: () {
          quotationBottomSheet(context);
        },
      ),
    ),
  );
}

Widget userProfile(context) {
  return SizedBox(
      height: 150,
      width: MediaQuery.of(context).size.width - 40,
      child: Card(
        elevation: 0.1,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
          Radius.circular(12),
        )),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 90, width: 90, child: CircleAvatar(child: Image.asset("assets/images/nepalflag.png"))),
            const SizedBox(width: 30),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text("Birendra Bikram ", style: AppStyles.text20PxSemiBold),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Icon(Icons.local_activity),
                    Text("Jukot, Bajura", style: AppStyles.text14Px),
                  ],
                ),
                Text("+977 98104200", style: AppStyles.text14Px),
              ],
            ),
          ],
        ),
      ));
}
