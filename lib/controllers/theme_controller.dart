import 'package:flutter/material.dart';
import '../data/theme_storage.dart';

/// Holds the current theme color and notifies the app when it changes.
class ThemeController extends ChangeNotifier {
  static const defaultColor = Color(0xFFE8590C);

  final _storage = ThemeStorage();
  Color _color = defaultColor;

  Color get color => _color;

  Future<void> load() async {
    _color = await _storage.load() ?? defaultColor;
  }

  Future<void> setColor(Color color) async {
    _color = color;
    notifyListeners();
    await _storage.save(color);
  }

  Future<void> reset() => setColor(defaultColor);
}