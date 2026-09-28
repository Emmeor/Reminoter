import 'package:flutter/cupertino.dart' show CupertinoTimerPicker, CupertinoTimerPickerMode;
import 'package:flutter/material.dart';
 
import '../models/timer_item.dart';
import '../theme/app_theme.dart';
 
/// The "Set Timer" popup: title, note, HH:MM:SS wheel picker, preview, save.
/// Shown as an overlay on Home (see HomeScreen._openSetTimerSheet).
class SetTimerSheet extends StatelessWidget {
  final TextEditingController titleController;
  final TextEditingController noteController;
  final Duration initialDuration;
  final ValueChanged<Duration> onDurationChanged;
  final VoidCallback onSave;
 
  /// Live value for the "Timer would be set at" preview.
  final int previewSeconds;
 
  const SetTimerSheet({
    super.key,
    required this.titleController,
    required this.noteController,
    required this.initialDuration,
    required this.onDurationChanged,
    required this.onSave,
    required this.previewSeconds,
  });
 
  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
 
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: EdgeInsets.only(
        left: AppSpacing.md,
        right: AppSpacing.md,
        top: AppSpacing.md,
        bottom: MediaQuery.of(context).viewInsets.bottom + AppSpacing.md,
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Title', style: text.headlineSmall),
            const SizedBox(height: AppSpacing.sm),
            _field(titleController, 'Title', maxLines: 1),
            const SizedBox(height: AppSpacing.lg),
            Text('Note', style: text.headlineSmall),
            const SizedBox(height: AppSpacing.sm),
            _field(noteController, 'Note', maxLines: 4),
            const SizedBox(height: AppSpacing.lg),
            Text('Set Timer', style: text.headlineSmall),
            const SizedBox(height: AppSpacing.sm),
            Container(
              height: 180,
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(AppSpacing.md),
              ),
              child: CupertinoTimerPicker(
                mode: CupertinoTimerPickerMode.hms,
                initialTimerDuration: initialDuration,
                onTimerDurationChanged: onDurationChanged,
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              'Timer would be set at HH:MM:SS',
              textAlign: TextAlign.center,
              style: text.bodyMedium,
            ),
            Text(
              formatDuration(previewSeconds),
              textAlign: TextAlign.center,
              style: text.titleMedium, // digital time display
            ),
            Text(
              'FROM NOW',
              textAlign: TextAlign.center,
              style: text.labelSmall,
            ),
            const SizedBox(height: AppSpacing.md),
            FilledButton(onPressed: onSave, child: const Text('Save')),
          ],
        ),
      ),
    );
  }
 
  Widget _field(TextEditingController c, String hint, {required int maxLines}) {
    return TextField(
      controller: c,
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: AppColors.primary,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.md),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}