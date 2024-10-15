import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/infos.dart';
import '../models/scroll_offset.dart';

class InfoCard extends StatefulWidget {
  final Info info;
  const InfoCard({
    super.key,
    required this.info,
  });

  @override
  State<InfoCard> createState() => _InfoCardState();
}

class _InfoCardState extends State<InfoCard> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DisplayOffset, ScrollOffset>(
        buildWhen: (previous, current) {
      if (current.scrollOffsetValue >= 2200) {
        return true;
      } else {
        return false;
      }
    }, builder: (context, state) {
      return AnimatedCrossFade(
        crossFadeState: state.scrollOffsetValue >= 2400
            ? CrossFadeState.showSecond
            : CrossFadeState.showFirst,
        duration: Duration(milliseconds: 575),
        reverseDuration: Duration(milliseconds: 375),
        alignment: Alignment.center,
        firstCurve: Curves.easeOut,
        secondCurve: Curves.easeOut,
        firstChild: Container(
          height: 260,
          width: 220,
          margin: EdgeInsets.symmetric(vertical: 25, horizontal: 5),
        ),
        secondChild: Container(
          margin: EdgeInsets.all(25),
          padding: EdgeInsets.all(20),
          height: 260,
          width: 220,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Icon(
                    widget.info.iconData,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 15),
                Text(
                  widget.info.title,
                  style: GoogleFonts.quicksand(
                      fontSize: 20, fontWeight: FontWeight.w700),
                ),
                SizedBox(height: 15),
                Text(
                  widget.info.description,
                  /**here problem */
                  style: GoogleFonts.quicksand(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.black38),
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
