import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:memories/core/meory_binding.dart';
import 'package:memories/theme/app_theme.dart';
import 'core/routes.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MemoriesApp());
}

class MemoriesApp extends StatelessWidget {
  const MemoriesApp({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = ThemeData(
      brightness: Brightness.light,
      useMaterial3: true,
      fontFamily: 'Roboto',
      scaffoldBackgroundColor: Colors.transparent,
      appBarTheme: const AppBarTheme(
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        elevation: 2,
      ),
      cardTheme: const CardThemeData(elevation: 0),
    );

    return GetMaterialApp(
      title: 'Memories',
      debugShowCheckedModeBanner: false,
      locale: const Locale('ar'),
      supportedLocales: const [Locale('ar')],
      localizationsDelegates: [
        // Add these delegates for Arabic localization support
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      initialBinding: AppBindings(),
      getPages: AppRoutes.pages,
      initialRoute: AppRoutes.timeline,
      theme: AppTheme.lightTheme(context),
    );
  }
}
