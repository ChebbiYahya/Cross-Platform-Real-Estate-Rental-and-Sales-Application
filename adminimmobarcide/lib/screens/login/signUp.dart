import 'package:adminimmobarcide/screens/login/signIn.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import '../../constants.dart';
import '../../controllers/authentification_controller.dart';
import '../../models/user_model.dart';
import '../whole_profil_page.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool isVisible = true;
  TextEditingController _nameController = new TextEditingController();
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passController = new TextEditingController();
  GlobalKey<FormState> formkeySignUp = GlobalKey<FormState>();
  void _updatePasswordVisibility() {
    setState(() {
      isVisible = !isVisible;
    });
  }

  bool satusSignUp = false;

  final controller = Get.put(AuthentificationController());

  @override
  Widget build(BuildContext context) {
    var _size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              "assets/icons/logo.svg",
              width: 35,
            ),
            Text("Immobarcide", style: Theme.of(context).textTheme.headline4),
          ],
        ),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _size.width > 800
                ? SignUpWeb(_size, context)
                : SignUpMobile(_size, context),
          ],
        ),
      )),
    );
  }

  //Web Sign In
  Container SignUpWeb(Size _size, BuildContext context) {
    return Container(
      width: _size.width,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
              child: Container(
            padding: EdgeInsets.all(20),
            color: kHoverColor,
            height: _size.height,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  "assets/icons/logo.svg",
                  color: Colors.white,
                ),
                Text(
                  "Immobarcide",
                  style: Theme.of(context).textTheme.headline1!.copyWith(
                        color: Colors.white,
                      ),
                ),
              ],
            ),
          )),
          Expanded(
            child: Center(
              child: Container(
                padding: EdgeInsets.all(50),
                //height: _size.height,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("BIENVENUE À",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headline3),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          "assets/icons/logo.svg",
                          color: kHoverColor,
                        ),
                        Text(
                          "Immobarcide",
                          style: Theme.of(context)
                              .textTheme
                              .headline2!
                              .copyWith(color: kHoverColor),
                        ),
                      ],
                    ),
                    SizedBox(height: 30),
                    Text(
                      "S'inscrire",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headline4,
                    ),
                    SizedBox(height: 20),
                    Form(
                      key: formkeySignUp,
                      child: ListView(
                        shrinkWrap: true,
                        children: [
                          TextFormField(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            controller: _nameController,
                            maxLines: 1,
                            decoration: InputDecoration(
                                prefixIcon: Icon(Icons.person_2_outlined),
                                hintText: "Saisir le nom",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20))),
                            validator: MultiValidator(
                              [
                                RequiredValidator(errorText: "* Obligatoire"),
                              ],
                            ),
                          ),
                          SizedBox(height: 20),
                          TextFormField(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            controller: _emailController,
                            maxLines: 1,
                            decoration: InputDecoration(
                                prefixIcon: Icon(Icons.alternate_email_rounded),
                                hintText: "Saisir Email",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20))),
                            validator: MultiValidator(
                              [
                                RequiredValidator(errorText: "* Obligatoire"),
                                EmailValidator(
                                    errorText: "Saisir un email valide "),
                              ],
                            ),
                          ),
                          SizedBox(height: 20),
                          TextFormField(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            controller: _passController,
                            maxLines: 1,
                            obscureText: isVisible,
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.fingerprint),
                              hintText: "Saisir mot de passe",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  isVisible
                                      ? CupertinoIcons.eye_fill
                                      : CupertinoIcons.eye_slash_fill,
                                  color: Colors.grey,
                                ),
                                onPressed: _updatePasswordVisibility,
                              ),
                            ),
                            validator: MultiValidator([
                              RequiredValidator(errorText: "* Obligatoire"),
                              MinLengthValidator(6,
                                  errorText:
                                      "Le mot de passe doit comporter au moins 6 caractères"),
                              MaxLengthValidator(15,
                                  errorText:
                                      "Le mot de passe ne doit pas comporter plus de 15 caractères")
                            ]),
                          ),
                          SizedBox(height: 20),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      width: 200,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (formkeySignUp.currentState!.validate()) {
                            final user = UserModel(
                              email: _emailController.text.trim(),
                              password: _passController.text.trim(),
                              fullName: _nameController.text.trim(),
                              role: "admin",
                            );

                            satusSignUp =
                                (await controller.createUserController(user))!;

                            setState(() {
                              satusSignUp = satusSignUp;
                            });

                            if (satusSignUp == true)
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => WholeProfilPage()),
                              );
                          }
                        },
                        child: Text(
                          "S'inscrire",
                          style: Theme.of(context)
                              .textTheme
                              .headline4!
                              .copyWith(
                                  color: kWhiteColor,
                                  fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "J'ai déjà un compte ? ",
                          style: Theme.of(context).textTheme.headline5,
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => SignIn()),
                            );
                          },
                          child: Text(
                            "Se Connecter",
                            style: Theme.of(context)
                                .textTheme
                                .headline5!
                                .copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: kBlueColor),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  //Mobile Sign In
  Container SignUpMobile(Size _size, BuildContext context) {
    return Container(
        width: _size.width,
        child: Container(
          alignment: Alignment.center,
          padding: _size.width > 800
              ? EdgeInsets.symmetric(horizontal: 20, vertical: 100)
              : EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 40),
              Text("BIENVENUE À",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline3),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    "assets/icons/logo.svg",
                    color: kHoverColor,
                  ),
                  Text(
                    "Immobarcide",
                    style: Theme.of(context)
                        .textTheme
                        .headline2!
                        .copyWith(color: kHoverColor),
                  ),
                ],
              ),
              SizedBox(height: 30),
              Text(
                "S'inscrire",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline4,
              ),
              SizedBox(height: 50),
              Form(
                key: formkeySignUp,
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: _nameController,
                      maxLines: 1,
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.person_2_outlined),
                          hintText: "Saisir le nom",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20))),
                      validator: MultiValidator(
                        [
                          RequiredValidator(errorText: "* Obligatoire"),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: _emailController,
                      maxLines: 1,
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.alternate_email_rounded),
                          hintText: "Saisir Email",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20))),
                      validator: MultiValidator(
                        [
                          RequiredValidator(errorText: "* Obligatoire"),
                          EmailValidator(errorText: "Saisir un email valide "),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: _passController,
                      maxLines: 1,
                      obscureText: isVisible,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.fingerprint),
                        hintText: "Saisir mot de passe",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                        suffixIcon: IconButton(
                          icon: Icon(
                            isVisible
                                ? CupertinoIcons.eye_fill
                                : CupertinoIcons.eye_slash_fill,
                            color: Colors.grey,
                          ),
                          onPressed: _updatePasswordVisibility,
                        ),
                      ),
                      validator: MultiValidator([
                        RequiredValidator(errorText: "* Obligatoire"),
                        MinLengthValidator(6,
                            errorText:
                                "Le mot de passe doit comporter au moins 6 caractères"),
                        MaxLengthValidator(15,
                            errorText:
                                "Le mot de passe ne doit pas comporter plus de 15 caractères")
                      ]),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 40),
              Container(
                width: 200,
                child: ElevatedButton(
                  onPressed: () async {
                    if (formkeySignUp.currentState!.validate()) {
                      final user = UserModel(
                        email: _emailController.text.trim(),
                        password: _passController.text.trim(),
                        fullName: _nameController.text.trim(),
                        role: "admin",
                      );

                      satusSignUp =
                          (await controller.createUserController(user))!;

                      setState(() {
                        satusSignUp = satusSignUp;
                      });

                      if (satusSignUp == true)
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => WholeProfilPage()),
                        );
                      else {
                        Fluttertoast.showToast(msg: "Erreur sign up ");
                      }
                    }
                  },
                  child: Text(
                    "S'inscrire",
                    style: Theme.of(context).textTheme.headline4!.copyWith(
                        color: kWhiteColor, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "J'ai déjà un compte ? ",
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignIn()),
                      );
                    },
                    child: Text(
                      "Se Connecter",
                      style: Theme.of(context).textTheme.headline5!.copyWith(
                          fontWeight: FontWeight.bold, color: kBlueColor),
                    ),
                  ),
                ],
              )
            ],
          ),
        ));
  }
}
