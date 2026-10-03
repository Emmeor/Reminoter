const TimerCard({
    required this.timer, 
    required this.onTap,
    required this.onToggle, 
    required this.onReset, 
    required this.onDelete
    });

Navigator.pop(context, TimerItem(...));