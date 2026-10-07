import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import '../controllers/theme_controller.dart';

/// Bottom sheet with a color wheel and RGB inputs. Changes apply on "Apply".
class ThemePickerSheet extends StatefulWidget {
  const ThemePickerSheet({super.key, required this.controller});
  final ThemeController controller;

  @override
  State<ThemePickerSheet> createState() => _ThemePickerSheetState();
}

class _ThemePickerSheetState extends State<ThemePickerSheet> {
  late Color _color = widget.controller.color;
  int _pickerKey = 0; // bumping this rebuilds the wheel after typing RGB values

  late final _r = TextEditingController();
  late final _g = TextEditingController();
  late final _b = TextEditingController();

  static String _channel(double v) => (v * 255).round().toString();

  @override
  void initState() {
    super.initState();
    _syncFields();
  }

  @override
  void dispose() {
    for (final c in [_r, _g, _b]) {
      c.dispose();
    }
    super.dispose();
  }

  void _syncFields() {
    _r.text = _channel(_color.r);
    _g.text = _channel(_color.g);
    _b.text = _channel(_color.b);
  }

  void _onWheelChanged(Color c) {
    setState(() => _color = c);
    _syncFields();
  }

  void _onRgbTyped(String _) {
    final r = int.tryParse(_r.text);
    final g = int.tryParse(_g.text);
    final b = int.tryParse(_b.text);
    if (r == null || g == null || b == null) return;
    setState(() {
      _color = Color.fromARGB(
        255,
        r.clamp(0, 255).toInt(),
        g.clamp(0, 255).toInt(),
        b.clamp(0, 255).toInt(),
      );
      _pickerKey++;
    });
  }

  void _reset() {
    setState(() {
      _color = ThemeController.defaultColor;
      _pickerKey++;
    });
    _syncFields();
  }

  void _apply() {
    widget.controller.setColor(_color);
    Navigator.pop(context);
  }

  Widget _rgbField(TextEditingController c, String label) => Expanded(
        child: TextField(
          controller: c,
          keyboardType: TextInputType.number,
          textAlign: TextAlign.center,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(3),
          ],
          onChanged: _onRgbTyped,
          decoration: InputDecoration(labelText: label, border: const OutlineInputBorder()),
        ),
      );

  @override
  Widget build(BuildContext context) {
    final onColor = ThemeData.estimateBrightnessForColor(_color) == Brightness.dark
        ? Colors.white
        : Colors.black;

    return Padding(
      padding: EdgeInsets.fromLTRB(16, 0, 16, MediaQuery.of(context).viewInsets.bottom + 16),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Theme color', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 12),
            HueRingPicker(
              key: ValueKey(_pickerKey),
              pickerColor: _color,
              onColorChanged: _onWheelChanged,
              portraitOnly: true,
            ),
            const SizedBox(height: 8),
            Row(children: [
              _rgbField(_r, 'R'),
              const SizedBox(width: 8),
              _rgbField(_g, 'G'),
              const SizedBox(width: 8),
              _rgbField(_b, 'B'),
            ]),
            const SizedBox(height: 12),
            Container(
              height: 48,
              alignment: Alignment.center,
              decoration: BoxDecoration(color: _color, borderRadius: BorderRadius.circular(12)),
              child: Text('Preview', style: TextStyle(color: onColor)),
            ),
            const SizedBox(height: 16),
            Row(children: [
              Expanded(child: OutlinedButton(onPressed: _reset, child: const Text('Reset'))),
              const SizedBox(width: 12),
              Expanded(child: FilledButton(onPressed: _apply, child: const Text('Apply'))),
            ]),
          ],
        ),
      ),
    );
  }
}
