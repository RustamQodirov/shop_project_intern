import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfitCalculator {
  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      backgroundColor: Colors.white,
      builder: (BuildContext context) {
        return const ProfitCalculatorContent();
      },
    );
  }
}

class ProfitCalculatorContent extends StatefulWidget {
  const ProfitCalculatorContent({super.key});

  @override
  State<ProfitCalculatorContent> createState() =>
      _ProfitCalculatorContentState();
}

class _ProfitCalculatorContentState extends State<ProfitCalculatorContent> {
  int selectedMonths = 24;
  final investmentAmount = 10000000;
  final profitRates = {12: 1200000, 18: 2000000, 24: 2700000};

  @override
  Widget build(BuildContext context) {
    final profit = profitRates[selectedMonths] ?? 0;

    return Container(
      height: 286,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              'Калькулятор прибыли',
              style: GoogleFonts.manrope(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Прибыль меняется в зависимости от срока вклада',
            textAlign: TextAlign.center,
            style: GoogleFonts.manrope(
              fontSize: 14,
              color: const Color(0xFF828DA1),
            ),
          ),
          const SizedBox(height: 20),
          _buildDurationSelector(),
          const SizedBox(height: 20),
          _buildProfitDisplay(profit),
        ],
      ),
    );
  }

  Widget _buildDurationSelector() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        DurationBox(
          duration: '12 мес',
          isSelected: selectedMonths == 12,
          onTap: () => setState(() => selectedMonths = 12),
        ),
        DurationBox(
          duration: '18 мес',
          isSelected: selectedMonths == 18,
          onTap: () => setState(() => selectedMonths = 18),
        ),
        DurationBox(
          duration: '24 мес',
          isSelected: selectedMonths == 24,
          onTap: () => setState(() => selectedMonths = 24),
        ),
      ],
    );
  }

  Widget _buildProfitDisplay(int profit) {
    return Stack(
      alignment: Alignment.center,
      clipBehavior: Clip.none,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: _buildInfoBox('Если вложить', '$investmentAmount сум',
                  isInvestment: true),
            ),
            const SizedBox(width: 16), // Increased spacing for overlapping effect
            Expanded(
              child: _buildInfoBox('Ваша прибыль', '+$profit сум',
                  isProfit: true),
            ),
          ],
        ),
        Positioned(
          left: 0,
          right: 0,
          child: Container(
            width: 30, 
            height: 30,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              border: Border.all(
                color: const Color(0xFFD0D5DD).withOpacity(0.1), // Lighter grey border
                width: 2, // Border thickness
              ),
            ),
            child: const Center(
              child: Icon(Icons.arrow_forward, color: Colors.grey),
            ),
          ),
        ),


      ],
    );
  }

  Widget _buildInfoBox(String title, String value,
      {bool isProfit = false, bool isInvestment = false}) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: isInvestment ? const Color(0xFF3680FF) : const Color(0xFFE8ECF2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.manrope(
              fontSize: 12,
              color: const Color(0xFF828DA1),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: GoogleFonts.manrope(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: isProfit ? Colors.green : Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}

class DurationBox extends StatelessWidget {
  final String duration;
  final bool isSelected;
  final VoidCallback onTap;

  const DurationBox({
    Key? key,
    required this.duration,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(right: 12),
        width: 81,
        height: 45,
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFF3680FF).withOpacity(0.07)
              : const Color(0xFFF5F7FA),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected
                ? const Color(0xFF3680FF)
                : const Color(0xFF828DA1).withOpacity(0.06),
            width: 2,
          ),
        ),
        alignment: Alignment.center,
        child: Text(
          duration,
          style: GoogleFonts.manrope(
            color: isSelected ? const Color(0xFF040415) : const Color(0xFF828DA1),
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
