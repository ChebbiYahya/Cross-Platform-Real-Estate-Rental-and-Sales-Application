import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:immobarcide/controllers/authentification_controller.dart';
import '../../constants.dart';
import '../../models/user_model.dart';
import 'sections/contact_section.dart';
import 'sections/reservation_section.dart';
import 'sections/setting_section.dart';
import 'widgets/side_menu.dart';

class ProfilScreen extends StatefulWidget {
  const ProfilScreen({super.key});

  @override
  State<ProfilScreen> createState() => _ProfilScreenState();
}

class _ProfilScreenState extends State<ProfilScreen> {
  int _containerIndex = 0;
  int _containerIndexHome = 0;
  bool isVisible = true;
  bool satusSignIn = true;
  bool satusSignUp = true;
  bool satusForguetPassword = false;
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passController = new TextEditingController();
  TextEditingController _nameController = new TextEditingController();
  TextEditingController _phoneController = new TextEditingController();
  GlobalKey<FormState> formkeySignIn = GlobalKey<FormState>();
  GlobalKey<FormState> formkeySignUp = GlobalKey<FormState>();
  final controller = Get.put(AuthentificationController());

  void _updatePasswordVisibility() {
    setState(() {
      isVisible = !isVisible;
    });
  }

  void _pressReservation() {
    setState(() {
      _containerIndexHome = 0;
    });
  }

  void _pressSettings() {
    setState(() {
      _containerIndexHome = 1;
    });
  }

  void _pressContact() {
    setState(() {
      _containerIndexHome = 2;
    });
  }

  void _pressLogout() async {
    await controller.logoutController();
    setState(() {
      _containerIndex = 0;
    });
  }

  bool _isConnectedControllerComplete = false;

  Future<FirebaseApp> _initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();

    return firebaseApp;
  }

  Future<void> _initializeData() async {
    bool? isConnected = await controller.isConnectedController();
    print("is connected =${await controller.isConnectedController()}");
    setState(() {
      if (isConnected == true) {
        _containerIndex = 3;
      } else {
        _containerIndex = 0;
      }
    });
  }

  @override
  void initState() {
    /* print("is connected =${await controller.isConnectedController()}");
    if (await controller.isConnectedController() == true)
      setState(() {
        _containerIndex = 3;
      });
    else
      setState(() {
        _containerIndex = 0;
      });*/

    super.initState();
    _initializeData();
  }

  @override
  Widget build(BuildContext context) {
    var _size = MediaQuery.of(context).size;
    return Container(
      child: SingleChildScrollView(
        child: AnimatedSwitcher(
          duration: Duration(milliseconds: 500),
          child: FutureBuilder(
              future: _initializeFirebase(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {}
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (_containerIndex == 0) SignIn(_size, context),
                    if (_containerIndex == 1) SignUp(_size, context),
                    if (_containerIndex == 2) ForgetPassword(_size, context),
                    if (_containerIndex == 3)
                      Container(
                        child: Column(
                          children: [
                            if (_size.width > 1100) WebProfil(_size),
                            if (_size.width < 1100) MobileProfil(_size),
                          ],
                        ),
                      ),
                  ],
                );
              }),
        ),
      ),
    );
  }

