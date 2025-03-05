import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:shop/features/investment/home/presentation/widgets/cards_list_bottomsheet.dart';

class FillTheAmount extends StatefulWidget {
  const FillTheAmount({super.key});

  @override
  State<FillTheAmount> createState() => _FillTheAmountState();
}

class _FillTheAmountState extends State<FillTheAmount> {
  final TextEditingController _controller = TextEditingController(text: "0");
  final NumberFormat numberFormat = NumberFormat("#,###", "ru_RU");

  String _formatNumber(String value) {
    value = value.replaceAll(RegExp(r'\D'), '');
    if (value.isEmpty) return '0';
    return numberFormat.format(int.parse(value)).replaceAll(',', ' ');
  }

  void _validateAmount() {
    final int amount = int.tryParse(_controller.text.replaceAll(' ', '')) ?? 0;
    if (amount < 500000) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Минимум 500 000 сум. Увеличьте сумму платежа"),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
        ),
      );
    } else {
      // Proceed with the transaction
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _AppBar(),
              const SizedBox(height: 20),
              _SelectionTile(
                title: 'Откуда',
                value: 'Humo •• 8929',
                onTap: () {
                  CardsListBottomSheet.cardsBottomSheet(context);
                },
              ),
              const SizedBox(height: 10),
              const _SelectionTile(
                title: 'Куда',
                value: 'Машина',
                trailing: '139 012 983 сум',
                showArrow: false,
              ),
              const SizedBox(height: 20),
              _AmountInput(
                  controller: _controller, formatNumber: _formatNumber),
              const SizedBox(height: 8),
              Center(
                child: Text(
                  'Минимум 500 000 сум',
                  style: GoogleFonts.manrope(
                    fontSize: 14,
                    color: const Color(0xFF828DA1),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _validateAmount,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF3D7BF6),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'Пополнить',
                    style: GoogleFonts.manrope(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
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

class _AppBar extends StatelessWidget {
  const _AppBar();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        const Spacer(),
        Text(
          'Пополнение вклада',
          style: GoogleFonts.manrope(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        const Spacer(),
      ],
    );
  }
}

class _SelectionTile extends StatelessWidget {
  final String title;
  final String value;
  final String? trailing;
  final bool showArrow;
  final VoidCallback? onTap;

  const _SelectionTile({
    required this.title,
    required this.value,
    this.trailing,
    this.showArrow = true,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        height: 70,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFF828DA1).withOpacity(0.1)),
          color: const Color(0xFF828DA1).withOpacity(0.06),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.manrope(
                    fontSize: 14,
                    color: const Color(0xFF828DA1),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: GoogleFonts.manrope(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                if (trailing != null)
                  Text(
                    trailing!,
                    style: GoogleFonts.manrope(
                        fontSize: 14, color: const Color(0xFF828DA1)),
                  ),
                if (showArrow) ...[
                  const SizedBox(width: 10),
                  const Icon(Icons.arrow_forward_ios, color: Colors.black),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _AmountInput extends StatelessWidget {
  final TextEditingController controller;
  final String Function(String) formatNumber;

  const _AmountInput({
    required this.controller,
    required this.formatNumber,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            ValueListenableBuilder<TextEditingValue>(
              valueListenable: controller,
              builder: (context, value, child) {
                String formattedText = formatNumber(value.text);
                return RichText(
                  text: TextSpan(
                    text: formattedText,
                    style: GoogleFonts.manrope(
                      fontSize: 32,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                    children: [
                      TextSpan(
                        text: ' сум',
                        style: GoogleFonts.manrope(
                          fontSize: 32,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF828DA1).withOpacity(0.5),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            TextField(
              controller: controller,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.transparent),
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              onChanged: (value) {
                String formatted = formatNumber(value);
                controller.value = TextEditingValue(
                  text: formatted.replaceAll(' ', ''),
                  selection: TextSelection.collapsed(offset: formatted.length),
                );
              },
              decoration: const InputDecoration(border: InputBorder.none),
              cursorColor: Colors.black,
            ),
          ],
        ),
        const Divider(thickness: 1),
      ],
    );
  }
}
