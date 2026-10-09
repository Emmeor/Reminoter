import 'package:flutter/material.dart';
import 'app.dart';
import 'controllers/theme_controller.dart';
import 'services/notification_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService.init();
  final themeController = ThemeController();
  await themeController.load();
  runApp(ReminoterApp(themeController: themeController));
}