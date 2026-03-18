import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth.dart';
import '../../widgets/auth/auth_text_field.dart';
import '../../core/utils/responsive.dart';
import 'login_screen.dart';

class SignupScreen extends StatefulWidget {
  static const routeName = '/signup';

  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  final Map<String, String> _authData = {
    'email': '',
    'password': '',
  };

  var _isLoading = false;
  var _isPasswordVisible = false;
  var _isConfirmPasswordVisible = false;

  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: Theme.of(context).brightness == Brightness.dark
            ? const Color(0xFF121212)
            : Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: const Text('Signup Error'),
        content: Text(message),
        actions: [
          TextButton(
            child: const Text('Okay'),
            onPressed: () => Navigator.of(ctx).pop(),
          )
        ],
      ),
    );
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    _formKey.currentState!.save();

    setState(() => _isLoading = true);

    try {
      await Provider.of<Auth>(context, listen: false).signup(
        _authData['email']!,
        _authData['password']!,
      );
      
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Account created successfully! Welcome.'),
          backgroundColor: Colors.green,
        ),
      );

      Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);

    } catch (error) {
      String message = 'Signup failed';
      if (error.toString().contains('Invalid credentials')) {
        message = 'Enter valid email & password';
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
                  SizedBox(height: Responsive.setHeight(50)),
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
                    'Create account.\nStart your journey with us!',
                    style: TextStyle(
                      fontSize: Responsive.setSp(24),
                      fontWeight: FontWeight.w600,
                      color: isDark ? Colors.white70 : Colors.black54,
                      height: 1.2,
                    ),
                  ),
                  SizedBox(height: Responsive.setHeight(30)),
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
                          onToggle: () => setState(() => _isPasswordVisible = !_isPasswordVisible),
                          controller: _passwordController,
                          onSaved: (value) => _authData['password'] = value!,
                          validator: (value) {
                            if (value == null || value.length < 6) {
                              return 'Password must be at least 6 characters';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: Responsive.setHeight(16)),
                        AuthTextField(
                          label: 'Confirm Password',
                          icon: Icons.lock_reset_rounded,
                          isPassword: true,
                          isVisible: _isConfirmPasswordVisible,
                          showVisibilityToggle: true,
                          onToggle: () => setState(() => _isConfirmPasswordVisible = !_isConfirmPasswordVisible),
                          validator: (value) {
                            if (value != _passwordController.text) {
                              return 'Passwords do not match!';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: Responsive.setHeight(32)),
                        SizedBox(
                          width: double.infinity,
                          height: Responsive.setHeight(56),
                          child: ElevatedButton(
                            onPressed: _isLoading ? null : _submit,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: isDark ? Colors.white : const Color(0xFF1E293B),
                              foregroundColor: isDark ? Colors.black : Colors.white,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
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
                                    'Create Account',
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
                            Text(
                              'Already have an account? ',
                              style: TextStyle(
                                color: isDark ? Colors.white60 : Colors.black54,
                                fontSize: Responsive.setSp(14),
                              ),
                            ),
                            GestureDetector(
                              onTap: () => Navigator.of(context).pushReplacementNamed(LoginScreen.routeName),
                              child: Text(
                                'Sign In',
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
