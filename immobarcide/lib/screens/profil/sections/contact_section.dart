import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../constants.dart';
import '../../../controllers/contact_controller.dart';
import '../../../models/contact_model.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var _size = MediaQuery.of(context).size;
    final controller = Get.put(ContactController());

    return Container(
      margin: _size.width > 430 ? EdgeInsets.all(20) : EdgeInsets.all(5),
      child: SingleChildScrollView(
        child: FutureBuilder(
            future: controller.getContactData(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                ContactModel contact = snapshot.data as ContactModel;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Contactez-nous",
                      style: Theme.of(context).textTheme.headline2,
                      textAlign: TextAlign.start,
                    ),
                    SizedBox(height: 10),
                    Container(
                      alignment: Alignment.center,
                      margin: _size.width > 750
                          ? EdgeInsets.all(120)
                          : EdgeInsets.all(5),
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: kWhiteColor,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.shade500,
                              offset: Offset(4.0, 4.0),
                              blurRadius: 15,
                              spreadRadius: 1),
                          BoxShadow(
                              color: Colors.white,
                              offset: Offset(-4.0, -4.0),
                              blurRadius: 15,
                              spreadRadius: 1),
                        ],
                      ),
                      width: double.infinity,
                      //height: 350,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(Icons.map_outlined, size: 40),
                              SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  contact.adress!,
                                  style: _size.width > 550
                                      ? Theme.of(context).textTheme.headline3
                                      : Theme.of(context).textTheme.headline4,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(Icons.alternate_email_rounded, size: 40),
                              SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  contact.email!,
                                  style: _size.width > 550
                                      ? Theme.of(context).textTheme.headline3
                                      : Theme.of(context).textTheme.headline4,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(Icons.local_phone_rounded, size: 40),
                              SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  contact.phone!,
                                  style: _size.width > 550
                                      ? Theme.of(context).textTheme.headline3
                                      : Theme.of(context).textTheme.headline4,
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
                                width: 40,
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  contact.facebook!,
                                  style: _size.width > 550
                                      ? Theme.of(context).textTheme.headline3
                                      : Theme.of(context).textTheme.headline4,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SvgPicture.asset(
                                "assets/icons/instagram.svg",
                                width: 40,
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  contact.instagram!,
                                  style: _size.width > 550
                                      ? Theme.of(context).textTheme.headline3
                                      : Theme.of(context).textTheme.headline4,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              } else if (snapshot.hasError) {
                return Center(child: Text(snapshot.error.toString()));
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            }),
      ),
    );
  }
}
