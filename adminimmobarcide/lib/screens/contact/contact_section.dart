import 'package:adminimmobarcide/controllers/contact_controller.dart';
import 'package:adminimmobarcide/models/contact_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';

import '../../constants.dart';

class ContactSection extends StatefulWidget {
  const ContactSection({super.key});

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection> {
  GlobalKey<FormState> formkeySetting = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var _size = MediaQuery.of(context).size;
    final controller = Get.put(ContactController());

    return Container(
      height: _size.width < 850 ? _size.height - 108 : null,
      margin: _size.width > 600
          ? EdgeInsets.symmetric(horizontal: 10)
          : EdgeInsets.symmetric(horizontal: 20),
      child: SingleChildScrollView(
        child: FutureBuilder(
            future: controller.getContactData(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                ContactModel contact = snapshot.data as ContactModel;
                final adress = TextEditingController(text: contact.adress);
                final email = TextEditingController(text: contact.email);
                final phone = TextEditingController(text: contact.phone);
                final facebook = TextEditingController(text: contact.facebook);
                final instagram =
                    TextEditingController(text: contact.instagram);
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Contact",
                      style: Theme.of(context).textTheme.headline2,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 20),
                    Container(
                      margin: _size.width > 750
                          ? EdgeInsets.all(20)
                          : EdgeInsets.all(5),
                      padding: _size.width > 750
                          ? EdgeInsets.symmetric(vertical: 50, horizontal: 100)
                          : EdgeInsets.all(20),
                      width: double.infinity,
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Form(
                            key: formkeySetting,
                            child: ListView(
                              shrinkWrap: true,
                              children: [
                                TextFormField(
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  controller: adress,
                                  maxLines: 1,
                                  decoration: InputDecoration(
                                      prefixIcon:
                                          Icon(Icons.location_on_outlined),
                                      hintText: "Enter Addess",
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20))),
                                ),
                                SizedBox(height: 20),
                                TextFormField(
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  controller: email,
                                  maxLines: 1,
                                  decoration: InputDecoration(
                                      prefixIcon:
                                          Icon(Icons.alternate_email_rounded),
                                      hintText: "Enter email",
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20))),
                                  validator: MultiValidator(
                                    [
                                      RequiredValidator(
                                          errorText: "* Required"),
                                      EmailValidator(
                                          errorText: "Enter valid email "),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 20),
                                TextFormField(
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  controller: phone,
                                  maxLines: 1,
                                  decoration: InputDecoration(
                                      prefixIcon:
                                          Icon(Icons.local_phone_rounded),
                                      hintText: "Enter phone",
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20))),
                                  validator: MultiValidator(
                                    [
                                      RequiredValidator(
                                          errorText: "* Required"),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 20),
                                TextFormField(
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  controller: facebook,
                                  maxLines: 1,
                                  decoration: InputDecoration(
                                      prefixIcon: Icon(Icons.facebook),
                                      hintText: "Enter facebook",
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20))),
                                  validator: MultiValidator(
                                    [
                                      RequiredValidator(
                                          errorText: "* Required"),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 20),
                                TextFormField(
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  controller: instagram,
                                  maxLines: 1,
                                  decoration: InputDecoration(
                                      prefixIcon: Container(
                                        padding: EdgeInsets.all(8),
                                        height: 2,
                                        child: SvgPicture.asset(
                                          "assets/icons/instagram2.svg",
                                        ),
                                      ),
                                      hintText: "Enter instagram",
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20))),
                                  validator: MultiValidator(
                                    [
                                      RequiredValidator(
                                          errorText: "* Required"),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 20),
                                Container(
                                  width: 200,
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      if (formkeySetting.currentState!
                                          .validate()) {
                                        final contact = ContactModel(
                                          adress: adress.text.trim(),
                                          email: email.text.trim(),
                                          phone: phone.text.trim(),
                                          facebook: facebook.text.trim(),
                                          instagram: instagram.text.trim(),
                                        );
                                        controller.updateRecord(contact);
                                      }
                                    },
                                    child: Text(
                                      "Edit Contact",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline4!
                                          .copyWith(
                                              color: kWhiteColor,
                                              fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              } else if (snapshot.hasError) {
                return Center(child: Text(snapshot.error.toString()));
              } else {
                // Center(child: Text("Something went wrong"));
                return const Center(child: CircularProgressIndicator());
              }
            }),
      ),
    );
  }
}
