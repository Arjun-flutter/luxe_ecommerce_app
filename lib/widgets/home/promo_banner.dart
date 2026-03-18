import 'dart:async';
import 'package:flutter/material.dart';
import '../../core/utils/responsive.dart';

class PromoBanner extends StatefulWidget {
  const PromoBanner({super.key});

  @override
  State<PromoBanner> createState() => _PromoBannerState();
}

class _PromoBannerState extends State<PromoBanner> {
  late Timer _timer;
  Duration _saleTime = const Duration(hours: 2, minutes: 45, seconds: 12);

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {
          if (_saleTime.inSeconds > 0) {
            _saleTime = _saleTime - const Duration(seconds: 1);
          } else {
            _timer.cancel();
          }
        });
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Dynamic margin based on screen width
    final double horizontalMargin = Responsive.blockSizeHorizontal * 4;
    
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: horizontalMargin, vertical: 10),
      // Set a fixed minimum height so it NEVER overlaps, even on Web
      constraints: const BoxConstraints(
        minHeight: 160, 
        maxHeight: 200,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          colors: [Color(0xFF1E293B), Color(0xFF3B82F6)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Decorative Icon
          Positioned(
            right: -10,
            bottom: -10,
            child: Icon(
              Icons.bolt_rounded,
              size: 120,
              color: Colors.white.withOpacity(0.1),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'FLASH SALE ENDS IN:',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                  ),
                ),
                const SizedBox(height: 12),
                // Timer Row
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Row(
                    children: [
                      _buildTimerBox(_saleTime.inHours.toString().padLeft(2, '0')),
                      _buildTimerDivider(),
                      _buildTimerBox((_saleTime.inMinutes % 60).toString().padLeft(2, '0')),
                      _buildTimerDivider(),
                      _buildTimerBox((_saleTime.inSeconds % 60).toString().padLeft(2, '0')),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                // Offer Text
                const FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    'UP TO 70% OFF',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 26,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimerBox(String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        value,
        style: const TextStyle(
          color: Color(0xFF1E293B),
          fontWeight: FontWeight.w900,
          fontSize: 16,
        ),
      ),
    );
  }

  Widget _buildTimerDivider() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 6),
      child: Text(
        ':',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
    );
  }
}
