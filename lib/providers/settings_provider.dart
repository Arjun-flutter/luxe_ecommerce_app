import 'package:flutter/material.dart';

class SettingsProvider with ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;
  String _currency = 'USD (\$)';
  bool _notificationsEnabled = true;

  ThemeMode get themeMode => _themeMode;
  String get currency => _currency;
  bool get notificationsEnabled => _notificationsEnabled;

  double get conversionRate {
    if (_currency == 'INR (₹)') return 83.0; // Sample rate
    return 1.0;
  }

  String get currencySymbol {
    return _currency == 'INR (₹)' ? '₹' : '\$';
  }

  String formatPrice(double price) {
    final convertedPrice = price * conversionRate;
    return '$currencySymbol${convertedPrice.toStringAsFixed(2)}';
  }

  void toggleTheme(bool isDark) {
    _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  void setCurrency(String newCurrency) {
    _currency = newCurrency;
    notifyListeners();
  }

  void toggleNotifications(bool value) {
    _notificationsEnabled = value;
    notifyListeners();
  }
}
