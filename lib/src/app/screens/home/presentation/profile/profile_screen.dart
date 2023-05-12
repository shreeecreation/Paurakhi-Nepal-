import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paurakhi/src/app/screens/home/presentation/logout/logout.dart';
import 'package:paurakhi/src/core/routes/profileroutes.dart';
import 'package:paurakhi/src/core/themes/appstyles.dart';

import 'bloc/profile_bloc.dart';
import 'changepassword.dart';
import 'editprofile.dart';
import 'model/profile_model.dart';
import 'quotation/quotationhistory_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.center, children: [
            const SizedBox(height: 20),
            const Row(
              children: [
                SizedBox(width: 20),
                Text("My Profile", style: TextStyle(fontSize: 26, fontWeight: FontWeight.w500)),
              ],
            ),
            const SizedBox(height: 15),
            BlocBuilder<ProfileBloc, ProfileState>(
              builder: (context, state) {
                if (state is ProfileInitial) {
                  return userProfile(context);
                }
                return const CircularProgressIndicator();
              },
            ),
            const SizedBox(height: 20),
            openTicket(context),
            editProfile(context),
            changePassword(context),
            quotationhistory(context),
            financeenrquiry(context),
            notificationHistory(context),
            logOut(context)
          ]),
        ));
  }

  Padding openTicket(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: MediaQuery.of(context).size.width - 30,
        child: ListTile(
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
          tileColor: Colors.white,
          title: const Text("Open Ticket"),
          trailing: const Icon(Icons.keyboard_arrow_right_outlined, size: 30),
          onTap: () {
            ProfileRoutes.openticketRoute();
          },
        ),
      ),
    );
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
            editProfileDialog(context);
          },
        ),
      ),
    );
  }
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
          changepassword(context);
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
          ProfileRoutes.financeenquiryRoute();
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
          logoutDialog(context);
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("  ${Profile.firstName} ${Profile.lastName}", style: AppStyles.text20PxSemiBold),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Icon(Icons.location_on_outlined),
                    Text("${Profile.address}", style: AppStyles.text14Px),
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    const Icon(Icons.phone_outlined),
                    Text("${ProfileModel.phoneNumber}", style: AppStyles.text14Px),
                  ],
                ),
              ],
            ),
          ],
        ),
      ));
}
