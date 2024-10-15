import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:immobarcide/models/contact_model.dart';

import '../../../constants.dart';
import '../../../controllers/contact_controller.dart';

class SixSection extends StatelessWidget {
  const SixSection({super.key});
//FirthSection
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ContactController());

    var _size = MediaQuery.of(context).size;
    return Container(
      padding: _size.width > 800
          ? EdgeInsets.symmetric(horizontal: 100, vertical: 20)
          : EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      //height: 200,
      width: _size.width,
      color: kLightBlueColor,
      child: FutureBuilder(
          future: controller.getContactData(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              ContactModel contact = snapshot.data as ContactModel;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  RichText(
                    text: TextSpan(
                      style: Theme.of(context).textTheme.headline3,
                      children: [
                        TextSpan(
                            text:
                                "Si vous avez des questions, veuillez appeler \n",
                            style:
                                const TextStyle(fontWeight: FontWeight.w300)),
                        TextSpan(
                            text: "${contact.phone!} \n",
                            style:
                                const TextStyle(fontWeight: FontWeight.w700)),
                        TextSpan(
                            text: "Ou écrivez-nous à \n",
                            style:
                                const TextStyle(fontWeight: FontWeight.w300)),
                        TextSpan(
                            text: "${contact.email!}",
                            style:
                                const TextStyle(fontWeight: FontWeight.w700)),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Divider(),
                  Container(
                    //padding: EdgeInsets.symmetric(horizontal: 100, vertical: 20),
                    child: Row(
                      children: [
                        SvgPicture.asset("assets/icons/logo.svg"),
                        Spacer(),
                        Socal(),
                      ],
                    ),
                  )
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

class Socal extends StatelessWidget {
  const Socal({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding / 2),
          child: SvgPicture.asset("assets/icons/facebookBottomBar.svg",
              color: kDarkBlueColor, height: 30),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding / 2),
          child: SvgPicture.asset("assets/icons/instagramBottomBar.svg",
              color: kDarkBlueColor, height: 25),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding / 2),
          child: SvgPicture.asset(
            "assets/icons/gmailBottomBar.svg",
            color: kDarkBlueColor,
            height: 30,
          ),
        ),
        /*SizedBox(width: kDefaultPadding),
        ElevatedButton(
          onPressed: () {},
          child: Text(
            "Contact us",
            style: Theme.of(context)
                .textTheme
                .headline6!
                .copyWith(color: Colors.white),
          ),
        ),*/
      ],
    );
  }
}
