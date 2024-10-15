import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:immobarcide/models/annonce_model.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';
import '../../../constants.dart';
import '../../../models/facilities_model.dart';

class FacilitiesWidget extends StatefulWidget {
  const FacilitiesWidget({super.key, this.annonce});
  final Annonce? annonce;

  @override
  State<FacilitiesWidget> createState() => _FacilitiesWidgetState();
}

class _FacilitiesWidgetState extends State<FacilitiesWidget> {
  @override
  Widget build(BuildContext context) {
    List FacilitiesList = [
      if (widget.annonce!.wifi == true)
        FacilitiesModels(
            iconString: "assets/images/ad_icons/wifi.svg", title: "Wifi"),
      if (widget.annonce!.airCond == true)
        FacilitiesModels(
            iconString: "assets/images/ad_icons/airconditioning.svg",
            title: "Climatiseur"),
      if (widget.annonce!.elevator == true)
        FacilitiesModels(
            iconString: "assets/images/ad_icons/elevator.svg",
            title: "Elevator"),
      if (widget.annonce!.kitchenFacil == true)
        FacilitiesModels(
            iconString: "assets/images/ad_icons/kitchen.svg",
            title: "Kitchen Facilities"),
      if (widget.annonce!.parking == true)
        FacilitiesModels(
            iconString: "assets/images/ad_icons/parking.svg", title: "Parking"),
      if (widget.annonce!.tv == true)
        FacilitiesModels(
            iconString: "assets/images/ad_icons/tv.svg", title: "TV"),
    ];
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: BoxDecoration(
        color: kLightBlueColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Most popular facilities",
            style: Theme.of(context)
                .textTheme
                .headline4!
                .copyWith(fontWeight: FontWeight.w800, fontSize: 18),
            textAlign: TextAlign.start,
            overflow: TextOverflow.fade,
          ),
          SizedBox(height: 10),
          SizedBox(
            height: 110,
            child: ScrollSnapList(
              itemBuilder: (context, index) {
                return FacilityWidget(
                  iconString: FacilitiesList[index].iconString.toString(),
                  title: FacilitiesList[index].title.toString(),
                );
              },
              allowAnotherDirection: true,
              shrinkWrap: true,
              selectedItemAnchor: SelectedItemAnchor.START,
              itemCount: FacilitiesList.length,
              itemSize: 100,
              duration: 5000,
              onItemFocus: (index) {},
            ),
          ),
        ],
      ),
    );
  }
}

class FacilityWidget extends StatelessWidget {
  const FacilityWidget({
    this.iconString,
    this.title,
    super.key,
  });
  final String? iconString, title;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      //height: 50,
      width: 90,
      decoration: BoxDecoration(
          color: kWhiteColor, borderRadius: BorderRadius.circular(30)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            iconString!,
            height: 40,
            color: Colors.black.withOpacity(0.7),
          ),
          SizedBox(height: 5),
          Container(
            alignment: Alignment.center,
            width: 80,
            child: Text(
              title!,
              style: Theme.of(context).textTheme.headline5!.copyWith(
                  fontWeight: FontWeight.w700,
                  fontSize: 12,
                  color: Colors.black.withOpacity(0.7)),
              textAlign: TextAlign.center,
              overflow: TextOverflow.fade,
            ),
          ),
        ],
      ),
    );
  }
}
