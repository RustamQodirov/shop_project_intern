import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CardsListBottomSheet {
  static void cardsBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      backgroundColor: Colors.white,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
            top: 24,
            bottom: MediaQuery.of(context).viewInsets.bottom + 24,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  const SizedBox(width: 12),
                  Text(
                    'Пополнить с помощью',
                    style: GoogleFonts.manrope(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              _buildPaymentOption(
                icon: Icons.account_balance,
                title: 'Банковский перевод',
                subtitle: 'Перевод на счёт',
              ),
              const SizedBox(height: 12),
              _buildCardOption(
                title: '** 6289',
                subtitle: 'Humo',
                backgroundColor: Colors.green,
                label: 'IPK YL',
                selected: true,
              ),
              _buildCardOption(
                title: '** 8932',
                subtitle: 'Uzcard • Карта заблокирована',
                backgroundColor: Colors.grey,
                label: 'TBC',
                subtitleColor: Colors.red,
                disabled: true,
              ),
              _buildCardOption(
                title: '** 8611',
                subtitle: 'Visa',
                backgroundColor: const Color(0xFF4059E6),
                label: '*8611',
              ),
              const SizedBox(height: 12),
              _buildAddCardOption(),
              const SizedBox(height: 24),
              _buildSelectButton(context),
            ],
          ),
        );
      },
    );
  }

  static Widget _buildPaymentOption({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return ListTile(
      leading: Container(
        width: 65,
        height: 45,
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: const Color(0xFF040415)),
      ),
      title: Text(
        title,
        style: GoogleFonts.manrope(
          fontSize: 17,
          fontWeight: FontWeight.w500,
          color: Colors.black,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: GoogleFonts.manrope(
          fontSize: 15,
          color: Colors.grey,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: const Icon(Icons.chevron_right, color: Colors.grey),
    );
  }

  static Widget _buildCardOption({
    required String title,
    required String subtitle,
    required Color backgroundColor,
    required String label,
    Color? subtitleColor,
    bool selected = false,
    bool disabled = false,
  }) {
    return Opacity(
      opacity: disabled ? 0.5 : 1.0,
      child: ListTile(
        leading: Container(
          width: 65,
          height: 45,
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(8),
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: GoogleFonts.manrope(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
        title: Text(
          title,
          style: GoogleFonts.manrope(
            fontSize: 17,
            fontWeight: FontWeight.w500,
            color: const Color(0xFF040415),
          ),
        ),
        subtitle: Text(
          subtitle,
          style: GoogleFonts.manrope(
            fontSize: 14,
            color: subtitleColor ?? Colors.grey,
          ),
        ),
        trailing: selected
            ? const Icon(Icons.radio_button_checked, color: Color(0xFF4059E6))
            : const Icon(Icons.radio_button_unchecked, color: Colors.grey),
      ),
    );
  }

  static Widget _buildAddCardOption() {
    return ListTile(
      leading: Container(
        width: 65,
        height: 45,
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: BorderRadius.circular(8),
        ),
        alignment: Alignment.center,
        child: const Icon(Icons.add, color: Colors.black),
      ),
      title: Text(
        'Добавить новую карту',
        style: GoogleFonts.manrope(
          fontSize: 17,
          fontWeight: FontWeight.w600,
          color: Color(0xFF040415),
        ),
      ),
      subtitle: Text(
        'Карта для пополнения',
        style: GoogleFonts.manrope(fontSize: 14, color: Colors.grey),
      ),
      trailing: const Icon(Icons.chevron_right, color: Colors.grey),
    );
  }

  static Widget _buildSelectButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF4059E6),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(vertical: 14),
        ),
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: Text(
          'Выбрать для оплаты',
          style: GoogleFonts.manrope(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
