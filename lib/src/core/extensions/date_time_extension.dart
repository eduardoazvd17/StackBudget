extension DateTimeExtension on DateTime {
  String formatDateTime() {
    final hour = this.hour.toString().padLeft(2, '0');
    final minute = this.minute.toString().padLeft(2, '0');
    final second = this.second.toString().padLeft(2, '0');
    return '${formatDate()} - $hour:$minute:$second';
  }

  String formatDate() {
    final day = this.day.toString().padLeft(2, '0');
    final month = this.month.toString().padLeft(2, '0');
    final year = this.year.toString().padLeft(2, '0');
    return '$day/$month/$year';
  }
}
