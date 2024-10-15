import 'package:adminimmobarcide/screens/reservation/section/confirm_section.dart';
import 'package:adminimmobarcide/screens/reservation/section/onholding_section.dart';
import 'package:adminimmobarcide/screens/reservation/section/refused_section.dart';
import 'package:flutter/material.dart';

class ReservationSection extends StatefulWidget {
  const ReservationSection({super.key});

  @override
  State<ReservationSection> createState() => _ReservationSectionState();
}

class _ReservationSectionState extends State<ReservationSection> {
  int indexReservation = 0;
  void _pressOnHolding() {
    setState(() {
      indexReservation = 0;
    });
  }

  void _pressConfirmed() {
    setState(() {
      indexReservation = 1;
    });
  }

  void _pressRefused() {
    setState(() {
      indexReservation = 2;
    });
  }

  @override
  Widget build(BuildContext context) {
    var _size = MediaQuery.of(context).size;

    return DefaultTabController(
      length: 3,
      child: AnimatedSwitcher(
        duration: Duration(milliseconds: 500),
        child: Container(
          height: _size.width < 850 ? _size.height - 108 : null,
          margin: EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    onPressed: _pressOnHolding,
                    child: Container(
                        padding: EdgeInsets.all(10),
                        child: Row(
                          children: [
                            Icon(Icons.adjust_rounded,
                                color: Colors.orangeAccent,
                                size: indexReservation == 0 ? 25 : 20),
                            SizedBox(width: 10),
                            Text(
                              "En Attente",
                              textAlign: TextAlign.center,
                              style: indexReservation == 0
                                  ? Theme.of(context)
                                      .textTheme
                                      .headline5!
                                      .copyWith(
                                          color: Colors.orangeAccent,
                                          fontWeight: FontWeight.w900)
                                  : Theme.of(context)
                                      .textTheme
                                      .headline6!
                                      .copyWith(
                                          color: Colors.orangeAccent,
                                          fontWeight: FontWeight.w300),
                            ),
                          ],
                        )),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: TextButton(
                      onPressed: _pressConfirmed,
                      child: Row(
                        children: [
                          Icon(Icons.adjust_rounded,
                              color: Colors.green,
                              size: indexReservation == 1 ? 25 : 20),
                          SizedBox(width: 10),
                          Text(
                            "Confirmé",
                            textAlign: TextAlign.center,
                            style: indexReservation == 1
                                ? Theme.of(context)
                                    .textTheme
                                    .headline5!
                                    .copyWith(
                                        color: Colors.green,
                                        fontWeight: FontWeight.w900)
                                : Theme.of(context)
                                    .textTheme
                                    .headline6!
                                    .copyWith(
                                        color: Colors.green,
                                        fontWeight: FontWeight.w300),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: TextButton(
                      onPressed: _pressRefused,
                      child: Row(
                        children: [
                          Icon(Icons.adjust_rounded,
                              color: Colors.redAccent,
                              size: indexReservation == 2 ? 25 : 20),
                          SizedBox(width: 10),
                          Text(
                            "Refusé",
                            textAlign: TextAlign.center,
                            style: indexReservation == 2
                                ? Theme.of(context)
                                    .textTheme
                                    .headline5!
                                    .copyWith(
                                        color: Colors.redAccent,
                                        fontWeight: FontWeight.w900)
                                : Theme.of(context)
                                    .textTheme
                                    .headline6!
                                    .copyWith(
                                        color: Colors.redAccent,
                                        fontWeight: FontWeight.w300),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Divider(),
              if (indexReservation == 0) Expanded(child: OnHoldingSection()),
              if (indexReservation == 1) Expanded(child: ConfirmedSection()),
              if (indexReservation == 2) Expanded(child: RefusedSection()),
            ],
          ),
        ),
      ),
    );
  }
}
