class Investment {
  final String guid;
  final int position;
  final int investmentAmount;
  final int investmentAmountUsd;
  final String investmentStatus;
  final String currency;
  final String? title;
  final int lastMonthProfitAmount;
  final int lastMonthProfitStartBalance;
  final String lastMonthProfitMonth;

  Investment({
    required this.guid,
    required this.position,
    required this.investmentAmount,
    required this.investmentAmountUsd,
    required this.investmentStatus,
    required this.currency,
    this.title,
    required this.lastMonthProfitAmount,
    required this.lastMonthProfitStartBalance,
    required this.lastMonthProfitMonth,
  });

  factory Investment.fromJson(Map<String, dynamic> json) {
    return Investment(
      guid: json['guid'],
      position: json['position'],
      investmentAmount: json['investment_amount'],
      investmentAmountUsd: json['investment_amount_usd'],
      investmentStatus: json['investment_status'],
      currency: json['currency'],
      title: json['goal']['title'] as String?, // Extract title from goal
      lastMonthProfitAmount: json['last_month_profit']['amount'],
      lastMonthProfitStartBalance: json['last_month_profit']['start_balance'],
      lastMonthProfitMonth: json['last_month_profit']['month'],
    );
  }
}