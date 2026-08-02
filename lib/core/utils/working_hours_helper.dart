class WorkingHoursHelper {

  static bool isOpenNow(String? workingHours) {
    if (workingHours == null || workingHours.isEmpty) return false;

    if (workingHours.trim() == '24/7' ||
        workingHours.toLowerCase().contains('open 24')) {
      return true;
    }

    final parts = workingHours.split('-');
    if (parts.length != 2) return false;

    final openTime = _parseTime(parts[0].trim());
    final closeTime = _parseTime(parts[1].trim());
    if (openTime == null || closeTime == null) return false;

    final now = DateTime.now();
    final nowMinutes = now.hour * 60 + now.minute;
    final openMinutes = openTime.hour * 60 + openTime.minute;
    final closeMinutes = closeTime.hour * 60 + closeTime.minute;

    if (openMinutes <= closeMinutes) {
      return nowMinutes >= openMinutes && nowMinutes < closeMinutes;
    }

    return nowMinutes >= openMinutes || nowMinutes < closeMinutes;
  }

  static DateTime? _parseTime(String value) {
    final match = RegExp(r'^(\d{1,2}):(\d{2})$').firstMatch(value);
    if (match == null) return null;

    final hour = int.parse(match.group(1)!);
    final minute = int.parse(match.group(2)!);
    if (hour > 23 || minute > 59) return null;

    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day, hour, minute);
  }
}