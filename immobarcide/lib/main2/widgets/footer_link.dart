import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:immobarcide/main2/models/footer.dart';

class FooterLink extends StatelessWidget {
  final Footer footer;
  const FooterLink({super.key, required this.footer});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          footer.title,
          style:
              GoogleFonts.quicksand(fontSize: 20, fontWeight: FontWeight.w700),
        ),
        SizedBox(height: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: footer.parametres
              .map(
                (params) => Padding(
                  padding: EdgeInsets.symmetric(vertical: 2),
                  child: Text(
                    params,
                    style: GoogleFonts.quicksand(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Colors.black45,
                    ),
                  ),
                ),
              )
              .toList(),
        )
      ],
    );
  }
}
