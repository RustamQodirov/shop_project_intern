import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shop/features/investment/home/presentation/screens/deposit_info.dart';
import 'package:shop/features/investment/home/presentation/widgets/bottom_navbar_invest.dart';

class InvestHomePage extends StatefulWidget {
  @override
  _InvestHomePageState createState() => _InvestHomePageState();
}

class _InvestHomePageState extends State<InvestHomePage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: (index) => setState(() => _selectedIndex = index),
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: 270,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(25)),
            ),
            child: Stack(
              fit: StackFit.expand,
              children: [
                ClipRRect(
                  borderRadius:
                      const BorderRadius.vertical(bottom: Radius.circular(25)),
                  child:
                      Image.asset('assets/images/last.png', fit: BoxFit.cover),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset('assets/icons/Vector.svg',
                              height: 16,
                              width: 16,
                              color: Colors.white.withOpacity(0.5)),
                          const SizedBox(width: 10),
                          Text('Общий баланс',
                              style: GoogleFonts.manrope(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white.withOpacity(0.5))),
                        ],
                      ),
                      const SizedBox(height: 40),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('0',
                              style: GoogleFonts.manrope(
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white)),
                          const SizedBox(width: 8),
                          Text('сум',
                              style: GoogleFonts.manrope(
                                  fontSize: 40,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white.withOpacity(0.5))),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 6, horizontal: 16),
                        decoration: BoxDecoration(
                          color: const Color(0xFF4059E6).withOpacity(0.5),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text('Нет вложений, чтобы начислять прибыль',
                            style: GoogleFonts.manrope(
                                fontSize: 16, color: Colors.white)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset('assets/icons/popup.png', width: 100),
                  const SizedBox(height: 16),
                  Text('У вас пока нет вклада',
                      style: GoogleFonts.manrope(
                          fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Text(
                    'Вы ничего не зарабатываете, \nпотому что пока нет вложений',
                    style: GoogleFonts.manrope(
                        fontSize: 16, color: Colors.black54),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4059E6),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 12),
                    ),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => DepositInfoPage()));
                    },
                    child: Text('Добавить вклад',
                        style: GoogleFonts.manrope(
                            fontSize: 18, color: Colors.white)),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
// test