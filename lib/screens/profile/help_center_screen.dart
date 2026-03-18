import 'package:flutter/material.dart';

class HelpCenterScreen extends StatelessWidget {
  static const routeName = '/help-center';

  const HelpCenterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark
          ? const Color(0xFF020617)
          : const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: const Text('Help Center'),
        backgroundColor: isDark ? const Color(0xFF0F172A) : Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text(
            'Frequently Asked Questions',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          _buildFaqItem(
            'How can I track my order?',
            'You can track your order in the "My Orders" section of your profile.',
          ),
          _buildFaqItem(
            'What is the return policy?',
            'We offer a 30-day return policy for all premium items.',
          ),
          _buildFaqItem(
            'How do I use promo codes?',
            'Enter the code at the checkout screen in your bag.',
          ),
          _buildFaqItem(
            'Is international shipping available?',
            'Yes, we ship to over 50 countries worldwide.',
          ),

          const SizedBox(height: 40),
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF1E293B) : Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                const Icon(
                  Icons.headset_mic_rounded,
                  size: 50,
                  color: Color(0xFF3B82F6),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Still need help?',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Our support team is available 24/7',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Connecting to Live Chat...'),
                        ),
                      );
                    },
                    child: const Text('Start Live Chat'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFaqItem(String question, String answer) {
    return ExpansionTile(
      title: Text(
        question,
        style: const TextStyle(fontWeight: FontWeight.w600),
      ),
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          child: Text(
            answer,
            style: const TextStyle(color: Colors.grey, height: 1.5),
          ),
        ),
      ],
    );
  }
}
