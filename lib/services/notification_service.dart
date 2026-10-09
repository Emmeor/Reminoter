import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tzdata;
import 'package:timezone/timezone.dart' as tz;
import '../data/roast_messages.dart';

class NotificationService {
  NotificationService._();

  static final _plugin = FlutterLocalNotificationsPlugin();

  static const _roastIds = [900001, 900002, 900003];
  static const _roastDelays = [
    Duration(hours: 2),
    Duration(hours: 4),
    Duration(hours: 8),
  ];

  static const _details = NotificationDetails(
    android: AndroidNotificationDetails(
      'reminoter',
      'Timers & nudges',
      importance: Importance.high,
      priority: Priority.high,
    ),
    iOS: DarwinNotificationDetails(),
  );

  static Future<void> init() async {
    tzdata.initializeTimeZones();
    const settings = InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      iOS: DarwinInitializationSettings(),
    );
    await _plugin.initialize(settings);
    await _plugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();
    await _plugin
        .resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(alert: true, badge: true, sound: true);
  }

  static Future<void> _scheduleAt(int id, String title, String body, Duration from) {
    return _plugin.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.now(tz.local).add(from),
      _details,
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
    );
  }

  // Timer finished

  static Future<void> scheduleTimerDone({
    required int id,
    required String title,
    required Duration after,
  }) =>
      _scheduleAt(id, title, timerDoneMessage, after);

  static Future<void> cancel(int id) => _plugin.cancel(id);

  // App inactive roasting notification

  static Future<void> scheduleRoasts() async {
    for (var i = 0; i < _roastIds.length; i++) {
      await _scheduleAt(_roastIds[i], 'Reminoter', randomRoast(), _roastDelays[i]);
    }
  }

  static Future<void> cancelRoasts() async {
    for (final id in _roastIds) {
      await _plugin.cancel(id);
    }
  }
}