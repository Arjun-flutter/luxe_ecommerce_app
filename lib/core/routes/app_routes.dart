import 'package:flutter/material.dart';
import '../../screens/products/product_detail_screen.dart';
import '../../screens/cart/cart_screen.dart';
import '../../screens/orders/orders_screen.dart';
import '../../screens/auth/login_screen.dart';
import '../../screens/auth/signup_screen.dart';
import '../../screens/auth/onboarding_screen.dart';
import '../../screens/products/category_products_screen.dart';
import '../../screens/products/search_screen.dart';
import '../../screens/products/favorites_screen.dart';
import '../../screens/profile/account_screen.dart';
import '../../screens/profile/address_screen.dart';
import '../../screens/cart/checkout_screen.dart';
import '../../screens/cart/success_screen.dart'; // Added
import '../../screens/profile/notifications_screen.dart';
import '../../screens/profile/settings_screen.dart';
import '../../screens/profile/edit_profile_screen.dart';
import '../../screens/profile/help_center_screen.dart';

class AppRoutes {
  static const String root = '/';
  static const String auth = '/auth';
  static const String login = '/login';
  static const String signup = '/signup';
  static const String onboarding = '/onboarding';
  static const String productDetail = '/product-detail';
  static const String cart = '/cart';
  static const String orders = '/orders';
  static const String categoryProducts = '/category-products';
  static const String search = '/search';
  static const String favorites = '/favorites';
  static const String account = '/account';
  static const String address = '/address';
  static const String checkout = '/checkout';
  static const String orderSuccess = '/order-success'; // Added
  static const String notifications = '/notifications';
  static const String settings = '/settings';
  static const String editProfile = '/edit-profile';
  static const String helpCenter = '/help-center';

  static Map<String, WidgetBuilder> get routes => {
        login: (ctx) => const LoginScreen(),
        signup: (ctx) => const SignupScreen(),
        onboarding: (ctx) => const OnboardingScreen(),
        productDetail: (ctx) => const ProductDetailScreen(),
        cart: (ctx) => const CartScreen(),
        orders: (ctx) => const OrdersScreen(),
        categoryProducts: (ctx) => const CategoryProductsScreen(),
        search: (ctx) => const SearchScreen(),
        favorites: (ctx) => const FavoritesScreen(),
        account: (ctx) => const AccountScreen(),
        address: (ctx) => const AddressScreen(),
        checkout: (ctx) => const CheckoutScreen(),
        orderSuccess: (ctx) => const SuccessScreen(), // Added
        notifications: (ctx) => const NotificationsScreen(),
        settings: (ctx) => const SettingsScreen(),
        editProfile: (ctx) => const EditProfileScreen(),
        helpCenter: (ctx) => const HelpCenterScreen(),
      };
}
