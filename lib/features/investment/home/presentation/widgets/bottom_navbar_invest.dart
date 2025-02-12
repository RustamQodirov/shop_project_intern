import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onItemTapped;

  const CustomBottomNavBar({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          height: 100,
          decoration: const BoxDecoration(
            color: Colors.white,
            boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
          ),
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 21),
          child: BottomNavigationBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            currentIndex: selectedIndex,
            onTap: onItemTapped,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: const Color(0xFF4059E6),
            unselectedItemColor: Colors.black,
            selectedFontSize: 14,
            unselectedFontSize: 12,
            items: [
              _navItem('assets/icons/home_invest.svg', 'Dashboard', 0),
              _navItem('assets/icons/transaction.svg', 'Transfers', 1),
              const BottomNavigationBarItem(icon: SizedBox.shrink(), label: ''),
              _navItem('assets/icons/chat.svg', 'Chat', 3),
              _navItem('assets/icons/store_invest.svg', 'Stores', 4),
            ],
          ),
        ),
        Positioned(bottom: 25, child: _qrButton()),
      ],
    );
  }

  BottomNavigationBarItem _navItem(String iconPath, String label, int index) {
    return BottomNavigationBarItem(
      icon: SvgPicture.asset(
        iconPath,
        color: selectedIndex == index ? const Color(0xFF4059E6) : Colors.black,
        height: 22,
        width: 22,
      ),
      label: label,
    );
  }

  Widget _qrButton() {
    return CircleAvatar(
      radius: 35,
      backgroundColor: const Color(0xFFEBEEFF),
      child: SvgPicture.asset(
        'assets/icons/qr.svg',
        color: Colors.black,
        height: 30,
        width: 30,
      ),
    );
  }
}
