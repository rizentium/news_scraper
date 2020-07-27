library news_scraper;

import 'package:news_scraper/interfaces/resource.dart';
import 'package:news_scraper/resources/goriau.dart';
import 'package:news_scraper/resources/okezone-muslim.dart';

import 'interfaces/news-source.dart';

class NewsScraper {
  /// Get news from specific source.
  /// Ex: goriau
  Future<List<NewsInterface>> getListFromSource({NewsSource source}) async {
    switch (source) {
      case NewsSource.goriau:
        return GoRiauResource().fetchData();
        break;
      case NewsSource.okezone_muslim:
        return OkezoneMuslimResource().fetchData();
        break;
      default:
        return null;
    }
  }

  /// Ex: goriau
  Future<NewsInterface> getArticle({NewsSource source, String url}) async {
    switch (source) {
      case NewsSource.goriau:
        return GoRiauResource().getArticle(url);
        break;
      case NewsSource.okezone_muslim:
        return OkezoneMuslimResource().getArticle(url);
        break;
      default:
        return null;
    }
  }
}
