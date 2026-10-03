class TimerItem {
  TimerItem({required this.id, required this.title, required this.note,
      required this.totalSeconds, int? remainingSeconds, this.endAtMs})
      : remainingSeconds = remainingSeconds ?? totalSeconds;

  final int id;
  String title;
  String note;
  int totalSeconds;
  int remainingSeconds; // used while paused
  int? endAtMs;         // set while running
}