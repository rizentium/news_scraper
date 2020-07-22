import 'package:html/parser.dart';
import 'package:http/http.dart';
import 'package:news_scraper/interfaces/news-source.dart';

class GoRiauResource {
  String _url = 'https://www.goriau.com';
  var client = Client();

  Future<List<NewsInterface>> fetchData() async {
    try {
      Response response = await client.get('$_url/berita/peristiwa.html');

      var document = parse(response.body);
      List news = document
          .querySelectorAll('.post')
          .map((e) => new NewsInterface(
              id: (_url +
                  e.querySelector('.post-thumb > a').attributes['href']),
              title: e.querySelector('.post-title > h2 > a').text,
              thumbnail: e
                  .querySelector('.post-thumb > a > img')
                  .attributes['data-src'],
              description: '',
              url: _url + e.querySelector('.post-thumb > a').attributes['href'],
              publishedAt: e.querySelector('.post-attr').text,
              publisher: 'goriau.com'))
          .toList();
      return news;
    } catch (err) {
      return [];
    }
  }

  Future<NewsInterface> getArticle(String url) async {
    Response response = await client.get(url);
    var document = parse(response.body);

    var data = new NewsInterface(
        id: url,
        title: document.querySelector('.post-title > h1').text,
        thumbnail:
            document.querySelector('.post-thumb > img').attributes['src'],
        description: '',
        content: document.getElementById('page1').innerHtml,
        url: url,
        writer: document.querySelector('.post-author > span') != null
            ? document.querySelector('.post-author > span').text
            : '',
        publishedAt: document.querySelector('.post-date').text,
        publisher: 'goriau.com');

    return data;
  }
}
