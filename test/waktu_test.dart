import 'package:news_scraper/services/waktu.dart';
import 'package:test/test.dart';

void main() {
  test('WaktuService', () async {
    var waktu = WaktuService();

    // Main success scenario
    expect(waktu.convert('Senin, 27 Juni 2020'), 'Monday, 27 June 2020');
  });
}