//mobile profil
  Container MobileProfil(Size _size) {
    return Container(
      height: _size.height - 107,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 5),
            //height: 80,
            width: double.infinity,
            child: MobileSideMenu(
              pressResevation: _pressReservation,
              pressContact: _pressContact,
              pressSettings: _pressSettings,
              pressLogout: _pressLogout,
              index: _containerIndexHome,
            ),
          ),
          Divider(),
          if (_containerIndexHome == 0)
            Expanded(
              child: ReservationSection(),
            ),
          if (_containerIndexHome == 1)
            Expanded(
              child: SettingSection(),
            ),
          if (_containerIndexHome == 2)
            Expanded(
              child: ContactSection(),
            ),
        ],
      ),
    );
  }

  //Web Profil
  Container WebProfil(Size _size) {
    return Container(
      height: _size.height,
      child: Row(
        children: [
          Expanded(
            child: WebSideMenu(
              pressResevation: _pressReservation,
              pressContact: _pressContact,
              pressSettings: _pressSettings,
              pressLogout: _pressLogout,
              index: _containerIndexHome,
            ),
          ),
          Expanded(
            //it take 5/6 part of the screen
            flex: 4,
            child: Column(
              children: [
                if (_containerIndexHome == 0)
                  Expanded(
                    child: ReservationSection(),
                  ),
                if (_containerIndexHome == 1)
                  Expanded(
                    child: SettingSection(),
                  ),
                if (_containerIndexHome == 2)
                  Expanded(
                    child: ContactSection(),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  //Forget password
  Container ForgetPassword(Size _size, BuildContext context) {
    return Container(
      child: Column(
        children: [
          _size.width > 800
              ? webForgetPassword(_size, context)
              : MobileForgetPassword(_size, context),
        ],
      ),
    );
  }

  Container webForgetPassword(Size _size, BuildContext context) {
    return Container(
      width: _size.width,
      height: _size.height,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.all(20),
              height: _size.height,
              color: kHoverColor,
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
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(50),
              //height: _size.height,
              //color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("BIENVENUE",
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
                    "Mot de passe Oublié",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  SizedBox(height: 40),
                  Form(
                    key: formkeySignUp,
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: _emailController,
                          maxLines: 1,
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.person_outline),
                              hintText: "Saisir l'email",
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
                      ],
                    ),
                  ),
                  SizedBox(height: 30),
                  Container(
                    width: 200,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (formkeySignUp.currentState!.validate()) {
                          satusForguetPassword =
                              (await controller.forguetPasswordController(
                                  _emailController.text.trim()))!;
                          setState(() {
                            satusForguetPassword = satusForguetPassword;
                          });
                          if (satusForguetPassword == true)
                            Timer(Duration(seconds: 2), () {
                              setState(() {
                                _containerIndex = 0;
                              });
                            });
                        }
                      },
                      child: Text(
                        "Réinitialiser ",
                        style: Theme.of(context).textTheme.headline4!.copyWith(
                            color: kWhiteColor, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  if (satusForguetPassword == true)
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Vérifiez votre email",
                        style: Theme.of(context).textTheme.headline6!.copyWith(
                            fontWeight: FontWeight.bold, color: Colors.red),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container MobileForgetPassword(Size _size, BuildContext context) {
    return Container(
      width: _size.width,
      // height: _size.height,
      child: Expanded(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 100),
          //height: _size.height,
          //color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text("BIENVENUE",
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
              SizedBox(height: 40),
              Text(
                "Mot de passe Oublié",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline4,
              ),
              SizedBox(height: 40),
              Form(
                key: formkeySignUp,
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: _emailController,
                      maxLines: 1,
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.person_outline),
                          hintText: "Saisir l'email",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20))),
                      validator: MultiValidator(
                        [
                          RequiredValidator(errorText: "* Obligatoire"),
                          EmailValidator(errorText: "Saisir un email valide "),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30),
              Container(
                width: 200,
                child: ElevatedButton(
                  onPressed: () async {
                    if (formkeySignUp.currentState!.validate()) {
                      satusForguetPassword =
                          (await controller.forguetPasswordController(
                              _emailController.text.trim()))!;
                      setState(() {
                        satusForguetPassword = satusForguetPassword;
                      });
                      if (satusForguetPassword == true)
                        Timer(Duration(seconds: 2), () {
                          setState(() {
                            _containerIndex = 0;
                          });
                        });
                    }
                  },
                  child: Text(
                    "Réinitialiser",
                    style: Theme.of(context).textTheme.headline4!.copyWith(
                        color: kWhiteColor, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(height: 10),
              if (satusForguetPassword == true)
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Vérifiez votre email",
                    style: Theme.of(context).textTheme.headline6!.copyWith(
                        fontWeight: FontWeight.bold, color: Colors.red),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

//Sign Up
  Container SignUp(Size _size, BuildContext context) {
    return Container(
      child: Column(
        children: [
          _size.width > 800
              ? webSignUp(_size, context)
              : MobileSignUp(_size, context),
        ],
      ),
    );
  }

  Container webSignUp(Size _size, BuildContext context) {
    return Container(
      width: _size.width,
      //height: _size.height,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.all(50),
              height: _size.height,
              //color: Colors.white,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("BIENVENUE",
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
                      "Inscrivez-vous pour recevoir des réservations sur les sujets qui vous intéressent.",
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
                                prefixIcon: Icon(Icons.person_outline),
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
                            controller: _phoneController,
                            maxLines: 1,
                            decoration: InputDecoration(
                                prefixIcon: Icon(Icons.local_phone_rounded),
                                hintText: "Saisir N°téléphone",
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
                            controller: _passController,
                            maxLines: 1,
                            obscureText: isVisible,
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.fingerprint),
                              hintText: "Saisir Mot de passe",
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
                    if (satusSignUp == false) SizedBox(height: 10),
                    if (satusSignUp == false)
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Email existe déjà. Veuillez réessayer...",
                          style: Theme.of(context)
                              .textTheme
                              .headline6!
                              .copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red),
                        ),
                      ),
                    SizedBox(height: 15),
                    Container(
                      width: 200,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (formkeySignUp.currentState!.validate()) {
                            final user = UserModel(
                              email: _emailController.text.trim(),
                              password: _passController.text.trim(),
                              fullName: _nameController.text.trim(),
                              phoneNum: _phoneController.text.trim(),
                            );

                            satusSignUp =
                                (await controller.createUserController(user))!;
                            setState(() {
                              satusSignUp = satusSignUp;
                            });
                            if (satusSignUp == true)
                              setState(() {
                                _containerIndex = 3;
                              });
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
                          "J'ai déja un compte ? ",
                          style: Theme.of(context).textTheme.headline5,
                        ),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              _containerIndex = 0;
                            });
                          },
                          child: Text(
                            "Se connecter maintenant",
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
          Expanded(
            child: Container(
              padding: EdgeInsets.all(20),
              height: _size.height,
              color: kHoverColor,
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
            ),
          ),
        ],
      ),
    );
  }

  Container MobileSignUp(Size _size, BuildContext context) {
    return Container(
      width: _size.width,
      //height: _size.height,
      child: Expanded(
        child: Container(
          padding: _size.width > 800
              ? EdgeInsets.symmetric(horizontal: 20, vertical: 100)
              : EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          //height: _size.height,
          //color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 15),
              Text("BIENVENUE",
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
              SizedBox(height: 15),
              Text(
                "Inscrivez-vous pour recevoir des mises à jour immédiates sur les sujets qui vous intéressent.",
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
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: _nameController,
                      maxLines: 1,
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.person_outline),
                          hintText: "Saisir le nom",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20))),
                      validator: MultiValidator(
                        [
                          RequiredValidator(errorText: "* Required"),
                        ],
                      ),
                    ),
                    SizedBox(height: 15),
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
                    SizedBox(height: 15),
                    TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: _nameController,
                      maxLines: 1,
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.local_phone_rounded),
                          hintText: "Saisir N° Téléphone",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20))),
                      validator: MultiValidator(
                        [
                          RequiredValidator(errorText: "* Obligatoire"),
                        ],
                      ),
                    ),
                    SizedBox(height: 15),
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
              if (satusSignUp == false) SizedBox(height: 10),
              if (satusSignUp == false)
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    "L'email existe déjà. Veuillez réessayer...",
                    style: Theme.of(context).textTheme.headline6!.copyWith(
                        fontWeight: FontWeight.bold, color: Colors.red),
                  ),
                ),
              SizedBox(height: 15),
              Container(
                width: 200,
                child: ElevatedButton(
                  onPressed: () async {
                    if (formkeySignUp.currentState!.validate()) {
                      final user = UserModel(
                        email: _emailController.text.trim(),
                        password: _passController.text.trim(),
                        fullName: _nameController.text.trim(),
                        phoneNum: _phoneController.text.trim(),
                      );

                      satusSignUp =
                          (await controller.createUserController(user))!;
                      setState(() {
                        satusSignUp = satusSignUp;
                      });
                      if (satusSignUp == true)
                        setState(() {
                          _containerIndex = 3;
                        });
                    }
                  },
                  child: Text(
                    "S'inscrire",
                    style: Theme.of(context).textTheme.headline4!.copyWith(
                        color: kWhiteColor, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "J'ai déja un compte ? ",
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _containerIndex = 0;
                      });
                    },
                    child: Text(
                      "Se connecter maintenant",
                      style: Theme.of(context).textTheme.headline5!.copyWith(
                          fontWeight: FontWeight.bold, color: kBlueColor),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

//Sign In
  Container SignIn(Size _size, BuildContext context) {
    return Container(
      child: Column(
        children: [
          _size.width > 800
              ? webSignIn(_size, context)
              : MobileSignIn(_size, context),
        ],
      ),
    );
  }

  Container webSignIn(Size _size, BuildContext context) {
    return Container(
      width: _size.width,
      //height: _size.height,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.all(20),
              height: _size.height,
              color: kHoverColor,
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
            ),
          ),
          Expanded(
            child: Center(
              child: Container(
                padding: EdgeInsets.all(50),
                height: _size.height,
                //color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("BIENVENUE",
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
                      "Connectez-vous pour obtenir des réservations sur les sujets qui vous intéressent.",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headline4,
                    ),
                    SizedBox(height: 20),
                    Form(
                      key: formkeySignIn,
                      child: ListView(
                        shrinkWrap: true,
                        children: [
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
                          if (satusSignIn == false) SizedBox(height: 10),
                          if (satusSignIn == false)
                            Align(
                              alignment: Alignment.center,
                              child: Text(
                                "L'email ou le mot de passe est incorrect. Veuillez réessayer...",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline6!
                                    .copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.red),
                              ),
                            ),
                          if (satusSignIn == true) SizedBox(height: 10),
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () {
                                setState(() {
                                  _containerIndex = 2;
                                });
                              },
                              child: Text(
                                "Oublier le mot de passe?",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline5!
                                    .copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: kBlueColor),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      width: 200,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (formkeySignIn.currentState!.validate()) {
                            final user = UserModel(
                              email: _emailController.text.trim(),
                              password: _passController.text.trim(),
                              fullName: _nameController.text.trim(),
                              phoneNum: _phoneController.text.trim(),
                            );

                            satusSignIn =
                                (await controller.loginUserController(user))!;
                            setState(() {
                              satusSignIn = satusSignIn;
                            });
                            if (satusSignIn == true)
                              setState(() {
                                _containerIndex = 3;
                              });
                          }
                        },
                        child: Text(
                          "Se Connecter",
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
                          "Vous n'avez pas de compte ? ",
                          style: Theme.of(context).textTheme.headline5,
                        ),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              _containerIndex = 1;
                            });
                          },
                          child: Text(
                            "S'inscrire",
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
          )
        ],
      ),
    );
  }

  Container MobileSignIn(Size _size, BuildContext context) {
    return Container(
      width: _size.width,
      //height: _size.height,
      child: Expanded(
        child: Container(
          padding: _size.width > 800
              ? EdgeInsets.symmetric(horizontal: 20, vertical: 100)
              : EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          //height: _size.height,
          // color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              Text("BIENVENUE",
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
              SizedBox(height: 20),
              Text(
                "Connectez-vous pour recevoir des mises à jour immédiates sur les sujets qui vous intéressent.",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline4,
              ),
              SizedBox(height: 20),
              Form(
                key: formkeySignIn,
                child: ListView(
                  shrinkWrap: true,
                  children: [
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
                    if (satusSignIn == false) SizedBox(height: 10),
                    if (satusSignIn == false)
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          "L'email ou le mot de passe est incorrect. Veuillez réessayer...",
                          style: Theme.of(context)
                              .textTheme
                              .headline6!
                              .copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red),
                        ),
                      ),
                    if (satusSignIn == true) SizedBox(height: 10),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          setState(() {
                            _containerIndex = 2;
                          });
                        },
                        child: Text(
                          "Mot de passe oublié?",
                          style: Theme.of(context)
                              .textTheme
                              .headline5!
                              .copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: kBlueColor),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Container(
                width: 200,
                child: ElevatedButton(
                  onPressed: () async {
                    if (formkeySignIn.currentState!.validate()) {
                      final user = UserModel(
                        email: _emailController.text.trim(),
                        password: _passController.text.trim(),
                        fullName: _nameController.text.trim(),
                        phoneNum: _phoneController.text.trim(),
                      );

                      satusSignIn =
                          (await controller.loginUserController(user))!;
                      setState(() {
                        satusSignIn = satusSignIn;
                      });
                      if (satusSignIn == true)
                        setState(() {
                          _containerIndex = 3;
                        });
                    }
                  },
                  child: Text(
                    "Se connecter",
                    style: Theme.of(context).textTheme.headline4!.copyWith(
                        color: kWhiteColor, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(height: 30),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Vous n'avez pas de compte ? ",
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _containerIndex = 1;
                      });
                    },
                    child: Text(
                      "S'inscrire",
                      style: Theme.of(context).textTheme.headline5!.copyWith(
                          fontWeight: FontWeight.bold, color: kBlueColor),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
