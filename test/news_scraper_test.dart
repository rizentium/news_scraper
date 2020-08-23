import 'package:news_scraper/news_scraper.dart';
import 'package:test/test.dart';

void main() {
  test('goriau.com', () async {
    var newsScraper = NewsScraper();

    var goriau = await newsScraper.getListFromSource(source: NewsSource.goriau);
    // check the data length
    expect(goriau.length, 15);

    goriau.forEach((element) async {
      // is the title still valid
      expect(element.title.length, greaterThanOrEqualTo(5));
      // is the thumbnail still valid
      expect(
          element.thumbnail != ''
              ? Uri.parse(element.thumbnail).isAbsolute
              : true,
          true);
      // is the url still valid
      expect(Uri.parse(element.url).isAbsolute, true);
      // is the publishedAt still valid
      expect(element.publishedAt.compareTo(DateTime.now()) < 0, true);

      var news = await newsScraper.getArticle(
          source: NewsSource.goriau, url: element.url);

      expect(news.title, greaterThanOrEqualTo(5));
    });
  });
}
