import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'theme/app_theme.dart';
 
void main() {
  runApp(const ReminoterApp());
}
 
class ReminoterApp extends StatefulWidget {
  const ReminoterApp({super.key});
 
  @override
  State<ReminoterApp> createState() => _ReminoterAppState();
}
 
class _ReminoterAppState extends State<ReminoterApp> {

  ThemeMode _themeMode = ThemeMode.dark;
 

  void _setThemeMode(ThemeMode mode) => setState(() => _themeMode = mode);
 
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Reminoter',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: _themeMode,
      home: HomeScreen(
        themeMode: _themeMode,
        onThemeModeChanged: _setThemeMode,
      ),
    );
  }
}