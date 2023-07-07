import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:paurakhi/src/core/API/PrivacyPolicyAndTermsAndConditionsAPI/privacypolicy_termsandconditions.dart';
import 'package:paurakhi/src/core/extensions/colors_extension.dart';
import 'package:paurakhi/src/core/themes/appstyles.dart';

class PrivacyPolicyTermsAndConditions extends StatelessWidget {
  final bool isPolicy;
  const PrivacyPolicyTermsAndConditions({super.key, required this.isPolicy});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.black, //change your color here
        ),
        backgroundColor: Colors.transparent,
        title: isPolicy
            ? Text(
                "Privacy and Policy",
                style: AppStyles.text24PxMedium.black,
              )
            : Text(
                "Terms and Conditions",
                style: AppStyles.text24PxMedium.black,
              ),
      ),
      body: SingleChildScrollView(
        child: Html(
          shrinkWrap: true,
          data: isPolicy
              ? PrivacyPolicyTermsAndConditionsAPI.privacy
              : PrivacyPolicyTermsAndConditionsAPI.terms,
          style: {
            'body': Style(
              fontSize: FontSize.medium,
              fontWeight: FontWeight.normal,
            ),
          },
        ),
      ),
    );
  }
}
