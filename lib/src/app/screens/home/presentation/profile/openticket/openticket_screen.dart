import 'package:flutter/material.dart';
import 'package:paurakhi/src/app/screens/auth/login/validators/validators.dart';
import 'package:paurakhi/src/app/screens/home/presentation/profile/model/profile_model.dart';
import 'package:paurakhi/src/core/API/OpenTicket%20API/openticket_api.dart';
import 'package:paurakhi/src/core/extensions/colors_extension.dart';
import 'package:paurakhi/src/core/themes/appstyles.dart';

class OpenTicket extends StatelessWidget {
  OpenTicket({super.key});
  GlobalKey<FormState> ticketKey = GlobalKey<FormState>();

  final TextEditingController subjectController = TextEditingController();
  final TextEditingController messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(
            color: Colors.black, //change your color here
          ),
          title: Text("Open Ticket", style: AppStyles.text20PxSemiBold.black),
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Form(
            key: ticketKey,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  userName(context, Profile.finalName),
                  email(context, Profile.email),
                  subject(context, subjectController),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width - 30,
                      child: TextFormField(
                          controller: messageController,
                          maxLines: 8,
                          validator: (value) {
                            if (!ExtString.validateNormalName(value!)) return "Message can't be less than 5 ";
                            return null;
                          },
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: const Color(0xFFFFFFFF),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              ),
                              hintText: 'Message')),
                    ),
                  ),
                  Center(
                    child: SizedBox(
                        height: 50,
                        width: MediaQuery.of(context).size.width - 50,
                        child: ElevatedButton(
                            onPressed: () {
                              if (ticketKey.currentState!.validate()) {
                                OpenTickets.openTicket(messageController.text, subjectController.text, context);
                              }
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF34A853),
                                shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15)))),
                            child: Text("Submit", style: AppStyles.text16Px))),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}

Padding userName(BuildContext context, name) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: SizedBox(
      width: MediaQuery.of(context).size.width - 30,
      child: TextField(
          readOnly: true,
          decoration: InputDecoration(
              filled: true,
              fillColor: const Color(0xFFFFFFFF),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
              hintText: '$name')),
    ),
  );
}

Padding email(BuildContext context, email) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: SizedBox(
      width: MediaQuery.of(context).size.width - 30,
      child: TextField(
          readOnly: true,
          decoration: InputDecoration(
              filled: true,
              fillColor: const Color(0xFFFFFFFF),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
              hintText: '$email')),
    ),
  );
}

Padding subject(BuildContext context, controller) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: SizedBox(
      width: MediaQuery.of(context).size.width - 30,
      child: TextFormField(
          validator: (value) {
            if (!ExtString.validateNormalName(value!)) return "Subject can't be less than 5 ";
            return null;
          },
          controller: controller,
          decoration: InputDecoration(
              filled: true,
              fillColor: const Color(0xFFFFFFFF),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
              hintText: 'Add Subject ')),
    ),
  );
}
