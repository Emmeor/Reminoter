import 'dart:ui';
import 'package:shared_preferences/shared_preferences.dart';

/// Saves and loads the user's chosen theme color.
class ThemeStorage {
  static const _key = 'theme_color_v1';

  Future<Color?> load() async {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getInt(_key);
    return value == null ? null : Color(value);
  }

  Future<void> save(Color color) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_key, color.toARGB32());
  }
}
