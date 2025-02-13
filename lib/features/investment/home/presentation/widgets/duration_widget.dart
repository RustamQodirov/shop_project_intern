import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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