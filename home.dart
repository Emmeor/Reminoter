import 'package:flutter/material.dart';
import '../models/timer_item.dart';
import '../theme/app_theme.dart';
import '../widgets/add_timer_button.dart';
import '../widgets/set_timer_sheet.dart';
import '../widgets/support_link.dart';
import '../widgets/theme_mode_toggle.dart';
import '../widgets/timer_card.dart';
 
/// The one and only main screen (settings live in the app bar, the
/// "Set Timer" flow lives in a sheet on top).
class HomeScreen extends StatefulWidget {
  final ThemeMode themeMode;
  final ValueChanged<ThemeMode> onThemeModeChanged;
 
  const HomeScreen({
    super.key,
    required this.themeMode,
    required this.onThemeModeChanged,
  });
 
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
 
class _HomeScreenState extends State<HomeScreen> {
  final List<TimerItem> _timers = [];
 
  void _toggleTimer(TimerItem item, bool running) {
    setState(() {
      final i = _timers.indexWhere((t) => t.id == item.id);
      _timers[i] = item.copyWith(isRunning: running);
    });
  }
 
  Future<void> _openSetTimerSheet() async {
    final titleController = TextEditingController();
    final noteController = TextEditingController();
    var duration = const Duration(minutes: 10);
 
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        // StatefulBuilder so the preview text updates while the wheel spins.
        return StatefulBuilder(
          builder: (context, setSheetState) => SetTimerSheet(
            titleController: titleController,
            noteController: noteController,
            initialDuration: duration,
            previewSeconds: duration.inSeconds,
            onDurationChanged: (d) => setSheetState(() => duration = d),
            onSave: () {
              if (duration.inSeconds == 0) return; 
              setState(() {
                _timers.add(TimerItem(
                  id: DateTime.now().microsecondsSinceEpoch.toString(),
                  title: titleController.text.trim().isEmpty
                      ? 'Untitled'
                      : titleController.text.trim(),
                  note: noteController.text.trim(),
                  durationSeconds: duration.inSeconds,
                ));
              });
              Navigator.of(context).pop();
            },
          ),
        );
      },
    );
 
    titleController.dispose();
    noteController.dispose();
  }
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Align(
          alignment: Alignment.centerLeft,
          child: SupportLink(
            onTap: () {
            },
          ),
        ),
        actions: [
          ThemeModeToggle(
            current: widget.themeMode,
            onChanged: widget.onThemeModeChanged,
          ),
          const SizedBox(width: AppSpacing.sm),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.md),
        children: [
          for (final item in _timers) ...[
            TimerCard(
              title: item.title,
              note: item.note,
              durationSeconds: item.durationSeconds,
              isRunning: item.isRunning,
              onToggle: (running) => _toggleTimer(item, running),
            ),
            const SizedBox(height: AppSpacing.cardGap),
          ],
          const SizedBox(height: AppSpacing.sm),
          AddTimerButton(onPressed: _openSetTimerSheet),
        ],
      ),
    );
  }
}