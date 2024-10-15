import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../main2/models/scroll_offset.dart';
import '../../../models/infos.dart';

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
      if (current.scrollOffsetValue >= 2400) {
        return true;
      } else {
        return false;
      }
    }, builder: (context, state) {
      return AnimatedCrossFade(
        crossFadeState: state.scrollOffsetValue >= 2500
            ? CrossFadeState.showSecond
            : CrossFadeState.showFirst,
        duration: Duration(milliseconds: 575),
        reverseDuration: Duration(milliseconds: 375),
        alignment: Alignment.center,
        firstCurve: Curves.easeOut,
        secondCurve: Curves.easeOut,
        firstChild: Container(
          //height: 260,
          //width: 220,
          margin: EdgeInsets.symmetric(vertical: 25, horizontal: 5),
        ),
        secondChild: Container(
          margin: EdgeInsets.all(25),
          padding: EdgeInsets.all(20),
          // height: 260,
          //width: 220,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                    width: 120,
                    height: 120,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image(
                        image: AssetImage(widget.info.image),
                      ),
                    )),
                Text(
                  widget.info.name,
                  style: Theme.of(context).textTheme.headline5,
                  textAlign: TextAlign.center,
                ),
                Text(
                  widget.info.job,
                  style: Theme.of(context).textTheme.headline6,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
