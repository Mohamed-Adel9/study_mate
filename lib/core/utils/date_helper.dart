String formatDate(DateTime date) {
  return "${date.day} / ${date.month} / ${date.year}";
}

bool isToday(DateTime date) {
  final now = DateTime.now();
  return date.year == now.year &&
      date.month == now.month &&
      date.day == now.day;
}

String formatTime(DateTime date) {
  final hour = date.hour > 12 ? date.hour - 12 : date.hour;
  final period = date.hour >= 12 ? "PM" : "AM";
  return "$hour:${date.minute.toString().padLeft(2, '0')} $period";
}
