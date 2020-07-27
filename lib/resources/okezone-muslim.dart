import 'package:html/parser.dart';
import 'package:http/http.dart';
import 'package:news_scraper/interfaces/news-source.dart';

class OkezoneMuslimResource {
  String _url = 'https://muslim.okezone.com';
  var client = Client();

  Future<List<NewsInterface>> fetchData() async {
    try {
      Response response = await client.get(Uri.parse('$_url/serbaserbimuslim'));

      var document = parse(response.body);
      List news = document
          .querySelectorAll('.list-contentx > li')
          .map((e) => new NewsInterface(
              id: e.querySelector('.gabreaking').attributes['href'],
              title: e.querySelector('.gabreaking').text,
              thumbnail: e.querySelector('.thumb-news') != null
                  ? e.querySelector('.thumb-news').attributes['data-original']
                  : e.attributes['data-original'],
              description: '',
              url: e.querySelector('.gabreaking').attributes['href'],
              publishedAt: e.querySelector('.mh-clock').text,
              publisher: 'muslim.okezone.com'))
          .toList()
          .where((data) => data.id.contains('?page=1') != true)
          .toList();
      return news;
    } catch (err) {
      print(err);
      return [];
    }
  }

  Future<NewsInterface> getArticle(String url) async {
    Response response = await client.get(url);
    var document = parse(response.body);

    var data = new NewsInterface(
        id: url,
        title: document.querySelector('.title > h1').text,
        thumbnail: document.getElementById('imgCheck').attributes['src'],
        description: '',
        content: document.getElementById('contentx').innerHtml,
        url: url,
        writer: document
            .querySelector('.namerep')
            .nodes[0]
            .text
            .trim()
            .replaceAll(RegExp(r'[^a-zA-Z ]'), ''),
        publishedAt: document.querySelector('.namerep > b').text,
        publisher: 'muslim.okezone.com');

    return data;
  }
}
