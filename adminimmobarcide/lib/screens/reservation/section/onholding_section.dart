import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import '../../../constants.dart';
import '../../../controllers/reservation_controller.dart';
import '../../../models/annonce_model.dart';
import '../../../models/reservation_model.dart';

class OnHoldingSection extends StatefulWidget {
  const OnHoldingSection({super.key});

  @override
  State<OnHoldingSection> createState() => _OnHoldingSectionState();
}

List<String> option = [" Confirm", "Time Reserved", "Not Available", "Refused"];

class _OnHoldingSectionState extends State<OnHoldingSection> {
  @override
  Widget build(BuildContext context) {
    var _size = MediaQuery.of(context).size;
    final controller = Get.put(ReservationController());

    return Container(
      margin: _size.width > 430 ? EdgeInsets.all(20) : EdgeInsets.all(5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "En Attente",
            style: Theme.of(context).textTheme.headline2,
            textAlign: TextAlign.center,
          ),
          Expanded(
            child: FutureBuilder<List<ReservationModel>>(
                future: controller.getReservationOnHolding(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return _size.width > 700
                              ? WebCardOnHolding(
                                  reservation: snapshot.data![index])
                              : MobileCardOnHolding(
                                  reservation: snapshot.data![index]);
                        },
                      );
                    } else if (snapshot.hasError) {
                      return Center(child: Text(snapshot.error.toString()));
                    } else {
                      return Center(child: Text("Something went wrong"));
                    }
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                }),
          ),
        ],
      ),
    );
  }
}

class MobileCardOnHolding extends StatefulWidget {
  const MobileCardOnHolding({
    super.key,
    required this.reservation,
  });
  final ReservationModel reservation;

  @override
  State<MobileCardOnHolding> createState() => _MobileCardOnHoldingState();
}

class _MobileCardOnHoldingState extends State<MobileCardOnHolding> {
  String currentOption = option[0];

