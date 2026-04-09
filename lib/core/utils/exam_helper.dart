int getDaysLeft(DateTime date) {
  return date.difference(DateTime.now()).inDays;
}

bool isUrgent(DateTime date) {
  return getDaysLeft(date) <= 3;
}