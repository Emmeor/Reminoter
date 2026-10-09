import 'package:flutter/material.dart';
import 'controllers/theme_controller.dart';
import 'screens/home_screen.dart';

class ReminoterApp extends StatelessWidget {
  const ReminoterApp({super.key, required this.themeController});

  final ThemeController themeController;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: themeController,
      builder: (context, _) {
        final seed = themeController.color;
        return MaterialApp(
          title: 'Reminoter',
          debugShowCheckedModeBanner: false,
          themeMode: ThemeMode.system,
          theme: ThemeData(colorSchemeSeed: seed, useMaterial3: true),
          darkTheme: ThemeData(
            colorSchemeSeed: seed,
            brightness: Brightness.dark,
            useMaterial3: true,
          ),
          home: HomeScreen(themeController: themeController),
        );
      },
    );
  }
}