  @override
  Widget build(BuildContext context) {
    var _size = MediaQuery.of(context).size;
    final controller = Get.put(ReservationController());

    return Container(
      margin: EdgeInsets.all(20),
      padding: _size.width > 450 ? EdgeInsets.all(20) : EdgeInsets.all(10),
      width: double.infinity,
      height: _size.width > 600 ? 780 : 840,
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
      child: FutureBuilder(
          future: controller.getAnnonce(widget.reservation.idAnnonce!),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              Annonce annonce = snapshot.data as Annonce;
              return Column(
                children: [
                  Expanded(
                    flex: 3,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10), // Image border
                      child: Image.network(
                        annonce.images![0],
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            annonce.title!,
                            style: Theme.of(context).textTheme.headline4,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                          SizedBox(height: 5),
                          Text(
                            "${annonce.ville},${annonce.cite}",
                            style: Theme.of(context).textTheme.headline6,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                          Divider(),
                          Row(
                            children: [
                              SizedBox(
                                width: 30,
                                height: 30,
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
                                    child: const Image(
                                        image: AssetImage(
                                            "assets/images/profile_pic.png"))),
                              ),
                              SizedBox(width: 10),
                              Text(
                                widget.reservation.fullname!,
                                style: Theme.of(context).textTheme.headline5,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                            ],
                          ),
                          SizedBox(height: 5),
                          Row(
                            children: [
                              Icon(Icons.local_phone_rounded),
                              SizedBox(width: 20),
                              Text(
                                widget.reservation.phone!,
                                style: Theme.of(context).textTheme.headline5,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                            ],
                          ),
                          SizedBox(height: 5),
                          Row(
                            children: [
                              Icon(Icons.access_time_rounded),
                              SizedBox(width: 20),
                              Text(
                                widget.reservation.time!,
                                style: Theme.of(context)
                                    .textTheme
                                    .headline5!
                                    .copyWith(color: Colors.redAccent),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              ),
                            ],
                          ),
                          SizedBox(height: 5),
                          Row(
                            children: [
                              Icon(Icons.warning_amber_rounded),
                              SizedBox(width: 20),
                              Expanded(
                                child: Text(
                                  widget.reservation.note!,
                                  style: Theme.of(context).textTheme.headline6,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 3,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: ListTile(
                                  title: Text(
                                    "Confirm",
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline5!
                                        .copyWith(color: kBlueColor),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                  ),
                                  leading: Radio(
                                    value: option[0],
                                    activeColor: kBlueColor,
                                    groupValue: currentOption,
                                    onChanged: (value) {
                                      setState(() {
                                        currentOption = value.toString();
                                      });
                                    },
                                  ),
                                ),
                              ),
                              Expanded(
                                child: ListTile(
                                  title: Text(
                                    "Time Reserved",
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline5!
                                        .copyWith(color: kBlueColor),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                  ),
                                  leading: Radio(
                                    value: option[1],
                                    activeColor: kBlueColor,
                                    groupValue: currentOption,
                                    onChanged: (value) {
                                      setState(() {
                                        currentOption = value.toString();
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: ListTile(
                                  title: Text(
                                    "Not Available",
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline5!
                                        .copyWith(color: kBlueColor),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                  ),
                                  leading: Radio(
                                    value: option[2],
                                    activeColor: kBlueColor,
                                    groupValue: currentOption,
                                    onChanged: (value) {
                                      setState(() {
                                        currentOption = value.toString();
                                      });
                                    },
                                  ),
                                ),
                              ),
                              Expanded(
                                child: ListTile(
                                  title: Text(
                                    "Refused",
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline5!
                                        .copyWith(color: kBlueColor),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                  ),
                                  leading: Radio(
                                    value: option[3],
                                    activeColor: kBlueColor,
                                    groupValue: currentOption,
                                    onChanged: (value) {
                                      setState(() {
                                        currentOption = value.toString();
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              ElevatedButton(
                                  onPressed: () async {
                                    String status = "1";
                                    switch (currentOption) {
                                      case "Confirm":
                                        status = "1";
                                      case "Time Reserved":
                                        status = "2";
                                      case "Not Available":
                                        status = "3";
                                      case "Refused":
                                        status = "4";
                                    }
                                    controller.updateReservation(status,
                                        widget.reservation.idReservation!);
                                  },
                                  child: Text(
                                    "Send",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline5!
                                        .copyWith(color: Colors.white),
                                  )),
                            ],
                          )
                        ],
                      ),
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

class WebCardOnHolding extends StatefulWidget {
  const WebCardOnHolding({
    super.key,
    required this.reservation,
  });

  final ReservationModel reservation;

  @override
  State<WebCardOnHolding> createState() => _WebCardOnHoldingState();
}

class _WebCardOnHoldingState extends State<WebCardOnHolding> {
  String currentOption = option[0];
  @override
  Widget build(BuildContext context) {
    var _size = MediaQuery.of(context).size;
    final controller = Get.put(ReservationController());
    return Container(
      margin: EdgeInsets.all(20),
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
      child: FutureBuilder(
          future: controller.getAnnonce(widget.reservation.idAnnonce!),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              Annonce annonce = snapshot.data as Annonce;
              return Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10), // Image border
                      child: Image.network(
                        annonce.images![0],
                        fit: BoxFit.cover,
                        //width: double.infinity,
                      ),
                    ),
                  ),
                  Expanded(
                      flex: _size.width > 1150 ? 4 : 3,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              annonce.title!,
                              style: Theme.of(context).textTheme.headline3,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                            SizedBox(height: 5),

                            Text(
                              "${annonce.ville},${annonce.cite}",
                              style: Theme.of(context).textTheme.headline6,
                              overflow: TextOverflow.ellipsis,
                            ),
                            //SizedBox(height: 10),
                            Divider(),
                            Row(
                              children: [
                                SizedBox(
                                  width: 30,
                                  height: 30,
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(100),
                                      child: const Image(
                                          image: AssetImage(
                                              "assets/images/profile_pic.png"))),
                                ),
                                SizedBox(width: 10),
                                Text(
                                  widget.reservation.fullname!,
                                  style: Theme.of(context).textTheme.headline5,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              ],
                            ),
                            SizedBox(height: 5),
                            Row(
                              children: [
                                Icon(Icons.local_phone_rounded),
                                SizedBox(width: 20),
                                Text(
                                  widget.reservation.phone!,
                                  style: Theme.of(context).textTheme.headline5,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              ],
                            ),
                            SizedBox(height: 5),
                            Row(
                              children: [
                                Icon(Icons.access_time_rounded),
                                SizedBox(width: 20),
                                Text(
                                  widget.reservation.time!,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline5!
                                      .copyWith(color: Colors.redAccent),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                ),
                              ],
                            ),
                            SizedBox(height: 5),
                            Row(
                              children: [
                                Icon(Icons.warning_amber_rounded),
                                SizedBox(width: 20),
                                Expanded(
                                  child: Text(
                                    widget.reservation.note!,
                                    style:
                                        Theme.of(context).textTheme.headline6,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 3,
                                  ),
                                ),
                              ],
                            ),
                            //SizedBox(height: 5),
                            Row(
                              children: [
                                Expanded(
                                  child: ListTile(
                                    title: Text(
                                      "Confirmer",
                                      textAlign: TextAlign.center,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline5!
                                          .copyWith(color: kBlueColor),
                                    ),
                                    leading: Radio(
                                      value: option[0],
                                      activeColor: kBlueColor,
                                      groupValue: currentOption,
                                      onChanged: (value) {
                                        setState(() {
                                          currentOption = value.toString();
                                        });
                                      },
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: ListTile(
                                    title: Text(
                                      "Temps Réservé",
                                      textAlign: TextAlign.center,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline5!
                                          .copyWith(color: kBlueColor),
                                    ),
                                    leading: Radio(
                                      value: option[1],
                                      activeColor: kBlueColor,
                                      groupValue: currentOption,
                                      onChanged: (value) {
                                        setState(() {
                                          currentOption = value.toString();
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            Row(
                              children: [
                                Expanded(
                                  child: ListTile(
                                    title: Text(
                                      "Non Disponible",
                                      textAlign: TextAlign.center,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline5!
                                          .copyWith(color: kBlueColor),
                                    ),
                                    leading: Radio(
                                      value: option[2],
                                      activeColor: kBlueColor,
                                      groupValue: currentOption,
                                      onChanged: (value) {
                                        setState(() {
                                          currentOption = value.toString();
                                        });
                                      },
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: ListTile(
                                    title: Text(
                                      "Refusé",
                                      textAlign: TextAlign.center,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline5!
                                          .copyWith(color: kBlueColor),
                                    ),
                                    leading: Radio(
                                      value: option[3],
                                      activeColor: kBlueColor,
                                      groupValue: currentOption,
                                      onChanged: (value) {
                                        setState(() {
                                          currentOption = value.toString();
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                ElevatedButton(
                                  onPressed: () async {
                                    String status = "1";
                                    switch (currentOption) {
                                      case "Confirm":
                                        status = "1";
                                      case "Time Reserved":
                                        status = "2";
                                      case "Not Available":
                                        status = "3";
                                      case "Refused":
                                        status = "4";
                                    }
                                    controller
                                        .updateReservation(status,
                                            widget.reservation.idReservation!)
                                        .then((value) => Fluttertoast.showToast(
                                            msg: "Enovoyé"));
                                  },
                                  child: Text(
                                    "Envoyer",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline5!
                                        .copyWith(color: Colors.white),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      )),
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
