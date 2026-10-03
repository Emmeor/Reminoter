String formatSeconds(int s) {
  final h = s ~/ 3600, 
  m = (s % 3600) ~/ 60, 
  sec = s % 60;
  String two(int n) => n.toString().padLeft(2, '0');
  return h > 0 ? '$h:${two(m)}:${two(sec)}' : '${two(m)}:${two(sec)}';
}