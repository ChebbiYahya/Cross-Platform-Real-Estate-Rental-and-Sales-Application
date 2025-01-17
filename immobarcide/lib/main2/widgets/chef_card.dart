import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/chefs.dart';
import '../models/scroll_offset.dart';

class ChefCard extends StatefulWidget {
  final Chef chef;
  const ChefCard({
    super.key,
    required this.chef,
  });

  @override
  State<ChefCard> createState() => _ChefCardState();
}

class _ChefCardState extends State<ChefCard>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;
  void initState() {
    controller = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 1000),
        reverseDuration: Duration(milliseconds: 375));
    animation = Tween<double>(begin: 250.0, end: 0.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.easeOut,
      ),
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DisplayOffset, ScrollOffset>(
        buildWhen: (previous, current) {
      if (current.scrollOffsetValue >= 3400) {
        return true;
      } else {
        return false;
      }
    }, builder: (context, state) {
      if (state.scrollOffsetValue > 3600) {
        controller.forward();
      } else {
        controller.reverse();
      }
      return AnimatedBuilder(
          animation: animation,
          builder: (context, child) {
            return Container(
              height: 370,
              width: 250,
              margin: EdgeInsets.all(25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 300,
                    width: 250,
                    child: Stack(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(1),
                          child: Image.network(
                            widget.chef.image,
                            fit: BoxFit.cover,
                            height: 300,
                            width: 250,
                          ),
                        ),
                        Align(
                          alignment: Alignment(
                              widget.chef.index % 2 == 1 ? 1.0 : -1, 1),
                          child: Container(
                            height: 300,
                            width: animation.value,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    widget.chef.name,
                    style: GoogleFonts.quicksand(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    widget.chef.designation,
                    style: GoogleFonts.quicksand(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black54,
                    ),
                  )
                ],
              ),
            );
          });
    });
  }
}
