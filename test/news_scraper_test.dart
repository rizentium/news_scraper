import 'package:flutter_test/flutter_test.dart';

import 'package:news_scraper/news_scraper.dart';

void main() {
  test('adds one to input values', () {
    final newsScraper = NewsScraper();
    var result = newsScraper.getListFromSource(source: 'goriau');
    result.then((value) {
      print(value);
    });
  });
}
