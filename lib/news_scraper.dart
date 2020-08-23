library news_scraper;

import 'package:news_scraper/resources/goriau.dart';
import 'package:news_scraper/resources/haluanriau.dart';
import 'interfaces/news-source.dart';

enum NewsSource { goriau, haluanriau }

class NewsScraper {
  /// Get news from specific source.
  /// Ex: goriau
  Future<List<NewsInterface>> getListFromSource({NewsSource source}) async {
    switch (source) {
      case NewsSource.goriau:
        return GoRiauResource().fetchData();
        break;
      case NewsSource.haluanriau:
        return HaluanRiauResource().fetchData();
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
      case NewsSource.haluanriau:
        return HaluanRiauResource().getArticle(url);
        break;
      default:
        return null;
    }
  }
}
