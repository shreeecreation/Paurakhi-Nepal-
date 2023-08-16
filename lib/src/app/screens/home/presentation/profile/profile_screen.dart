import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:paurakhi/src/app/screens/home/presentation/history/Finance%20Query%20History/financequery_history.dart';
import 'package:paurakhi/src/app/screens/home/presentation/history/Grant%20History/getgrant_screen.dart';
import 'package:paurakhi/src/app/screens/home/presentation/history/ProductHistory/product_history.dart';
import 'package:paurakhi/src/app/screens/home/presentation/history/Quotation%20Hisotry/quotation_history_screen.dart';
import 'package:paurakhi/src/app/screens/home/presentation/history/get%20ticket/getticket_screen.dart';
import 'package:paurakhi/src/app/screens/home/presentation/logout/logout.dart';
import 'package:paurakhi/src/app/screens/home/presentation/request/request_screen.dart';
import 'package:paurakhi/src/core/API/login/isverify.dart';
import 'package:paurakhi/src/core/API/otp/otpconfirm.dart';
import 'package:paurakhi/src/core/API/userIfno/getuserinfo.dart';
import 'package:paurakhi/src/core/dialogs/auth/alldialogs.dart';
import 'package:paurakhi/src/core/env/envmodels.dart';
import 'package:paurakhi/src/core/providers/language_provider.dart';
import 'package:paurakhi/src/core/providers/location_provider.dart';
import 'package:paurakhi/src/core/routes/authroutes.dart';
import 'package:paurakhi/src/core/routes/profileroutes.dart';
import 'package:paurakhi/src/core/themes/appstyles.dart';
import 'package:provider/provider.dart';
import 'package:sliding_switch/sliding_switch.dart';
import 'bloc/profile_bloc.dart';
import 'changepassword.dart';
import 'editprofile.dart';
import 'model/profile_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () {
        GetUserInfo.getUserInfo();
        return Future.delayed(
          const Duration(
            milliseconds: 1500,
          ),
          () {
            BlocProvider.of<ProfileBloc>(context).add(ProfileLoading());
          },
        );
      },
      child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 60),

                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const SizedBox(width: 20),
                            Text(AppLocalizations.of(context)!.profile,
                                style: const TextStyle(
                                    fontSize: 26, fontWeight: FontWeight.w500)),
                          ],
                        ),
                        Row(
                          children: [
                            FutureBuilder<String>(
                              future: LocalizationManager.getCurrentLocale(),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  final String currentLocale = snapshot.data!;
                                  final bool isNepali = currentLocale == 'ne';
                                  return SlidingSwitch(
                                      value: isNepali,
                                      width: 80,
                                      onChanged: (bool value) async {
                                        Locale en = const Locale("en");
                                        Locale ne = const Locale("ne");
                                        if (value) {
                                          await LocalizationManager
                                              .setCurrentLocale(ne);
                                          WidgetsBinding.instance
                                              .addPostFrameCallback((_) {
                                            LoginDialogs.changeLangauge(
                                                context);
                                          });
                                        } else {
                                          await LocalizationManager
                                              .setCurrentLocale(en);
                                          WidgetsBinding.instance
                                              .addPostFrameCallback((_) {
                                            LoginDialogs.changeLangauge(
                                                context);
                                          });
                                        }
                                      },
                                      height: 40,
                                      animationDuration:
                                          const Duration(milliseconds: 200),
                                      onTap: () {},
                                      onDoubleTap: () {},
                                      onSwipe: () {},
                                      textOff: "EN",
                                      textOn: "NE",
                                      contentSize: 15,
                                      colorOn: const Color(0xffdc6c73),
                                      colorOff: const Color(0xff6682c0),
                                      background: const Color(0xffe4e5eb),
                                      buttonColor: const Color(0xfff7f5f7),
                                      inactiveColor: const Color(0xff636f7b));
                                } else {
                                  // Handle loading state
                                  return const CircularProgressIndicator();
                                }
                              },
                            ),
                            const SizedBox(width: 30),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15),
                  BlocBuilder<ProfileBloc, ProfileState>(
                    builder: (context, state) {
                      if (state is ProfileInitial) {
                        GetUserInfo.getUserInfo();

                        return Center(child: userProfile(context));
                      }

                      if (state is ProfileLoadedState) {
                        GetUserInfo.getUserInfo();

                        return Center(child: userProfile(context));
                      }
                      return const CircularProgressIndicator();
                    },
                  ),
                  const SizedBox(height: 20),
                  Text(
                      "       ${AppLocalizations.of(context)!.profile_settings}",
                      style: AppStyles.text18PxBold),
                  const SizedBox(height: 10),
                  editProfile(context),
                  changePassword(context),
                  isVerified(context),
                  openTicket(context),
                  const SizedBox(height: 10),
                  Text("     History", style: AppStyles.text18PxBold),
                  const SizedBox(height: 10),
                  productHistory(context),
                  quotationhistory(context),
                  financeenrquiry(context),
                  openTicketHistory(context),
                  grantHistory(context),
                  const SizedBox(height: 10),
                  Text("     Others", style: AppStyles.text18PxBold),
                  const SizedBox(height: 10),
                  logOut(context),
                  const SizedBox(height: 60),
                ]),
          )),
    );
  }

  Padding openTicket(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: MediaQuery.of(context).size.width - 30,
        child: ListTile(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12))),
          tileColor: Colors.white,
          title: Text(AppLocalizations.of(context)!.openticket),
          trailing: const Icon(Icons.keyboard_arrow_right_outlined, size: 30),
          onTap: () {
            ProfileRoutes.openticketRoute();
          },
        ),
      ),
    );
  }

  Widget addGrant(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: MediaQuery.of(context).size.width - 30,
        child: ListTile(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12))),
          tileColor: Colors.white,
          title: const Text("Add Grant"),
          trailing: const Icon(Icons.keyboard_arrow_right_outlined, size: 30),
          onTap: () {
            ProfileRoutes.addGrantRoute();
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
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12))),
          tileColor: Colors.white,
          title: Text(AppLocalizations.of(context)!.edit_profile),
          trailing: const Icon(Icons.keyboard_arrow_right_outlined, size: 30),
          onTap: () async {
            Provider.of<LocationProvider>(context, listen: false)
                .changeLocation(context);
            editProfileDialog(context);
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
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12))),
        tileColor: Colors.white,
        title: Text(AppLocalizations.of(context)!.change_password),
        trailing: const Icon(Icons.keyboard_arrow_right_outlined, size: 30),
        onTap: () {
          changepassword(context);
        },
      ),
    ),
  );
}

