import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/timer_item.dart';

/// Saves and loads timers on the device.
class TimerStorage {
  static const _key = 'timers_v1';

  Future<List<TimerItem>> load() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_key);
    if (raw == null) return [];
    return (jsonDecode(raw) as List)
        .map((e) => TimerItem.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<void> save(List<TimerItem> timers) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, jsonEncode(timers.map((t) => t.toJson()).toList()));
  }
}