import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:rugved_assignment/data/source/network/api_client.dart';
import 'package:rugved_assignment/presentation/screens/splash_screen.dart';
import 'package:rugved_assignment/themes/app_theme.dart';
import 'package:rugved_assignment/themes/colors.dart';

import 'presentation/binding/initial_binding.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  ApiClient.client.init();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme().data(),
      home: const SplashScreen(),
      initialBinding: InitialBinding(),
      builder: (context, child) {
        if (child != null) {
          return SafeArea(child: child);
        }
        return SizedBox.shrink();
      },
    );
  }
}
