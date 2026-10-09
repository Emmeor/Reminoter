import 'dart:async';

import 'package:flutter/material.dart';

import '../controllers/theme_controller.dart';
import '../data/timer_storage.dart';
import '../models/timer_item.dart';
import '../services/notification_service.dart';
import '../widgets/timer_card.dart';
import '../widgets/theme_picker_sheet.dart';
import '../widgets/timer_form.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.themeController});
  final ThemeController themeController;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver {
  final _storage = TimerStorage();
  final _searchCtrl = TextEditingController();
  List<TimerItem> _timers = [];
  Timer? _ticker;
  String _query = '';
  bool _loaded = false;

  bool _matchesQuery(TimerItem timer, String query) =>
      query.isEmpty ||
      timer.title.toLowerCase().contains(query) ||
      timer.note.toLowerCase().contains(query);

  List<TimerItem> get _visible {
    final query = _query.trim().toLowerCase();
    return _timers.where((timer) => _matchesQuery(timer, query)).toList();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _load();
    _ticker = Timer.periodic(const Duration(seconds: 1), (_) => _tick());
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _ticker?.cancel();
    _searchCtrl.dispose();
    super.dispose();
  }

  // User left the app -> start the guilt countdown. Came back -> cancel it.
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      NotificationService.scheduleRoasts();
    } else if (state == AppLifecycleState.resumed) {
      NotificationService.cancelRoasts();
    }
  }

  Future<void> _load() async {
    _timers = await _storage.load();
    for (final t in _timers) {
      t.settleIfFinished();
    }
    if (mounted) setState(() => _loaded = true);
  }

  void _persist() => _storage.save(_timers);

  void _tick() {
    if (!mounted || _timers.isEmpty) return;
    var changed = false;
    for (final t in _timers) {
      changed = t.settleIfFinished() || changed;
    }
    if (changed) _persist();
    setState(() {});
  }

  void _toggle(TimerItem t) {
    if (t.running) {
      t.pause();
      NotificationService.cancel(t.id);
    } else {
      t.start();
      NotificationService.scheduleTimerDone(
        id: t.id,
        title: t.title,
        after: Duration(seconds: t.remainingSeconds),
      );
    }
    setState(() {});
    _persist();
  }

  void _reset(TimerItem t) {
    t.reset();
    NotificationService.cancel(t.id);
    setState(() {});
    _persist();
  }

  void _delete(TimerItem t) {
    NotificationService.cancel(t.id);
    setState(() => _timers.remove(t));
    _persist();
  }

  Future<void> _openForm([TimerItem? existing]) async {
    final result = await showModalBottomSheet<TimerItem>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (_) => TimerForm(existing: existing),
    );
    if (result == null) return;

    setState(() {
      if (existing == null) {
        _timers.insert(0, result);
      } else {
        existing
          ..title = result.title
          ..note = result.note
          ..totalSeconds = result.totalSeconds
          ..reset();
        NotificationService.cancel(existing.id);
      }
    });
    _persist();
  }

  void _onReorder(int oldIndex, int newIndex) {
    final visible = List<TimerItem>.of(_visible);
    if (newIndex > oldIndex) newIndex--;
    if (oldIndex == newIndex) return;

    final timer = visible.removeAt(oldIndex);
    visible.insert(newIndex, timer);
    final query = _query.trim().toLowerCase();
    final visibleIndices = <int>[];
    for (var i = 0; i < _timers.length; i++) {
      if (_matchesQuery(_timers[i], query)) {
        visibleIndices.add(i);
      }
    }

    setState(() {
      for (var i = 0; i < visibleIndices.length; i++) {
        _timers[visibleIndices[i]] = visible[i];
      }
    });
    _persist();
  }

  void _openThemePicker() {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (_) => ThemePickerSheet(controller: widget.themeController),
    );
  }

  @override
  Widget build(BuildContext context) {
    final visible = _visible;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reminoter'),
        centerTitle: false,
        actions: [
          IconButton(
            tooltip: 'Theme color',
            icon: const Icon(Icons.palette_outlined),
            onPressed: _openThemePicker,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _openForm,
        icon: const Icon(Icons.add),
        label: const Text('New timer'),
      ),
      body: !_loaded
          ? const Center(child: CircularProgressIndicator())
          : _timers.isEmpty
          ? Center(
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: Text(
                  'No timers yet. Add one, you beautiful procrastinator.',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
            )
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                  child: TextField(
                    controller: _searchCtrl,
                    onChanged: (value) => setState(() => _query = value),
                    decoration: InputDecoration(
                      hintText: 'Search timers',
                      prefixIcon: const Icon(Icons.search),
                      suffixIcon: _query.isEmpty
                          ? null
                          : IconButton(
                              tooltip: 'Clear search',
                              onPressed: () {
                                _searchCtrl.clear();
                                setState(() => _query = '');
                              },
                              icon: const Icon(Icons.clear),
                            ),
                      border: const OutlineInputBorder(),
                    ),
                  ),
                ),
                Expanded(
                  child: visible.isEmpty
                      ? Center(
                          child: Padding(
                            padding: const EdgeInsets.all(32),
                            child: Text(
                              'Nothing matches your search.',
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ),
                        )
                      : ReorderableListView.builder(
                          padding: const EdgeInsets.fromLTRB(16, 8, 16, 96),
                          itemCount: visible.length,
                          onReorder: _onReorder,
                          itemBuilder: (_, i) {
                            final t = visible[i];
                            return TimerCard(
                              key: ValueKey(t.id),
                              timer: t,
                              onTap: () => _openForm(t),
                              onToggle: () => _toggle(t),
                              onReset: () => _reset(t),
                              onDelete: () => _delete(t),
                            );
                          },
                        ),
                ),
              ],
            ),
    );
  }
}
