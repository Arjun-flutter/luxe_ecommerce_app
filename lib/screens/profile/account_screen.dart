import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth.dart';
import '../../providers/orders.dart';
import '../../providers/products.dart';
import '../../providers/favorites_provider.dart';
import '../orders/orders_screen.dart';
import 'address_screen.dart';
import 'settings_screen.dart';
import 'edit_profile_screen.dart';

class AccountScreen extends StatelessWidget {
  static const routeName = '/account';

  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<Auth>(context, listen: false);
    final ordersCount = Provider.of<Orders>(context).orders.length;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark
          ? Colors.black
          : const Color(0xFFF8F9FA),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            backgroundColor: isDark ? Colors.black : Colors.black,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: isDark
                        ? [const Color(0xFF121212), Colors.black]
                        : [const Color(0xFF1A1A1A), const Color(0xFF434343)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 40),
                    const CircleAvatar(
                      radius: 45,
                      backgroundImage: NetworkImage(
                        'https://i.pravatar.cc/150?u=a042581f4e29026704d',
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Alexander Hunt',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                      ),
                    ),
                    Text(
                      'Gold Member',
                      style: TextStyle(
                        color: Colors.amber.shade400,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: isDark
                    ? const Color(0xFF121212)
                    : const Color(0xFF1E293B),
                borderRadius: BorderRadius.circular(24),
                border: isDark ? Border.all(color: Colors.white10) : null,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'LUXE WALLET',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.7),
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        '\$1,250.00',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text('Top Up'),
                  ),
                ],
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.symmetric(vertical: 20),
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF121212) : Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: isDark ? Border.all(color: Colors.white10) : null,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildStatItem(context, 'Orders', ordersCount.toString()),
                  Consumer<FavoritesProvider>(
                    builder: (ctx, favs, _) => _buildStatItem(
                      context,
                      'Wishlist',
                      favs.favoriteProductIds.length.toString(),
                    ),
                  ),
                  _buildStatItem(context, 'Referrals', '12'),
                ],
              ),
            ),
          ),

          SliverList(
            delegate: SliverChildListDelegate([
              _buildSectionHeader('Earning Center'),
              _buildMenuItem(
                context,
                Icons.card_giftcard_rounded,
                'Refer & Earn',
                'Earn \$50 for every friend you invite',
                () {},
              ),
              _buildMenuItem(
                context,
                Icons.stars_rounded,
                'Loyalty Rewards',
                'Check your milestone progress',
                () {},
              ),

              _buildSectionHeader('General'),
              _buildMenuItem(
                context,
                Icons.shopping_bag_outlined,
                'My Orders',
                'Track and manage your orders',
                () => Navigator.of(context).pushNamed(OrdersScreen.routeName),
              ),
              _buildMenuItem(
                context,
                Icons.location_on_outlined,
                'Addresses',
                'Manage your delivery locations',
                () => Navigator.of(context).pushNamed(AddressScreen.routeName),
              ),

              _buildSectionHeader('Account'),
              _buildMenuItem(
                context,
                Icons.settings_outlined,
                'App Settings',
                'Language, Currency, Theme',
                () => Navigator.of(context).pushNamed(SettingsScreen.routeName),
              ),
              _buildMenuItem(
                context,
                Icons.person_outline,
                'Personal Info',
                'Edit your profile details',
                () => Navigator.of(
                  context,
                ).pushNamed(EditProfileScreen.routeName),
              ),

              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: OutlinedButton.icon(
                  onPressed: () {
                    auth.logout();
                    Navigator.of(context).pushReplacementNamed('/');
                  },
                  icon: const Icon(Icons.logout_rounded, color: Colors.redAccent),
                  label: const Text(
                    'Logout Account',
                    style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold),
                  ),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    side: const BorderSide(color: Colors.redAccent, width: 1),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  ),
                ),
              ),

              const SizedBox(height: 100),
            ]),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(BuildContext context, String label, String value) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w900,
            color: isDark ? Colors.white : Colors.black,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: isDark ? Colors.white60 : Colors.grey.shade600,
          ),
        ),
      ],
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 30, 20, 10),
      child: Text(
        title.toUpperCase(),
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w900,
          color: Colors.grey,
          letterSpacing: 1.5,
        ),
      ),
    );
  }

  Widget _buildMenuItem(
    BuildContext context,
    IconData icon,
    String title,
    String subtitle,
    VoidCallback onTap,
  ) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF121212) : Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: isDark ? Border.all(color: Colors.white10) : null,
      ),
      child: ListTile(
        onTap: onTap,
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: isDark ? Colors.black26 : Colors.grey.shade50,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: isDark ? Colors.white : Colors.black87),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold, 
            fontSize: 16,
            color: isDark ? Colors.white : Colors.black,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(
            color: isDark ? Colors.white60 : Colors.grey.shade500,
            fontSize: 12,
          ),
        ),
        trailing: const Icon(Icons.chevron_right_rounded, color: Colors.grey),
      ),
    );
  }
}
