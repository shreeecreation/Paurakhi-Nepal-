String getTimeAgo(DateTime timestamp) {
  DateTime today = DateTime.now();
  Duration difference = today.difference(timestamp);
  int seconds = difference.inSeconds;

  if (today.day - timestamp.day == 1) {
    return 'Yesterday';
  }

  Map<String, int> intervals = {
    'year': 31536000,
    'month': 2592000,
    'week': 604800,
    'day': 86400,
    'hour': 3600,
    'minute': 60,
  };

  for (var interval in intervals.entries) {
    if (seconds >= interval.value) {
      int count = (seconds / interval.value).floor();
      return '${count == 1 ? count : '$count'} ${interval.key}${count == 1 ? '' : 's'} ago';
    }
  }

  return 'Just now';
}
