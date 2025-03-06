import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shop/features/investment/home/data/model/investment_model.dart';
import 'package:shop/features/investment/home/presentation/bloc/investment_cubit.dart';
import 'package:shop/features/investment/home/presentation/bloc/investment_state.dart';
import 'package:shop/features/investment/home/presentation/screens/deposit_info.dart';
import 'package:shop/features/investment/home/presentation/widgets/bottom_navbar_invest.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class InvestHomePage extends StatefulWidget {
  @override
  _InvestHomePageState createState() => _InvestHomePageState();
}

class _InvestHomePageState extends State<InvestHomePage> {
  int _selectedIndex = 0;
  bool _isBalanceVisible = true;

  @override
  void initState() {
    super.initState();
    context.read<InvestmentCubit>().fetchInvestments();
  }

  void _toggleBalanceVisibility() {
    setState(() {
      _isBalanceVisible = !_isBalanceVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: (index) => setState(() => _selectedIndex = index),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // HEADER SECTION
            Container(
              width: double.infinity,
              height: 270,
              decoration: const BoxDecoration(
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(25)),
              ),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                        bottom: Radius.circular(25)),
                    child: Image.asset('assets/images/last.png',
                        fit: BoxFit.cover),
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
                            IconButton(
                              icon: Image.asset(
                                _isBalanceVisible
                                    ? 'assets/icons/off.png'
                                    : 'assets/icons/on.png',
                                height: 30,
                                width: 30,
                                color: Colors.white,
                              ),
                              onPressed: _toggleBalanceVisibility,
                            ),
                            Text(
                              _isBalanceVisible ? '0 сум' : 'Показать баланс',
                              style: GoogleFonts.manrope(
                                  fontSize: 29,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white),
                            ),
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
                          child: Text(
                            'Нет вложений, чтобы начислять прибыль',
                            style: GoogleFonts.manrope(
                                fontSize: 16, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // "Ваши вклады" (Your Deposits)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: BlocBuilder<InvestmentCubit, InvestmentState>(
                builder: (context, state) {
                  if (state is InvestmentLoading) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is InvestmentLoaded) {
                    final investments = state.investments;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Ваши вклады',
                              style: GoogleFonts.manrope(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (ctx) => DepositInfoPage()));
                              }, // Add deposit action
                              child: Text(
                                '+ Добавить',
                                style: GoogleFonts.manrope(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xFF4059E6)),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        ...investments
                            .map((investment) =>
                                InvestmentCard(investment: investment))
                            .toList(),
                      ],
                    );
                  } else if (state is InvestmentError) {
                    return Center(child: Text(state.message));
                  }
                  return Container();
                },
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class InvestmentCard extends StatelessWidget {
  final Investment investment;

  const InvestmentCard({Key? key, required this.investment}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Slidable(
        key: ValueKey(investment.guid),
        startActionPane: ActionPane(
          motion: const DrawerMotion(),
          children: [
            SlidableAction(
              onPressed: (context) {
                // Add your top-up action here
              },
              backgroundColor: const Color(0xFF4059E6).withOpacity(0.07),
              // Solid blue color
              foregroundColor: Color(0xFF4059E6),
              // White text/icon
              borderRadius: BorderRadius.circular(16),
              label: 'Пополнить',
              spacing: 10,
              autoClose: true,
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 6, right: 6),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 8,
                  spreadRadius: 2,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        shape: BoxShape.circle,
                      ),
                      child: Image.asset('assets/images/money.png',
                          height: 32, width: 32),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${investment.investmentAmount} сум',
                            style: GoogleFonts.manrope(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black.withOpacity(0.6)),
                          ),
                          Text(
                            investment.title != null &&
                                    investment.title!.isNotEmpty
                                ? investment.title!
                                : 'Без названия',
                            style: GoogleFonts.manrope(
                                fontSize: 14, color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                    Icon(Icons.arrow_forward_ios,
                        color: Colors.grey[400], size: 18),
                  ],
                ),
                const SizedBox(height: 10),
                Divider(color: Colors.grey[200], thickness: 1),
                const SizedBox(height: 10),
                Row(
                  children: [
                    if (investment.investmentAmount > 0)
                      Text(
                        'Текущий месяц: + ${investment.lastMonthProfitAmount} сум',
                        style: GoogleFonts.manrope(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.black.withOpacity(0.6)),
                      ),
                    if (investment.investmentAmount == 0)
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 6, horizontal: 12),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF93C65).withOpacity(0.2),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Text(
                          'Нет оплаты',
                          style: GoogleFonts.manrope(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFFF93C65)),
                        ),
                      ),
                    const Spacer(),
                    Row(
                      children: [
                        Image.asset('assets/images/Flags.png',
                            height: 16, width: 16),
                        const SizedBox(width: 6),
                        Text(
                          investment.currency.isEmpty
                              ? 'сум'
                              : investment.currency,
                          style: GoogleFonts.manrope(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey[600]),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
