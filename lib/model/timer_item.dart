class TimerItem {
  TimerItem({
    required this.id, 
    required this.title, 
    required this.note,
    required this.totalSeconds, 
    int? remainingSeconds, 
    this.endAtMs
    })
    : remainingSeconds = remainingSeconds ?? totalSeconds;

  final int id;
  String title;
  String note;
  int totalSeconds;
  int remainingSeconds; // used while paused
  int? endAtMs;         // set while running
}

bool get running => endAtMs != null;

int get secondsLeft {
  if (!running) return remainingSeconds;
  final ms = endAtMs! - DateTime.now().millisecondsSinceEpoch;
  return max(0, (ms / 1000).ceil());
}