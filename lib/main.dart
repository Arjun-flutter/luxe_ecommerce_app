import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './core/theme/app_theme.dart';
import './core/routes/app_routes.dart';
import './providers/auth.dart';
import './providers/products.dart';
import './providers/cart.dart';
import './providers/orders.dart';
import './providers/settings_provider.dart';
import './providers/favorites_provider.dart';
import './screens/home/main_screen.dart';
import './screens/auth/splash_screen.dart';
import './screens/auth/onboarding_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => SettingsProvider()),
        ChangeNotifierProvider(create: (ctx) => Auth()),
        ChangeNotifierProvider(create: (ctx) => FavoritesProvider()),
        ChangeNotifierProxyProvider<Auth, Products>(
          create: (_) => Products(),
          update: (ctx, auth, previousProducts) =>
              previousProducts ?? Products(),
        ),
        ChangeNotifierProvider(create: (ctx) => Cart()),
        ChangeNotifierProvider(create: (ctx) => Orders()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SettingsProvider>(
      builder: (ctx, settings, _) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'LUXE',
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: settings.themeMode,
        home: Consumer<Auth>(
          builder: (ctx, auth, _) => auth.isAuth
              ? const MainScreen()
              : FutureBuilder(
                  future: Future.delayed(const Duration(seconds: 2)),
                  builder: (ctx, snapshot) =>
                      snapshot.connectionState == ConnectionState.waiting
                      ? const SplashScreen()
                      : const OnboardingScreen(),
                ),
        ),
        routes: AppRoutes.routes,
      ),
    );
  }
}
