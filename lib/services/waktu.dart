class WaktuService {
  toDateTime({DateTime currentTime, String timeago}) {
    if (timeago.toLowerCase().contains('yang lalu')) {
      timeago = timeago.replaceAll('yang lalu', '').replaceAll(' ', '');

      var format =
          timeago.replaceAll(RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%0-9-]'), '');
      int time = int.parse(timeago.replaceAll(format, ''));

      switch (format) {
        case 'detik':
          return currentTime.subtract(new Duration(seconds: time));
        case 'menit':
          return currentTime.subtract(new Duration(minutes: time));
        case 'jam':
          return currentTime.subtract(new Duration(hours: time));
        case 'hari':
          return currentTime.subtract(new Duration(days: time));
        case 'bulan':
          return DateTime(
              currentTime.year, currentTime.month - time, currentTime.day);
        case 'tahun':
          return DateTime(currentTime.year - time, currentTime.day);
        default:
          return 'Unsupported format';
      }
    }
    return 'Unsupported format';
  }
}
