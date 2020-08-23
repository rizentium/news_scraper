extension CapExtension on String {
  // Covert to `Title Case` format
  String get toTitleCase =>
      this.split(' ').map((f) => f[0].toUpperCase() + f.substring(1)).join(' ');
}

class WaktuService {
  convert(String payload) {
    // convert day format
    payload = _day(payload);
    // convert month format
    payload = _month(payload);
    // convert timezone
    payload = _timezone(payload);

    return payload.toTitleCase;
  }

  _day(String payload) {
    List<String> daysID = [
      'senin',
      'selasa',
      'rabu',
      'kamis',
      'jumat',
      'sabtu',
      'minggu'
    ];
    List<String> daysEN = [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday'
    ];
    var result = payload.toLowerCase();

    daysID.asMap().forEach((i, f) {
      result = result.replaceFirst(f, daysEN[i]);
    });

    return result;
  }

  _month(String payload) {
    List<String> monthsID = [
      'januari',
      'februari',
      'maret',
      'april',
      'mei',
      'juni',
      'juli',
      'agustus',
      'september',
      'oktober',
      'november',
      'desember',
    ];
    List<String> monthsEN = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];
    var result = payload.toLowerCase();

    monthsID.asMap().forEach((i, f) {
      result = result.replaceFirst(f, monthsEN[i]);
    });

    return result;
  }

  _timezone(String payload) {
    List<String> timezoneID = ['wib', 'wita', 'wit'];
    List<String> timezoneINT = ['+0700', '+0800', '+0900'];

    var result = payload.toLowerCase();

    timezoneID.asMap().forEach((i, f) {
      result = result.replaceFirst(f, timezoneINT[i]);
    });

    return result;
  }
}
