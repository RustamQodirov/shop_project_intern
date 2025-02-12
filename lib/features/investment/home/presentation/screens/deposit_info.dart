import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shop/features/investment/home/presentation/screens/tariff_selection_screen.dart';

class DepositInfoPage extends StatelessWidget {
  const DepositInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    Widget buildInfoRow(String iconPath, String title, String description) {
      return Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFFEFF3FA),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Center(child: Image.asset(iconPath, width: 26, height: 26)),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: GoogleFonts.manrope(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Colors.black87)),
                const SizedBox(height: 6),
                Text(description,
                    style: GoogleFonts.manrope(
                        fontSize: 14, color: Colors.black54)),
              ],
            ),
          ),
        ],
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF4F8FF),
      body: Column(
        children: [
          Stack(
            children: [
              const SizedBox(
                height: 320,
                width: double.infinity,
                child: Image(
                    image: AssetImage('assets/icons/add_ban.png'),
                    fit: BoxFit.cover),
              ),
              Positioned(
                top: 50,
                left: 8,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ],
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('О вкладе',
                      style: GoogleFonts.manrope(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Colors.black87)),
                  const SizedBox(height: 20),
                  buildInfoRow('assets/icons/1.png', 'До 27% годовых',
                      'Ставка без дополнительных условий, трат и скрытых условий'),
                  const SizedBox(height: 20),
                  buildInfoRow('assets/icons/2.png', 'Выплачиваем каждый месяц',
                      'Получайте прибыль каждый месяц первого числа'),
                  const SizedBox(height: 20),
                  buildInfoRow('assets/icons/3.png', 'Помогаете людям',
                      'Средства идут на помощь людям получать товары и услуги без нагрузок на финансовое состояние (Риба)'),
                  const SizedBox(height: 20),
                  buildInfoRow('assets/icons/4.png', 'Пополняйте когда угодно',
                      'Вы можете пополнять вклад в любой момент, увеличивая вашу прибыль'),
                  const Spacer(),
                  SizedBox(
                    width: double.infinity,
                    height: 54,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF4D8CFE),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14)),
                      ),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (_)=>TariffSelectionPage()));
                      },
                      child: Text('Продолжить',
                          style: GoogleFonts.manrope(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w700)),
                    ),
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
