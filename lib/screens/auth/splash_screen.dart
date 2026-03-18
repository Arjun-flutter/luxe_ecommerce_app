import 'package:flutter/material.dart';
import '../../core/utils/responsive.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Responsive().init(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF020617) : Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'LUXE',
              style: TextStyle(
                fontSize: Responsive.setSp(48),
                fontWeight: FontWeight.w900,
                letterSpacing: 12,
                color: isDark ? Colors.white : Colors.black,
              ),
            ),
            SizedBox(height: Responsive.setHeight(20)),
            const CircularProgressIndicator(
              color: Color(0xFF3B82F6),
              strokeWidth: 2,
            ),
          ],
        ),
      ),
    );
  }
}
