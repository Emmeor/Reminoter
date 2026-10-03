Future<List<TimerItem>> load() async {
  final prefs = await SharedPreferences.getInstance();
  final raw = prefs.getString('timers_v1');
  if (raw == null) return [];
  return (jsonDecode(raw) as List)
      .map((e) => TimerItem.fromJson(e as Map<String, dynamic>)).toList();
}

Future<void> save(List<TimerItem> timers) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('timers_v1', jsonEncode(timers.map((t) => t.toJson()).toList()));
}