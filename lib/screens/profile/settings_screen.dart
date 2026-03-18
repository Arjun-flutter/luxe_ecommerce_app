import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/settings_provider.dart';
import 'help_center_screen.dart';

class SettingsScreen extends StatefulWidget {
  static const routeName = '/settings';

  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _biometricsEnabled = false;

  @override
  Widget build(BuildContext context) {
    final settings = Provider.of<SettingsProvider>(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark
          ? const Color(0xFF020617)
          : const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: isDark ? const Color(0xFF0F172A) : Colors.white,
      ),
      body: ListView(
        children: [
          _buildSectionHeader('Security'),
          _buildSwitchTile(
            Icons.fingerprint_rounded,
            'Biometric Login',
            'Use FaceID or Fingerprint to secure your account',
            _biometricsEnabled,
            (val) => setState(() => _biometricsEnabled = val),
          ),

          _buildSectionHeader('Preferences'),
          _buildSwitchTile(
            Icons.notifications_active_outlined,
            'Push Notifications',
            'Get updates on your orders and offers',
            settings.notificationsEnabled,
            (val) => settings.toggleNotifications(val),
          ),
          _buildSwitchTile(
            Icons.dark_mode_outlined,
            'Dark Mode',
            'Enable dark theme for the app',
            settings.themeMode == ThemeMode.dark,
            (val) => settings.toggleTheme(val),
          ),

          _buildSectionHeader('Support'),
          _buildMenuItem(
            Icons.help_center_outlined,
            'Help Center',
            'View frequently asked questions',
            () {
              Navigator.of(context).pushNamed(HelpCenterScreen.routeName);
            },
          ),
          _buildMenuItem(
            Icons.chat_bubble_outline_rounded,
            'Live Chat',
            'Talk to our support team 24/7',
            () {
              Navigator.of(context).pushNamed(HelpCenterScreen.routeName);
            },
          ),

          _buildSectionHeader('Regional'),
          _buildSelectionTile(
            Icons.language_outlined,
            'Language',
            'English',
            () {},
          ),
          _buildSelectionTile(
            Icons.monetization_on_outlined,
            'Currency',
            settings.currency,
            () => _showCurrencyPicker(context, settings),
          ),

          _buildSectionHeader('About'),
          _buildMenuItem(
            Icons.info_outline_rounded,
            'App Version',
            '1.0.0 (Build 1)',
            () {},
          ),
          _buildMenuItem(
            Icons.description_outlined,
            'Terms of Service',
            'Read our legal terms',
            () {},
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  void _showCurrencyPicker(BuildContext context, SettingsProvider settings) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Select Currency',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ListTile(
              title: const Text('USD (\$)'),
              onTap: () {
                settings.setCurrency('USD (\$)');
                Navigator.pop(ctx);
              },
            ),
            ListTile(
              title: const Text('EUR (€)'),
              onTap: () {
                settings.setCurrency('EUR (€)');
                Navigator.pop(ctx);
              },
            ),
            ListTile(
              title: const Text('INR (₹)'),
              onTap: () {
                settings.setCurrency('INR (₹)');
                Navigator.pop(ctx);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 12),
      child: Text(
        title.toUpperCase(),
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w900,
          color: Colors.grey,
          letterSpacing: 1.2,
        ),
      ),
    );
  }

  Widget _buildSwitchTile(
    IconData icon,
    String title,
    String subtitle,
    bool value,
    Function(bool) onChanged,
  ) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E293B) : Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: SwitchListTile(
        secondary: Icon(icon, color: Theme.of(context).colorScheme.primary),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(
          subtitle,
          style: const TextStyle(fontSize: 12, color: Colors.grey),
        ),
        value: value,
        onChanged: onChanged,
      ),
    );
  }

  Widget _buildSelectionTile(
    IconData icon,
    String title,
    String value,
    VoidCallback onTap,
  ) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E293B) : Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListTile(
        leading: Icon(icon, color: Theme.of(context).colorScheme.primary),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              value,
              style: const TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.w600,
              ),
            ),
            const Icon(Icons.chevron_right_rounded, color: Colors.grey),
          ],
        ),
        onTap: onTap,
      ),
    );
  }

  Widget _buildMenuItem(
    IconData icon,
    String title,
    String subtitle,
    VoidCallback onTap,
  ) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E293B) : Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListTile(
        leading: Icon(icon, color: Colors.grey),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(
          subtitle,
          style: const TextStyle(fontSize: 12, color: Colors.grey),
        ),
        trailing: const Icon(Icons.chevron_right_rounded, color: Colors.grey),
        onTap: onTap,
      ),
    );
  }
}