Padding productHistory(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: SizedBox(
      width: MediaQuery.of(context).size.width - 30,
      child: ListTile(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12))),
        tileColor: Colors.white,
        title: Text(AppLocalizations.of(context)!.product_history),
        trailing: const Icon(Icons.keyboard_arrow_right_outlined, size: 30),
        onTap: () {
          Get.find<ProductHistoryController>().loadProductHistory();
          productHistoryScreen(context);
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
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12))),
        tileColor: Colors.white,
        title: Text(AppLocalizations.of(context)!.quotation_history),
        trailing: const Icon(Icons.keyboard_arrow_right_outlined, size: 30),
        onTap: () {
          Get.find<QuotationHistoryController>().loadQuotationHistory();
          quotationHistoryScreen(context);
        },
      ),
    ),
  );
}

Padding openTicketHistory(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: SizedBox(
      width: MediaQuery.of(context).size.width - 30,
      child: ListTile(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12))),
        tileColor: Colors.white,
        title: Text(AppLocalizations.of(context)!.ticket_history),
        trailing: const Icon(Icons.keyboard_arrow_right_outlined, size: 30),
        onTap: () {
          Get.find<TicketHistoryController>().loadTicketHistory();
          ticketHistoryScreen(context);
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
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12))),
        tileColor: Colors.white,
        title: Text(AppLocalizations.of(context)!.finance_history),
        trailing: const Icon(Icons.keyboard_arrow_right_outlined, size: 30),
        onTap: () {
          Get.find<FinanceQueryHistoryController>().loadFinanceHistory();

          financeHistoryScreen(context);
        },
      ),
    ),
  );
}

Padding grantHistory(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: SizedBox(
      width: MediaQuery.of(context).size.width - 30,
      child: ListTile(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12))),
        tileColor: Colors.white,
        title: Text(AppLocalizations.of(context)!.grant_history),
        trailing: const Icon(Icons.keyboard_arrow_right_outlined, size: 30),
        onTap: () {
          Get.find<GrantHistoryController>().fetchQuotationHistory();
          getGrantScreen(context);
        },
      ),
    ),
  );
}

Padding isVerified(BuildContext context) {
  bool a = IsVerify.isVerify;
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: SizedBox(
      width: MediaQuery.of(context).size.width - 30,
      child: ListTile(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12))),
        tileColor: Colors.white,
        title: !a
            ? Text(AppLocalizations.of(context)!.verify_your_account)
            : Text(AppLocalizations.of(context)!.verified),
        trailing: !a
            ? const Icon(Icons.check_circle_rounded,
                size: 30, color: Colors.grey)
            : const Icon(Icons.check_circle_rounded,
                size: 30, color: Colors.green),
        onTap: !a
            ? () async {
                await ConfirmOTP.verifyAccount(context);
                AuthRoutes.otpRoute(true);
              }
            : null,
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
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12))),
        tileColor: Colors.white,
        title: Text(AppLocalizations.of(context)!.logout),
        trailing: const Icon(Icons.keyboard_arrow_right_outlined, size: 30),
        onTap: () {
          logoutDialog(context);
        },
      ),
    ),
  );
}

Widget userProfile(context) {
  var displayName = " ${Profile.firstName} ${Profile.lastName}";
  var textStyle = AppStyles.text20PxSemiBold;
  if (displayName.length > 20) {
    displayName = "${displayName.substring(0, 17)}...";
    textStyle = AppStyles.text16PxMedium;
  }

  var profileImage = Profile.picture == ""
      ? Image.asset("assets/images/defaultImage.png").image
      : Image.network(
          "${Environment.apiUrl}/public/images/${Profile.picture}",
          fit: BoxFit.fill,
        ).image;
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
            GestureDetector(
              onTap: () {
                if (Profile.picture == "") {
                  requestBottomSheetEditProfile(
                      context, "assets/images/logo2.png", false);
                } else {
                  requestBottomSheetEditProfile(
                      context,
                      "${Environment.apiUrl}/public/images/${Profile.picture}",
                      true);
                }
              },
              child: SizedBox(
                  height: 90,
                  width: 90,
                  child:
                      CircleAvatar(radius: 80, backgroundImage: profileImage)),
            ),
            const SizedBox(width: 30),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(displayName, style: textStyle),
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
                    Text("${ProfileModel.phoneNumber}",
                        style: AppStyles.text14Px),
                  ],
                ),
              ],
            ),
          ],
        ),
      ));
}
