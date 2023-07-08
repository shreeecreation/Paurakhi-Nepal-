String getTimeAgo(DateTime timestamp) {
  DateTime today = DateTime.now();
  Duration difference = today.difference(timestamp);
  int seconds = difference.inSeconds;

  if (today.day - timestamp.day == 1) {
    return 'Yesterday';
  }

  Map<String, int> intervals = {
    'Y': 31536000,
    'M': 2592000,
    'W': 604800,
    'D': 86400,
    'hr': 3600,
    'min': 60,
  };

  for (var interval in intervals.entries) {
    if (seconds >= interval.value) {
      int count = (seconds / interval.value).floor();
      return '${count == 1 ? count : '$count'} ${interval.key}${count == 1 ? '' : 's'} ';
    }
  }

  return 'Just now';
}
