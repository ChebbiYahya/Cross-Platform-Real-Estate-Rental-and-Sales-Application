import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../constants.dart';
import '../../../controllers/contact_controller.dart';
import '../../../models/contact_model.dart';

class ContactWidget extends StatelessWidget {
  const ContactWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ContactController());

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: kLightBlueColor, borderRadius: BorderRadius.circular(10)),
      child: FutureBuilder(
          future: controller.getContactData(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              ContactModel contact = snapshot.data as ContactModel;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Contacter L'équipe",
                    style: Theme.of(context)
                        .textTheme
                        .headline4!
                        .copyWith(fontWeight: FontWeight.w800, fontSize: 18),
                    textAlign: TextAlign.start,
                  ),
                  Divider(thickness: 2),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(Icons.map_outlined, size: 30),
                      SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          contact.adress!,
                          style: Theme.of(context).textTheme.headline5,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(Icons.alternate_email_rounded, size: 30),
                      SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          contact.email!,
                          style: Theme.of(context).textTheme.headline5,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(Icons.local_phone_rounded, size: 30),
                      SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          contact.phone!,
                          style: Theme.of(context).textTheme.headline5,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SvgPicture.asset(
                        "assets/icons/facebook.svg",
                        width: 30,
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Text(contact.facebook!,
                            style: Theme.of(context).textTheme.headline5),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SvgPicture.asset(
                        "assets/icons/instagram.svg",
                        width: 30,
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          contact.instagram!,
                          style: Theme.of(context).textTheme.headline5,
                        ),
                      ),
                    ],
                  ),
                ],
              );
            } else if (snapshot.hasError) {
              return Center(child: Text(snapshot.error.toString()));
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}
