import 'package:html/parser.dart';
import 'package:http/http.dart';
import 'package:news_scraper/interfaces/news-source.dart';
import 'package:news_scraper/services/waktu.dart';

class HaluanRiauResource {
  String _url = 'https://riau.haluan.co';
  var client = Client();
  WaktuService waktu = new WaktuService();

  Future<List<NewsInterface>> fetchData() async {
    try {
      Response response =
          await this.client.get('$_url/category/provinsi-riau/');
      var document = parse(response.body);

      List<NewsInterface> news = document.querySelectorAll('article').map((f) {
        return NewsInterface(
          id: f.id,
          title: f.querySelector('.entry-title').text.trim(),
          thumbnail: f.querySelector('.attachment-medium').attributes['src'],
          description: f
              .querySelector('.entry-content')
              .text
              .replaceFirst('[…]', '')
              .trim(),
          url: f.querySelector('.entry-title > a').attributes['href'],
          publisher: 'riau.haluan.co',
          publishedAt: DateTime.parse(
              f.querySelector('.entry-date').attributes['datetime']),
        );
      }).toList();

      return news;
    } catch (err) {
      return err;
    }
  }

  Future<NewsInterface> getArticle(String url) async {
    Response response = await client.get(url);
    var document = parse(response.body);
    var content = document.querySelector('.entry-content-single').children;
    content.removeRange(content.length - 4, content.length);

    var data = new NewsInterface(
      id: url,
      title: document.querySelector('.entry-title').text.trim(),
      thumbnail: document.querySelector('.single-thumbnail > img') != null
          ? document.querySelector('.single-thumbnail > img').attributes['src']
          : '',
      description: '',
      content: content.map((f) => f.outerHtml).toList().join(),
      url: url,
      writer: document.querySelector('.entry-author') != null
          ? document.querySelector('.entry-author').text
          : '',
      publishedAt: DateTime.parse(
          document.querySelector('.entry-date').attributes['datetime']),
      publisher: 'riau.haluan.co',
    );

    return data;
  }
}
