import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../constants.dart';
import '../../../controllers/authentification_controller.dart';
import '../../../models/user_model.dart';

class SettingSection extends StatefulWidget {
  const SettingSection({
    super.key,
  });

  @override
  State<SettingSection> createState() => _SettingSectionState();
}

class _SettingSectionState extends State<SettingSection> {
  GlobalKey<FormState> formkeySetting = GlobalKey<FormState>();
  final controller = Get.put(AuthentificationController());

  @override
  Widget build(BuildContext context) {
    var _size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Container(
        margin: _size.width > 430 ? EdgeInsets.all(20) : EdgeInsets.all(5),
        child: FutureBuilder(
            future: controller.getUserDetailsController(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                UserModel user = snapshot.data as UserModel;
                final email = TextEditingController(text: user.email);
                final fullName = TextEditingController(text: user.fullName);
                final phoneNum = TextEditingController(text: user.phoneNum);
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Paramètres",
                      style: Theme.of(context).textTheme.headline2,
                      textAlign: TextAlign.start,
                    ),
                    SizedBox(height: 10),
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
                          SizedBox(
                            width: 120,
                            height: 120,
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: const Image(
                                    image: AssetImage(
                                        "assets/images/profile_pic.png"))),
                          ),
                          SizedBox(height: 10),
                          Text(
                            user.fullName,
                            style: Theme.of(context).textTheme.headline3,
                            textAlign: TextAlign.start,
                          ),
                          SizedBox(height: 5),
                          Text(
                            user.email!,
                            style: Theme.of(context).textTheme.headline4,
                            textAlign: TextAlign.start,
                          ),
                          SizedBox(height: 20),
                          Form(
                            key: formkeySetting,
                            child: ListView(
                              shrinkWrap: true,
                              children: [
                                /* TextFormField(
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  controller: email,
                                  maxLines: 1,
                                  decoration: InputDecoration(
                                      prefixIcon:
                                          Icon(Icons.alternate_email_rounded),
                                      hintText: "Enter Email",
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
                                SizedBox(height: 20),*/
                                TextFormField(
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  controller: fullName,
                                  maxLines: 1,
                                  decoration: InputDecoration(
                                      prefixIcon: Icon(Icons.person_outline),
                                      hintText: "Saisir Nom",
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20))),
                                  validator: MultiValidator(
                                    [
                                      RequiredValidator(
                                          errorText: "* Obligatoire"),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 20),
                                TextFormField(
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  controller: phoneNum,
                                  maxLines: 1,
                                  decoration: InputDecoration(
                                      prefixIcon:
                                          Icon(Icons.local_phone_rounded),
                                      hintText: "Saisir N° Télephone",
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20))),
                                  validator: MultiValidator(
                                    [
                                      RequiredValidator(
                                          errorText: "* Obligatoire"),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 20),
                                Container(
                                  width: 200,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      if (formkeySetting.currentState!
                                          .validate()) {
                                        final userM = UserModel(
                                          id: user.id,
                                          fullName: fullName.text.trim(),
                                          phoneNum: phoneNum.text.trim(),
                                        );
                                        controller.updateUserController(userM);
                                      }
                                    },
                                    child: Text(
                                      "Modifier",
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
