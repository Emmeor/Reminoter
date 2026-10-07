import 'package:flutter/material.dart';
import '../models/timer_item.dart';

/// Bottom sheet for creating or editing a timer. Pops with a [TimerItem].
class TimerForm extends StatefulWidget {
  const TimerForm({super.key, this.existing});
  final TimerItem? existing;

  @override
  State<TimerForm> createState() => _TimerFormState();
}

class _TimerFormState extends State<TimerForm> {
  late final _title = TextEditingController(text: widget.existing?.title ?? '');
  late final _note = TextEditingController(text: widget.existing?.note ?? '');
  late final _h = TextEditingController(text: '${_total ~/ 3600}');
  late final _m = TextEditingController(text: '${(_total % 3600) ~/ 60}');
  late final _s = TextEditingController(text: '${_total % 60}');

  int get _total => widget.existing?.totalSeconds ?? 300;

  @override
  void dispose() {
    for (final c in [_title, _note, _h, _m, _s]) {
      c.dispose();
    }
    super.dispose();
  }

  void _submit() {
    final total = (int.tryParse(_h.text) ?? 0) * 3600 +
        (int.tryParse(_m.text) ?? 0) * 60 +
        (int.tryParse(_s.text) ?? 0);
    if (total <= 0) return;
    final title = _title.text.trim();
    Navigator.pop(
      context,
      TimerItem(
        id: widget.existing?.id ?? DateTime.now().millisecondsSinceEpoch % 800000000,
        title: title.isEmpty ? 'Untitled timer' : title,
        note: _note.text.trim(),
        totalSeconds: total,
      ),
    );
  }

  Widget _numberField(TextEditingController c, String label) => Expanded(
        child: TextField(
          controller: c,
          keyboardType: TextInputType.number,
          textAlign: TextAlign.center,
          decoration: InputDecoration(labelText: label, border: const OutlineInputBorder()),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16, 0, 16, MediaQuery.of(context).viewInsets.bottom + 16),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _title,
              textCapitalization: TextCapitalization.sentences,
              decoration: const InputDecoration(labelText: 'Title', border: OutlineInputBorder()),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _note,
              maxLines: 3,
              textCapitalization: TextCapitalization.sentences,
              decoration: const InputDecoration(labelText: 'Note', border: OutlineInputBorder()),
            ),
            const SizedBox(height: 12),
            Row(children: [
              _numberField(_h, 'Hours'),
              const SizedBox(width: 8),
              _numberField(_m, 'Minutes'),
              const SizedBox(width: 8),
              _numberField(_s, 'Seconds'),
            ]),
            const SizedBox(height: 16),
            FilledButton(onPressed: _submit, child: const Text('Save timer')),
          ],
        ),
      ),
    );
  }
}
