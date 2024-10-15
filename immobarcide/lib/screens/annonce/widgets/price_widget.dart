import 'package:flutter/material.dart';
import '../../../constants.dart';

class Price extends StatelessWidget {
  const Price({
    this.price,
    super.key,
  });
  final String? price;

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.symmetric(horizontal: 20),
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      decoration: BoxDecoration(
          color: kLightBlueColor, borderRadius: BorderRadius.circular(10)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: _size.width > 450
            ? MainAxisAlignment.spaceBetween
            : MainAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Mortgage since:",
                style: Theme.of(context)
                    .textTheme
                    .headline5!
                    .copyWith(fontWeight: FontWeight.w200),
                textAlign: TextAlign.start,
                overflow: TextOverflow.fade,
              ),
              SizedBox(height: 5),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  price!,
                  style: Theme.of(context)
                      .textTheme
                      .headline5!
                      .copyWith(fontWeight: FontWeight.w700),
                  textAlign: TextAlign.start,
                  overflow: TextOverflow.fade,
                ),
              ),
              if (_size.width < 450)
                ElevatedButton(
                  onPressed: () {},
                  child: Text(
                    "Get a mortgage",
                    style: Theme.of(context)
                        .textTheme
                        .headline6!
                        .copyWith(color: Colors.white),
                  ),
                ),
            ],
          ),
          if (_size.width > 450)
            ElevatedButton(
              onPressed: () {},
              child: Text(
                "Get a mortgage",
                style: Theme.of(context)
                    .textTheme
                    .headline6!
                    .copyWith(color: Colors.white),
              ),
            ),
        ],
      ),
    );
  }
}
