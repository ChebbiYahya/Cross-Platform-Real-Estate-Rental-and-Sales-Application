import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:immobarcide/controllers/reservation_controller.dart';
import 'package:immobarcide/models/annonce_model.dart';
import 'package:immobarcide/models/reservation_model.dart';
import 'package:immobarcide/models/user_model.dart';
import '../../../constants.dart';
import '../../../controllers/authentification_controller.dart';

class BookVisit extends StatefulWidget {
  const BookVisit({this.annonce, super.key});
  final Annonce? annonce;

  @override
  State<BookVisit> createState() => _BookVisitState();
}

class _BookVisitState extends State<BookVisit> {
  GlobalKey<FormState> formkeyBook = GlobalKey<FormState>();
  TextEditingController _phoneController = new TextEditingController();
  TextEditingController _noteController = new TextEditingController();
  bool statusBooking = false;
  DateTime dateTime = DateTime.now();
  @override
  Widget build(BuildContext context) {
    final hours = dateTime.hour.toString().padLeft(2, '0');
    final minutes = dateTime.minute.toString().padLeft(2, '0');
    var _size = MediaQuery.of(context).size;
    final controllerAuth = Get.put(AuthentificationController());
    final controllerReser = Get.put(ReservationController());

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: kLightBlueColor, borderRadius: BorderRadius.circular(10)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Réserver une visite",
            style: Theme.of(context)
                .textTheme
                .headline4!
                .copyWith(fontWeight: FontWeight.w800, fontSize: 18),
            textAlign: TextAlign.start,
          ),
          Divider(thickness: 2),
          if (_size.width > 850)
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  "assets/images/ad_icons/clock.svg",
                  height: 40,
                ),
                SizedBox(width: 10),
                Text(
                  "Disponible: ",
                  style: Theme.of(context)
                      .textTheme
                      .headline5!
                      .copyWith(fontWeight: FontWeight.w700),
                ),
                Spacer(),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                      style: Theme.of(context).textTheme.headline5,
                      children: [
                        TextSpan(
                          text:
                              '${widget.annonce!.dateVisitIn}-${widget.annonce!.dateVisitOut} ',
                          style: Theme.of(context)
                              .textTheme
                              .headline5!
                              .copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: Colors.red),
                        ),
                        TextSpan(
                          text:
                              '${widget.annonce!.timeVisitIn}-${widget.annonce!.timeVisitOut} ',
                          style: Theme.of(context)
                              .textTheme
                              .headline5!
                              .copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: Colors.redAccent),
                        ),
                      ]),
                ),
              ],
            ),
          if (_size.width < 850)
            Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      "assets/images/ad_icons/clock.svg",
                      height: 40,
                    ),
                    SizedBox(width: 10),
                    Text(
                      "Disponible: ",
                      style: Theme.of(context)
                          .textTheme
                          .headline5!
                          .copyWith(fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                      style: Theme.of(context).textTheme.headline5,
                      children: [
                        TextSpan(
                          text:
                              '${widget.annonce!.dateVisitIn}-${widget.annonce!.dateVisitOut} ',
                          style: Theme.of(context)
                              .textTheme
                              .headline5!
                              .copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: Colors.red),
                        ),
                        TextSpan(
                          text:
                              '${widget.annonce!.timeVisitIn}-${widget.annonce!.timeVisitOut} ',
                          style: Theme.of(context)
                              .textTheme
                              .headline5!
                              .copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: Colors.redAccent),
                        ),
                      ]),
                ),
              ],
            ),
          SizedBox(height: 10),
          Divider(thickness: 1),
          SizedBox(height: 10),
          if (_size.width > 400)
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  "assets/images/ad_icons/clock.svg",
                  height: 40,
                ),
                SizedBox(width: 10),
                Text(
                  "Choisir le temps: ",
                  style: Theme.of(context)
                      .textTheme
                      .headline5!
                      .copyWith(fontWeight: FontWeight.w700),
                ),
                Spacer(),
                ElevatedButton(
                  onPressed: pickDateTime,
                  child: Text(
                    "${dateTime.year}/${dateTime.month}/${dateTime.day}\n $hours:$minutes",
                    style: Theme.of(context).textTheme.headline5!.copyWith(
                        color: kWhiteColor, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          if (_size.width < 400)
            Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      "assets/images/ad_icons/clock.svg",
                      height: 40,
                    ),
                    SizedBox(width: 10),
                    Text(
                      "Choisir le temps: ",
                      style: Theme.of(context)
                          .textTheme
                          .headline5!
                          .copyWith(fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: pickDateTime,
                  child: Text(
                    "${dateTime.year}/${dateTime.month}/${dateTime.day}\n $hours:$minutes",
                    style: Theme.of(context).textTheme.headline5!.copyWith(
                        color: kWhiteColor, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: _phoneController,
                  maxLines: 1,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.local_phone_rounded),
                      hintText: "N° Téléphone",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20))),
                  validator: MultiValidator(
                    [
                      RequiredValidator(errorText: "* Required"),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: _noteController,
                  maxLines: 1,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.warning_amber_rounded),
                      hintText: "Notes",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20))),
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Text(
            "Veuillez vous connecter avant de passer la réservation ",
            style: Theme.of(context)
                .textTheme
                .headline6!
                .copyWith(fontWeight: FontWeight.bold, color: Colors.red),
          ),
          SizedBox(height: 10),
          Container(
            width: 200,
            child: ElevatedButton(
              onPressed: () async {
                //  if (formkeyBook.currentState!.validate()) {
                UserModel user =
                    await controllerAuth.getUserDetailsController();
                String time =
                    "${dateTime.year}/${dateTime.month}/${dateTime.day}\n $hours:$minutes";
                ReservationModel reservation = ReservationModel(
                    fullname: user.fullName,
                    phone: _phoneController.text.trim(),
                    idUser: user.id,
                    idAnnonce: widget.annonce!.id,
                    time: time,
                    note: _noteController.text.trim(),
                    status: "0");

                statusBooking = await controllerReser
                    .createReservationController(reservation);
                setState(() {
                  statusBooking = statusBooking;
                });

                //  }
              },
              child: Text(
                "Réserver",
                style: Theme.of(context)
                    .textTheme
                    .headline4!
                    .copyWith(color: kWhiteColor, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          SizedBox(height: 10),
          if (statusBooking == true)
            Align(
              alignment: Alignment.center,
              child: Text(
                "La réservation est acceptée",
                style: Theme.of(context)
                    .textTheme
                    .headline6!
                    .copyWith(fontWeight: FontWeight.bold, color: Colors.green),
              ),
            ),
        ],
      ),
    );
  }

  Future pickDateTime() async {
    DateTime? date = await pickDate();
    if (date == null) return;
    TimeOfDay? time = await pickTime();
    if (time == null) return;
    final dateTime =
        DateTime(date.year, date.month, date.day, time.hour, time.minute);
    setState(() {
      this.dateTime = dateTime;
    });
  }

  Future<DateTime?> pickDate() => showDatePicker(
      context: context,
      initialDate: dateTime,
      firstDate: DateTime(2023),
      lastDate: DateTime(2060));
  Future<TimeOfDay?> pickTime() => showTimePicker(
        context: context,
        initialTime: TimeOfDay(
          hour: dateTime.hour,
          minute: dateTime.minute,
        ),
      );
}
