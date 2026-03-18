import 'package:flutter/material.dart';

class Auth with ChangeNotifier {
  String? _token;
  String? _userId;

  bool get isAuth {
    return _token != null;
  }

  Future<void> signup(String email, String password) async {
    await Future.delayed(const Duration(seconds: 1));
    if (!email.contains('@') || password.length < 6) {
      throw Exception('Invalid credentials');
    }
    // Auto-login after successful signup
    _token = 'dummy_token';
    _userId = 'u1';
    notifyListeners();
  }

  Future<void> login(String email, String password) async {
    await Future.delayed(const Duration(seconds: 1));
    if (password == '123456') {
      throw Exception('Invalid password');
    }
    _token = 'dummy_token';
    _userId = 'u1';
    notifyListeners();
  }

  void logout() {
    _token = null;
    _userId = null;
    notifyListeners();
  }
}
