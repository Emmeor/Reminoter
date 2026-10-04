import 'dart:math';

class TimerItem {
  TimerItem({
    required this.id,
    required this.title,
    required this.note,
    required this.totalSeconds,
    int? remainingSeconds,
    this.endAtMs,
  }) : remainingSeconds = remainingSeconds ?? totalSeconds;

  final int id;
  String title;
  String note;
  int totalSeconds;
  int remainingSeconds; // used while paused
  int? endAtMs; // set while running

  bool get running => endAtMs != null;

  int get secondsLeft {
    if (!running) return remainingSeconds;
    final ms = endAtMs! - DateTime.now().millisecondsSinceEpoch;
    return max(0, (ms / 1000).ceil());
  }

  bool get done => secondsLeft == 0;

  double get progress =>
      totalSeconds == 0 ? 0 : (1 - secondsLeft / totalSeconds).clamp(0.0, 1.0);

  void start() {
    if (remainingSeconds == 0) remainingSeconds = totalSeconds;
    endAtMs = DateTime.now().millisecondsSinceEpoch + remainingSeconds * 1000;
  }

  void pause() {
    remainingSeconds = secondsLeft;
    endAtMs = null;
  }

  void reset() {
    endAtMs = null;
    remainingSeconds = totalSeconds;
  }

  /// Marks a running timer as finished if its time has run out.
  /// Returns true if anything changed.
  bool settleIfFinished() {
    if (running && done) {
      endAtMs = null;
      remainingSeconds = 0;
      return true;
    }
    return false;
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'note': note,
        'total': totalSeconds,
        'remaining': remainingSeconds,
        'endAt': endAtMs,
      };

  factory TimerItem.fromJson(Map<String, dynamic> j) => TimerItem(
        id: j['id'],
        title: j['title'],
        note: j['note'],
        totalSeconds: j['total'],
        remainingSeconds: j['remaining'],
        endAtMs: j['endAt'],
      );
}