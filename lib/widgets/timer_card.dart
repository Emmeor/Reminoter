const TimerCard({
    required this.timer, 
    required this.onTap,
    required this.onToggle, 
    required this.onReset, 
    required this.onDelete
    });

Navigator.pop(
  context,
  TimerItem(
    id: widget.existing?.id ?? DateTime.now().millisecondsSinceEpoch % 800000000,
    title: title.isEmpty ? 'Untitled timer' : title,
    note: _note.text.trim(),
    totalSeconds: total,
  ),
);