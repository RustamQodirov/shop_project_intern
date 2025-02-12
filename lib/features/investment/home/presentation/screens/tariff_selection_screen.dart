import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class TariffSelectionPage extends StatefulWidget {
  @override
  _TariffSelectionPageState createState() => _TariffSelectionPageState();
}

class _TariffSelectionPageState extends State<TariffSelectionPage> {
  String _selectedCurrency = 'UZ';
  String _selectedDuration = '24 мес';
  bool _isProfitReinvested = true;

  @override
  Widget build(BuildContext context) {
    bool isDollarSelected = _selectedCurrency == 'USD';

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Выбор тарифа',
          style: GoogleFonts.manrope(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ...['UZ', 'USD'].map((currency) {
              final isUZ = currency == 'UZ';
              return GestureDetector(
                onTap: () => setState(() => _selectedCurrency = currency),
                child: Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF5F7FA),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    leading: Image.asset(
                      isUZ ? 'assets/images/uz.png' : 'assets/images/eng.png',
                      width: 40,
                    ),
                    title: Text(
                      isUZ ? 'Копить в сумах' : 'Копить в долларах',
                      style: GoogleFonts.manrope(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    subtitle: Text(
                      isUZ ? 'Партнерство 99%' : 'Партнерство 90%',
                      style:
                      GoogleFonts.manrope(color: const Color(0xFF828DA1)),
                    ),
                    trailing: Radio<String>(
                      value: currency,
                      groupValue: _selectedCurrency,
                      onChanged: (value) =>
                          setState(() => _selectedCurrency = value!),
                      activeColor: const Color(0xFF3680FF),
                    ),
                  ),
                ),
              );
            }),
            const SizedBox(height: 10),
            Row(
              children: isDollarSelected
                  ? [
                _buildDurationBox('12 мес', isSelected: true),
              ]
                  : ['12 мес', '18 мес', '24 мес']
                  .map((duration) => _buildDurationBox(duration,
                  isSelected: _selectedDuration == duration))
                  .toList(),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Оставлять прибыль на вкладе',
                      style: GoogleFonts.manrope(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      'Дивиденды реинвестируются\nдля увеличения прибыли',
                      style: GoogleFonts.manrope(
                        color: const Color(0xFF828DA1),
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                Switch(
                  value: _isProfitReinvested,
                  onChanged: (value) =>
                      setState(() => _isProfitReinvested = value),
                  activeColor: const Color(0xFF3680FF),
                  activeTrackColor: const Color(0xFF3680FF),
                  inactiveTrackColor: const Color(0xFFFFFFFF),
                  inactiveThumbColor: const Color(0xFF3680FF),
                  thumbColor: MaterialStateProperty.resolveWith(
                        (states) => states.contains(MaterialState.selected)
                        ? Colors.white
                        : const Color(0xFF3680FF),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Container(
              height: 136,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFF8F8F9),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        isDollarSelected ? '~12%' : '~54%',
                        style: GoogleFonts.manrope(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF3680FF),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'за весь срок',
                        style: GoogleFonts.manrope(color: const Color(0xFF828DA1)),
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            barrierDismissible: true, // Close when tapping outside
                            builder: (BuildContext context) {
                              return Dialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                insetPadding: const EdgeInsets.symmetric(horizontal: 24),
                                // Controls dialog width
                                child: Container(
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(18),
                                  ),
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
                                          SizedBox(
                                            width: 8,
                                          ),
                                          Image.asset(
                                            'assets/images/eng.png',
                                            width: 35,
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 16,
                                      ),
                                      Text(
                                        'Чем отличаются тарифы?',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      Text(
                                        'Вы можете открыть вклад в узбекских сумах со ставкой до ~27% в год или в долларах США со ставкой ~13%',
                                        style: GoogleFonts.manrope(
                                          fontSize: 14,
                                          color: const Color(0xFF828DA1),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 25,
                                      ),
                                      Text(
                                        'Что значит «Партнёрство 99%»?',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      Text(
                                        '99% прибыли с оборота идёт вам, 1% получаем мы',
                                        style: GoogleFonts.manrope(
                                            fontSize: 14, color: const Color(0xFF828DA1)),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        child: const Icon(Icons.info_outline, color: Color(0xFF828DA1)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Если вложить',
                            style: GoogleFonts.manrope(color: const Color(0xFF828DA1)),
                          ),
                          Text(
                            isDollarSelected ? '\$1000' : '1 000 000 сум',
                            style: GoogleFonts.manrope(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'Ваша прибыль',
                            style: GoogleFonts.manrope(color: const Color(0xFF828DA1)),
                          ),
                          Text(
                            isDollarSelected ? '~\$120' : '+540 000',
                            style: GoogleFonts.manrope(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFF8F8F9),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      SvgPicture.asset(
                        'assets/images/financial_svg.svg',
                        width: 35,
                        height: 35,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Выбери сумму для инвестиций',
                        style: GoogleFonts.manrope(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Ваш инвестиционный бюджет может быть увеличен на дополнительных ставках.',
                    style: GoogleFonts.manrope(
                      color: const Color(0xFF828DA1),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF3680FF),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {},
                child: Text(
                  'Открыть вклад',
                  style: GoogleFonts.manrope(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Center(
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: GoogleFonts.manrope(color: const Color(0xFF828DA1)),
                  children: [
                    const TextSpan(text: 'Открывая вклад, вы соглашаетесь\nс '),
                    TextSpan(
                      text: 'условиями',
                      style: GoogleFonts.manrope(color: const Color(0xFF3680FF)),
                    ),
                    const TextSpan(text: ' и '),
                    TextSpan(
                      text: 'оффертой',
                      style: GoogleFonts.manrope(color: const Color(0xFF3680FF)),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDurationBox(String duration, {required bool isSelected}) {
    return GestureDetector(
      onTap: () => setState(() => _selectedDuration = duration),
      child: Container(
        margin: const EdgeInsets.only(right: 10),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: const Color(0xFFF8F8F9),
          borderRadius: BorderRadius.circular(12),
          border: isSelected
              ? Border.all(color: const Color(0xFF3680FF), width: 1.5)
              : Border.all(color: Colors.transparent),
        ),
        child: Center(
          child: Text(
            duration,
            style: GoogleFonts.manrope(
              color: isSelected ? const Color(0xFF3680FF) : const Color(0xFF828DA1),
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
