import 'package:news_scraper/interfaces/resource.dart';
import 'package:news_scraper/news_scraper.dart';
import 'package:test/test.dart';

void main() {
  test('goriau.com', () async {
    var newsScraper = NewsScraper();

    var goriau = await newsScraper.getListFromSource(source: NewsSource.goriau);
    // check the data length
    expect(goriau.length, 19);

    goriau.forEach((element) {
      // is the title still valid
      expect(element.title.length, greaterThanOrEqualTo(5));
      // is the thumbnail still valid
      expect(Uri.parse(element.thumbnail).isAbsolute, true);
      // is the url still valid
      expect(Uri.parse(element.url).isAbsolute, true);
      // is the publishedAt still valid
      expect(element.publishedAt,
          DateTime.parse(element.publishedAt.toIso8601String()));
    });
  });
}
