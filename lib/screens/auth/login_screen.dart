import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth.dart';
import '../../widgets/auth/auth_text_field.dart';
import '../../widgets/auth/social_auth_button.dart';
import '../../core/utils/responsive.dart';
import 'signup_screen.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/login';

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  final Map<String, String> _authData = {'email': '', 'password': ''};

  var _isLoading = false;
  var _isPasswordVisible = false;

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: Theme.of(context).brightness == Brightness.dark
            ? const Color(0xFF121212)
            : Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('Login Error'),
        content: Text(message),
        actions: [
          TextButton(
            child: const Text('Okay'),
            onPressed: () => Navigator.of(ctx).pop(),
          ),
        ],
      ),
    );
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    _formKey.currentState!.save();

    setState(() => _isLoading = true);

    try {
      await Provider.of<Auth>(
        context,
        listen: false,
      ).login(_authData['email']!, _authData['password']!);

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Login successful!'),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
      
    } catch (error) {
      String message = 'Login failed';
      if (error.toString().contains('Invalid password')) {
        message = 'Wrong password';
      }
      _showErrorDialog(message);
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Responsive().init(context);

    final isDark = Theme.of(context).brightness == Brightness.dark;
    final indicatorSize = Responsive.setSp(24);

    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            color: isDark ? Colors.black : Colors.white,
          ),
          SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: Responsive.setWidth(30)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: Responsive.setHeight(60)),
                  Text(
                    'LUXE',
                    style: TextStyle(
                      fontSize: Responsive.setSp(40),
                      fontWeight: FontWeight.w900,
                      letterSpacing: 8,
                      color: isDark ? Colors.white : Colors.black,
                    ),
                  ),
                  SizedBox(height: Responsive.setHeight(10)),
                  Text(
                    'Welcome back.\nYou\'ve been missed!',
                    style: TextStyle(
                      fontSize: Responsive.setSp(24),
                      fontWeight: FontWeight.w600,
                      color: isDark ? Colors.white70 : Colors.black54,
                      height: 1.2,
                    ),
                  ),
                  SizedBox(height: Responsive.setHeight(50)),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        AuthTextField(
                          label: 'Email Address',
                          icon: Icons.email_outlined,
                          keyboardType: TextInputType.emailAddress,
                          onSaved: (value) => _authData['email'] = value!,
                          validator: (value) {
                            if (value == null || !RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                              return 'Enter a valid email';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: Responsive.setHeight(16)),
                        AuthTextField(
                          label: 'Password',
                          icon: Icons.lock_outline_rounded,
                          isPassword: true,
                          isVisible: _isPasswordVisible,
                          showVisibilityToggle: true,
                          onToggle: () => setState(
                            () => _isPasswordVisible = !_isPasswordVisible,
                          ),
                          onSaved: (value) => _authData['password'] = value!,
                          validator: (value) {
                            if (value == null || value.length < 6) {
                              return 'Password must be at least 6 characters';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: Responsive.setHeight(40)),
                        SizedBox(
                          width: double.infinity,
                          height: Responsive.setHeight(56),
                          child: ElevatedButton(
                            onPressed: _isLoading ? null : _submit,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: isDark ? Colors.white : const Color(0xFF1E293B),
                              foregroundColor: isDark ? Colors.black : Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                            child: _isLoading
                                ? SizedBox(
                                    height: indicatorSize,
                                    width: indicatorSize,
                                    child: CircularProgressIndicator(
                                      color: isDark ? Colors.black : Colors.blue,
                                      strokeWidth: 2.5,
                                    ),
                                  )
                                : Text(
                                    'Sign In',
                                    style: TextStyle(
                                      fontSize: Responsive.setSp(16),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                          ),
                        ),
                        SizedBox(height: Responsive.setHeight(32)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SocialAuthButton(
                              icon: Icons.g_mobiledata_rounded,
                              onTap: () {},
                            ),
                            SizedBox(width: Responsive.setWidth(20)),
                            SocialAuthButton(
                              icon: Icons.apple_rounded,
                              onTap: () {},
                            ),
                          ],
                        ),
                        SizedBox(height: Responsive.setHeight(40)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Don\'t have an account? ',
                              style: TextStyle(
                                color: isDark ? Colors.white60 : Colors.black54,
                                fontSize: Responsive.setSp(14),
                              ),
                            ),
                            GestureDetector(
                              onTap: () => Navigator.of(
                                context,
                              ).pushReplacementNamed(SignupScreen.routeName),
                              child: Text(
                                'Sign Up',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xFF3B82F6),
                                  fontSize: Responsive.setSp(14),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
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
