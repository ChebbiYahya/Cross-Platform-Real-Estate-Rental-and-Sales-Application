import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:immobarcide/controllers/reservation_controller.dart';
import 'package:immobarcide/models/annonce_model.dart';
import '../../../constants.dart';
import '../../../models/reservation_model.dart';

class ReservationSection extends StatelessWidget {
  const ReservationSection({
    super.key,
  });

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
            "Mes réservations",
            style: Theme.of(context).textTheme.headline2,
            textAlign: TextAlign.center,
          ),
          Expanded(
            child: FutureBuilder<List<ReservationModel>>(
                future: controller.getReservation(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        itemCount: snapshot.data!.length,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) {
                          return _size.width > 700
                              ? WebCardReservation(
                                  reservation: snapshot.data![index])
                              : MobileCardReservation(
                                  reservation: snapshot.data![index]);
                        },
                      );
                    } else if (snapshot.hasError) {
                      return Center(child: Text(snapshot.error.toString()));
                    } else {
                      return Center(
                          child: Text("Quelque chose n'a pas fonctionné"));
                    }
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                }),
          ),
          if (_size.width < 700) SizedBox(height: 20),
        ],
      ),
    );
  }
}

class MobileCardReservation extends StatefulWidget {
  const MobileCardReservation({
    super.key,
    required this.reservation,
  });
  final ReservationModel reservation;

  @override
  State<MobileCardReservation> createState() => _MobileCardReservationState();
}

class _MobileCardReservationState extends State<MobileCardReservation> {
  @override
  Widget build(BuildContext context) {
    var _size = MediaQuery.of(context).size;
    final controller = Get.put(ReservationController());
    bool isCancelled = false;
    return Container(
      margin: EdgeInsets.all(20),
      padding: _size.width > 450 ? EdgeInsets.all(20) : EdgeInsets.all(10),
      width: double.infinity,
      height: 660,
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
                            "${annonce.ville!}, ${annonce.cite!}",
                            style: Theme.of(context).textTheme.headline6,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              if (annonce.nbRooms != "")
                                CaractresticImage(
                                    imageString:
                                        "assets/images/ad_icons/bed.svg",
                                    title: "${annonce.nbRooms!} Chambres"),
                              if (annonce.nbRooms != "") SizedBox(width: 20),
                              if (annonce.nbBathrooms != "")
                                CaractresticImage(
                                    imageString:
                                        "assets/images/ad_icons/bath.svg",
                                    title: "${annonce.nbBathrooms!} Toilettes"),
                              if (annonce.nbBathrooms != "")
                                SizedBox(width: 20),
                              if (annonce.nbGarage != "")
                                CaractresticImage(
                                    imageString:
                                        "assets/images/ad_icons/car.svg",
                                    title: "${annonce.nbGarage!} Garages"),
                              if (annonce.nbGarage != "") SizedBox(width: 20),
                              if (annonce.totalArea != "")
                                CaractresticImage(
                                    imageString:
                                        "assets/images/ad_icons/angularRuler.svg",
                                    title: "${annonce.totalArea!} "),
                            ],
                          ),
                          Divider(),
                          if (widget.reservation.status == "0")
                            OnHoldingWidget(),
                          if (widget.reservation.status == "1") ConfirmWidget(),
                          if (widget.reservation.status == "2")
                            AlreadyReservedWidget(),
                          if (widget.reservation.status == "3")
                            NotAvailableWidget(),
                          if (widget.reservation.status == "4") RefusedWidget(),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Icon(Icons.access_time_rounded, size: 25),
                              SizedBox(width: 20),
                              Text(
                                widget.reservation.time!,
                                style: Theme.of(context)
                                    .textTheme
                                    .headline4!
                                    .copyWith(color: Colors.red),
                                // overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Icon(Icons.warning_amber_rounded, size: 25),
                              SizedBox(width: 20),
                              Expanded(
                                child: Text(
                                  widget.reservation.note!,
                                  style: Theme.of(context).textTheme.headline5,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                ),
                              )
                            ],
                          ),
                          Spacer(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              OutlinedButton(
                                onPressed: () async {
                                  isCancelled = controller.deletAnnonce(
                                          widget.reservation.idReservation!)
                                      as bool;
                                  setState(() {
                                    isCancelled = isCancelled;
                                  });
                                },
                                style: OutlinedButton.styleFrom(
                                  side: BorderSide(color: Colors.red, width: 2),
                                ),
                                child: Text(
                                  isCancelled ? "ANNULÉ" : "ANNULER",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline4!
                                      .copyWith(color: Colors.red),
                                ),
                              ),
                            ],
                          ),
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

class WebCardReservation extends StatefulWidget {
  const WebCardReservation({
    super.key,
    required this.reservation,
  });

  final ReservationModel reservation;

  @override
  State<WebCardReservation> createState() => _WebCardReservationState();
}

