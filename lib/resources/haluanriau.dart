import 'package:html/parser.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
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
      return [];
    }
  }

  Future<NewsInterface> getArticle(String url) async {
    Response response = await client.get(url);
    var document = parse(response.body);

    var data = new NewsInterface(
        id: url,
        title: document.querySelector('.post-title > h1').text,
        thumbnail: document.querySelector('.post-thumb > img') != null
            ? document.querySelector('.post-thumb > img').attributes['src']
            : '',
        description: '',
        content: document.getElementById('page1').innerHtml,
        url: url,
        writer: document.querySelector('.post-author > span') != null
            ? document.querySelector('.post-author > span').text
            : '',
        publishedAt: DateFormat('EEEE, dd MMMM yyyy HH:mm Z')
            .parse(waktu.convert(document.querySelector('.post-date').text)),
        publisher: 'goriau.com');

    return data;
  }
}
