import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shop/features/investment/home/presentation/screens/fill_the_amount.dart';
import 'package:shop/features/investment/home/presentation/widgets/open_deposit_bottom_sheet.dart';

class DepositScreen extends StatelessWidget {
  const DepositScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              // SVG Image with Shadow
              Stack(
                alignment: Alignment.center,
                children: [
                  // Shadow effect
                  Positioned(
                    top: 2,
                    left: 2,
                    child: Container(
                      height: 110,
                      width: 110,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.25), // 25% opacity
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.white.withOpacity(0.25), // #FFFFFF40
                            blurRadius: 12,
                            spreadRadius: 4,
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Actual SVG Logo
                  Image.asset(
                    'assets/images/logo_open_deposit.png',
                    width: 130, // Increased from 97.5
                    height: 130, // Increased from 97.5
                    fit: BoxFit.contain,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              // Title
              Text(
                'Вклад открыт!',
                style: GoogleFonts.manrope(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 8),
              // Subtitle
              Text(
                'Пополните его, и прибыль начнёт начисляться',
                textAlign: TextAlign.center,
                style: GoogleFonts.manrope(
                  fontSize: 16,
                  color: const Color(0xFF040415).withOpacity(0.5),
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 46),
              // Info Box
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFF828DA1).withOpacity(0.06),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Прибыль начисляется в сумах, но мы покроем разницу курса 👌',
                      style: GoogleFonts.manrope(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 16),
                    GestureDetector(
                      onTap: () {
                        // Handle help tap
                      },
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              OpenDepositBottomSheet.openDepositBottomSheet(
                                  context);
                            },
                            child: const Icon(
                              Icons.lightbulb_outline,
                              color: Color(0xFF828DA1),
                              size: 18,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            'Почему в сумах?',
                            style: GoogleFonts.manrope(
                              fontSize: 16,
                              color: const Color(0xFF828DA1),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 97.5),
              // Buttons
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => FillTheAmount()));
                    // Handle deposit action
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 17.5),
                    backgroundColor: const Color(0xFF4059E6),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Text(
                    'Пополнить',
                    style: GoogleFonts.manrope(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    shadowColor: Colors.transparent,
                    surfaceTintColor: Colors.transparent,
                    splashFactory: NoSplash.splashFactory,
                    padding: const EdgeInsets.symmetric(vertical: 17.5),
                    backgroundColor: const Color(0xff4059E6).withOpacity(0.14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Text(
                    'Пополнить позже',
                    style: GoogleFonts.manrope(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: const Color(0xFF4059E6),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