class _WebCardReservationState extends State<WebCardReservation> {
  bool isCancelled = false;
  @override
  Widget build(BuildContext context) {
    var _size = MediaQuery.of(context).size;
    final controller = Get.put(ReservationController());
    return Container(
      margin: EdgeInsets.all(20),
      padding: EdgeInsets.all(10),
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
                        width: double.infinity,
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
                            SizedBox(height: 20),
                            Text(
                              "${annonce.ville!}, ${annonce.cite!}",
                              style: Theme.of(context).textTheme.headline6,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 10),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                if (annonce.nbRooms != "")
                                  CaractresticImage(
                                      imageString:
                                          "assets/images/ad_icons/bed.svg",
                                      title: "${annonce.nbRooms!} Chambres"),
                                if (annonce.nbRooms != "") SizedBox(width: 20),
                                if (annonce.nbBathrooms != "")
                                  CaractresticImage(
                                      imageString:
                                          "assets/images/ad_icons/bath.svg",
                                      title:
                                          "${annonce.nbBathrooms!} Toilettes"),
                                if (annonce.nbBathrooms != "")
                                  SizedBox(width: 20),
                                if (annonce.nbGarage != "")
                                  CaractresticImage(
                                      imageString:
                                          "assets/images/ad_icons/car.svg",
                                      title: "${annonce.nbGarage!} Garages"),
                                if (annonce.nbGarage != "") SizedBox(width: 20),
                                if (annonce.totalArea != "")
                                  CaractresticImage(
                                      imageString:
                                          "assets/images/ad_icons/angularRuler.svg",
                                      title: "${annonce.totalArea!}"),
                              ],
                            ),
                            SizedBox(height: 10),
                            if (widget.reservation.status == "0")
                              OnHoldingWidget(),
                            if (widget.reservation.status == "1")
                              ConfirmWidget(),
                            if (widget.reservation.status == "2")
                              AlreadyReservedWidget(),
                            if (widget.reservation.status == "3")
                              NotAvailableWidget(),
                            if (widget.reservation.status == "4")
                              RefusedWidget(),
                            SizedBox(height: 20),
                            Row(
                              children: [
                                Icon(Icons.access_time_rounded, size: 25),
                                SizedBox(width: 20),
                                Text(
                                  widget.reservation.time!,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline4!
                                      .copyWith(color: Colors.red),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                            Row(
                              children: [
                                Icon(Icons.warning_amber_rounded, size: 25),
                                SizedBox(width: 20),
                                Expanded(
                                  child: Text(
                                    widget.reservation.note!,
                                    style:
                                        Theme.of(context).textTheme.headline5,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 3,
                                  ),
                                )
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                OutlinedButton(
                                  onPressed: () async {
                                    isCancelled = controller.deletAnnonce(
                                            widget.reservation.idReservation!)
                                        as bool;
                                    setState(() {
                                      isCancelled = isCancelled;
                                    });
                                  },
                                  style: OutlinedButton.styleFrom(
                                    side:
                                        BorderSide(color: Colors.red, width: 2),
                                  ),
                                  child: Text(
                                    isCancelled ? "ANNULÉ" : "ANNULER",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline4!
                                        .copyWith(color: Colors.red),
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

class ConfirmWidget extends StatelessWidget {
  const ConfirmWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Icon(
            Icons.task_alt_rounded,
            color: Colors.green,
            size: 25,
          ),
          SizedBox(width: 20),
          Text(
            "Confirmer",
            style: Theme.of(context)
                .textTheme
                .headline3!
                .copyWith(color: Colors.green),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ],
      ),
    );
  }
}

class OnHoldingWidget extends StatelessWidget {
  const OnHoldingWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Icon(
            Icons.adjust_rounded,
            color: Colors.orangeAccent,
            size: 25,
          ),
          SizedBox(width: 20),
          Text(
            "En attente",
            style: Theme.of(context)
                .textTheme
                .headline3!
                .copyWith(color: Colors.orangeAccent),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ],
      ),
    );
  }
}

class AlreadyReservedWidget extends StatelessWidget {
  const AlreadyReservedWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Icon(
            Icons.adjust_rounded,
            color: Colors.orange,
            size: 25,
          ),
          SizedBox(width: 20),
          Text(
            "Déjà réservé",
            style: Theme.of(context)
                .textTheme
                .headline3!
                .copyWith(color: Colors.orange),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ],
      ),
    );
  }
}

class NotAvailableWidget extends StatelessWidget {
  const NotAvailableWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Icon(
            Icons.adjust_rounded,
            color: Colors.red,
            size: 25,
          ),
          SizedBox(width: 20),
          Text(
            "Non disponible",
            style: Theme.of(context)
                .textTheme
                .headline3!
                .copyWith(color: Colors.red),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ],
      ),
    );
  }
}

class RefusedWidget extends StatelessWidget {
  const RefusedWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Icon(
            Icons.cancel_outlined,
            color: Colors.red,
            size: 30,
          ),
          SizedBox(width: 20),
          Text(
            "Refusé",
            style: Theme.of(context)
                .textTheme
                .headline3!
                .copyWith(color: Colors.red),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ],
      ),
    );
  }
}

class CaractresticImage extends StatelessWidget {
  const CaractresticImage({
    this.imageString,
    this.title,
    super.key,
  });
  final String? imageString, title;

  @override
  Widget build(BuildContext context) {
    var _size = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.all(3),
      margin: EdgeInsets.all(5),

      // width: _size.width > 950 ? 60 : 90,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        //color: kWhiteColor,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (_size.width > 500)
            Column(
              children: [
                SvgPicture.asset(
                  imageString!,
                  width: 30,
                ),
                SizedBox(height: 3),
                Text(
                  title!,
                  style: Theme.of(context).textTheme.headline5,
                ),
              ],
            ),
          if (_size.width < 500 && _size.width > 430)
            Column(
              children: [
                SvgPicture.asset(
                  imageString!,
                  width: 20,
                ),
                SizedBox(height: 3),
                Text(
                  title!,
                  style: Theme.of(context).textTheme.headline6,
                ),
              ],
            ),
          if (_size.width < 430)
            Column(
              children: [
                SvgPicture.asset(
                  imageString!,
                  width: 20,
                ),
                SizedBox(height: 3),
                Text(
                  title!,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(fontSize: 8),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
