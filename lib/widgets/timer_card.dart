import 'package:flutter/material.dart';

import '../models/timer_item.dart';
import '../utils/format.dart';

class TimerCard extends StatelessWidget {
  const TimerCard({
    super.key,
    required this.timer,
    required this.onTap,
    required this.onToggle,
    required this.onReset,
    required this.onDelete,
  });

  final TimerItem timer;
  final VoidCallback onTap, onToggle, onReset, onDelete;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;
    final t = timer;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(t.title, style: text.titleMedium),
              if (t.note.isNotEmpty) ...[
                const SizedBox(height: 4),
                Text(t.note, style: TextStyle(color: cs.onSurfaceVariant)),
              ],
              const SizedBox(height: 12),
              Row(
                children: [
                  Text(
                    t.done ? 'Done!' : formatSeconds(t.secondsLeft),
                    style: text.displaySmall?.copyWith(
                      fontFeatures: const [FontFeature.tabularFigures()],
                      color: t.done ? cs.primary : null,
                    ),
                  ),
                  const Spacer(),
                  IconButton.filled(
                    tooltip: t.running ? 'Pause' : 'Start',
                    onPressed: onToggle,
                    icon: Icon(t.running ? Icons.pause : Icons.play_arrow),
                  ),
                  IconButton(
                    tooltip: 'Reset',
                    onPressed: onReset,
                    icon: const Icon(Icons.replay),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.only(end: 8),
                    child: IconButton(
                      tooltip: 'Delete',
                      onPressed: onDelete,
                      icon: const Icon(Icons.delete_outline),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              LinearProgressIndicator(value: t.progress),
            ],
          ),
        ),
      ),
    );
  }
}
