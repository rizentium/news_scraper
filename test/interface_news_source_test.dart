import 'package:news_scraper/interfaces/news-source.dart';
import 'package:test/test.dart';

void main() {
  test('WaktuService', () async {
    var newsInterface = NewsInterface(
        id: 'id',
        title: 'title',
        thumbnail: 'thumbnail',
        description: 'description',
        content: 'content',
        url: 'url',
        writer: 'writer',
        publisher: 'publisher',
        publishedAt: DateTime(2020, 11, 01));

    var newsJSON = {
      'id': 'id',
      'title': 'title',
      'thumbnail': 'thumbnail',
      'description': 'description',
      'content': 'content',
      'url': 'url',
      'writer': 'writer',
      'publisher': 'publisher',
      'publishedAt': DateTime(2020, 11, 01)
    };

    // Main success scenario
    expect(newsInterface.toMap(), newsJSON);
    expect(NewsInterface.fromJson(newsJSON).toMap(), newsInterface.toMap());
  });
}
