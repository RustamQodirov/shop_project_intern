import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InfoBottomSheet {
  static void showInfoBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      backgroundColor: Colors.white,
      builder: (BuildContext context) {
        return Container(
          height: 286,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Image.asset(
                    'assets/images/uz.png',
                    width: 35,
                  ),
                  SizedBox(width: 8),
                  Image.asset(
                    'assets/images/eng.png',
                    width: 35,
                  ),
                ],
              ),
              SizedBox(height: 16),
              Text(
                'Чем отличаются тарифы?',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              Text(
                'Вы можете открыть вклад в узбекских сумах со ставкой до ~27% в год или в долларах США со ставкой ~13%',
                style: GoogleFonts.manrope(
                  fontSize: 14,
                  color: const Color(0xFF828DA1),
                ),
              ),
              const SizedBox(height: 25),
              Text(
                'Что значит «Партнёрство 99%»?',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              Text(
                '99% прибыли с оборота идёт вам,  а 1% получаем мы',
                style: GoogleFonts.manrope(
                  fontSize: 14,
                  color: const Color(0xFF828DA1),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}