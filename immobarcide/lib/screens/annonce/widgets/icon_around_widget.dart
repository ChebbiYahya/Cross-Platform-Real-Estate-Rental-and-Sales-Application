import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class IconAroundWidget extends StatelessWidget {
  const IconAroundWidget({
    this.iconString,
    this.distance,
    this.subtile,
    this.title,
    super.key,
  });
  final String? iconString, title, subtile, distance;

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
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
            if (subtile != null)
              Container(
                width: 120,
                child: Text(
                  subtile!,
                  style: Theme.of(context)
                      .textTheme
                      .headline5!
                      .copyWith(fontWeight: FontWeight.w200),
                  textAlign: TextAlign.start,
                  overflow: TextOverflow.fade,
                ),
              ),
            if (_size.width < 350)
              Text(
                distance!,
                style: Theme.of(context)
                    .textTheme
                    .headline5!
                    .copyWith(fontWeight: FontWeight.w700),
                textAlign: TextAlign.start,
              ),
          ],
        ),
        if (_size.width > 350)
          Text(
            distance!,
            style: Theme.of(context)
                .textTheme
                .headline5!
                .copyWith(fontWeight: FontWeight.w700),
            textAlign: TextAlign.start,
          ),
      ],
    );
  }
}
