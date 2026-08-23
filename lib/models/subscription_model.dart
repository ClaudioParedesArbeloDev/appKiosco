class SubscriptionModel {
  const SubscriptionModel({
    required this.status,
    required this.billingCycle,
    this.trialEndsAt,
    this.currentPeriodEndsAt,
    this.gracePeriodEndsAt,
    required this.planName,
    required this.planMonthlyPrice,
    required this.planAnnualPrice,
  });

  final String status;
  final String billingCycle;
  final DateTime? trialEndsAt;
  final DateTime? currentPeriodEndsAt;
  final DateTime? gracePeriodEndsAt;
  final String planName;

  /// Precios en centavos, como todo el dinero en Code & Lens.
  final int planMonthlyPrice;
  final int planAnnualPrice;

  bool get isTrialing => status == 'trialing';
  bool get isActive => status == 'active';
  bool get isPastDue => status == 'past_due';
  bool get isExpired => status == 'expired';
  bool get isCanceled => status == 'canceled';

  /// Si hay que ofrecerle a este comercio el botón de pagar.
  bool get needsPayment => isTrialing || isPastDue || isExpired;

  double get monthlyPriceInPesos => planMonthlyPrice / 100;
  double get annualPriceInPesos => planAnnualPrice / 100;

  /// Días hasta que se vence el trial, o hasta que se agota la gracia,
  /// o hasta el próximo cobro si ya está activa. Null si no aplica.
  int? get daysRemaining {
    final DateTime? reference = switch (status) {
      'trialing' => trialEndsAt,
      'past_due' => gracePeriodEndsAt,
      'active' => currentPeriodEndsAt,
      _ => null,
    };

    if (reference == null) return null;
    return reference.difference(DateTime.now()).inDays;
  }

  factory SubscriptionModel.fromJson(Map<String, dynamic> json) {
    final plan = json['plan'] as Map<String, dynamic>;

    DateTime? parseDate(dynamic value) => value == null ? null : DateTime.parse(value as String);

    return SubscriptionModel(
      status: json['status'] as String,
      billingCycle: json['billing_cycle'] as String,
      trialEndsAt: parseDate(json['trial_ends_at']),
      currentPeriodEndsAt: parseDate(json['current_period_ends_at']),
      gracePeriodEndsAt: parseDate(json['grace_period_ends_at']),
      planName: plan['name'] as String,
      planMonthlyPrice: plan['monthly_price'] as int,
      planAnnualPrice: plan['annual_price'] as int,
    );
  }
}
