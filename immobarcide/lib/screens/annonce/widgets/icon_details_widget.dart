import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class IconDetailsWidget extends StatelessWidget {
  const IconDetailsWidget({
    this.iconString,
    this.title,
    this.subtitle,
    super.key,
  });
  final String? iconString, title, subtitle;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        SvgPicture.asset(
          iconString!,
          height: 30,
        ),
        SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title!,
              style: Theme.of(context).textTheme.headline4,
              textAlign: TextAlign.start,
            ),
            if (subtitle != null)
              Text(
                subtitle!,
                style: Theme.of(context).textTheme.headline6,
                textAlign: TextAlign.start,
              ),
          ],
        ),
      ],
    );
  }
}
