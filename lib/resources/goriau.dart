import 'package:html/parser.dart';
import 'package:http/http.dart';
import 'package:news_scraper/interfaces/news-source.dart';
import 'package:news_scraper/services/waktu.dart';

class GoRiauResource {
  String _url = 'https://www.goriau.com/berita/peristiwa.html';

  Future<List<NewsInterface>> fetchData() async {
    var client = Client();
    Response response = await client.get(_url);

    var document = parse(response.body);
    List news = document
        .querySelectorAll('.post')
        .map((e) => new NewsInterface(
            id: '',
            title: e.querySelector('.post-title > h2 > a').text,
            thumbnail:
                e.querySelector('.post-thumb > a > img').attributes['data-src'],
            description: '',
            url: _url + e.querySelector('.post-thumb > a').attributes['href'],
            publishedAt: WaktuService().toDateTime(
                currentTime: DateTime.now(),
                timeago: e.querySelector('.post-attr').text)))
        .toList();
    return news;
  }
}
