library news_scraper;

import 'package:news_scraper/interfaces/resource.dart';
import 'package:news_scraper/resources/goriau.dart';

import 'interfaces/news-source.dart';

class NewsScraper {
  /// Get news from specific source.
  /// Ex: goriau
  Future<List<NewsInterface>> getListFromSource({NewsSource source}) async {
    switch (source) {
      case NewsSource.goriau:
        return GoRiauResource().fetchData();
        break;
      default:
        return null;
    }
  }
}
