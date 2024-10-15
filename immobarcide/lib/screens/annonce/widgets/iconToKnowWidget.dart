import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class IconToKnowWidget extends StatelessWidget {
  const IconToKnowWidget(
      {super.key, this.iconString, this.subtitle, this.title});
  final String? iconString, title, subtitle;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        SvgPicture.asset(
          iconString!,
          height: 40,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 120,
              child: Text(
                title!,
                style: Theme.of(context)
                    .textTheme
                    .headline5!
                    .copyWith(fontWeight: FontWeight.w700),
                textAlign: TextAlign.start,
                overflow: TextOverflow.fade,
              ),
            ),
            SizedBox(height: 5),
            Container(
              width: 150,
              child: Text(
                subtitle!,
                style: Theme.of(context)
                    .textTheme
                    .headline5!
                    .copyWith(fontWeight: FontWeight.w200),
                textAlign: TextAlign.start,
                overflow: TextOverflow.fade,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
