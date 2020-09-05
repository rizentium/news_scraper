import 'dart:convert';

import 'package:html/parser.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:news_scraper/interfaces/news-source.dart';
import 'package:news_scraper/services/waktu.dart';
import 'package:xml2json/xml2json.dart';

class GoRiauResource {
  String _url = 'https://www.goriau.com';
  var client = Client();
  WaktuService waktu = new WaktuService();

  Future<List<NewsInterface>> fetchData() async {
    try {
      final Xml2Json xml2Json = Xml2Json();
      var response = await client.get('$_url/rss/berita.xml');

      var content = response.body;
      xml2Json.parse(content);

      var jsonString = xml2Json.toBadgerfish();
      List<dynamic> result = jsonDecode(jsonString)['rss']['channel']['item'];

      List<NewsInterface> news = result.map((f) {
        var description = parse(f['description']['__cdata']);
        var img = description != null ? description.querySelector('img') : null;

        return NewsInterface(
            id: f['guid']['\$'],
            title: f['title']['__cdata'].replaceAll('\\', '').toString().trim(),
            thumbnail: img != null ? img.attributes['src'] : null,
            description: description != null
                ? description.children.first.text
                    .replaceAll('\\t', '')
                    .replaceAll('\\r', '')
                    .replaceAll('\\n', '')
                : null,
            url: f['link']['\$'],
            publishedAt: DateFormat('EEE, dd MMM yyyy HH:mm:ss Z')
                .parse(f['pubDate']['\$']),
            publisher: 'goriau.com');
      }).toList();

      return news;
    } catch (err) {
      throw err;
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
