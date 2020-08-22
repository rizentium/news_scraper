import 'dart:convert';

import 'package:html/parser.dart';
import 'package:http/http.dart';
import 'package:news_scraper/interfaces/news-source.dart';
import 'package:xml2json/xml2json.dart';

class GoRiauResource {
  String _url = 'https://www.goriau.com';
  var client = Client();

  Future<List<NewsInterface>> fetchData() async {
    try {
      final Xml2Json xml2Json = Xml2Json();
      var response = await client.get('https://www.goriau.com/rss/berita.xml');

      var content = response.body;
      xml2Json.parse(content);

      var jsonString = xml2Json.toBadgerfish();
      List<dynamic> result = jsonDecode(jsonString)['rss']['channel']['item'];

      List news = result.map((f) {
        var description = parse(f['description']['__cdata']);

        return NewsInterface(
            id: f['link']['\$'],
            title: f['title']['\$'],
            thumbnail: description.querySelector('img').attributes['src'],
            description: description.children.first.text
                .replaceAll('\\t', '')
                .replaceAll('\\r', '')
                .replaceAll('\\n', ''),
            url: f['link']['\$'],
            publishedAt: f['pubDate']['\$'],
            publisher: 'goriau.com');
      }).toList();

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
        publishedAt: document.querySelector('.post-date').text,
        publisher: 'goriau.com');

    return data;
  }
}
