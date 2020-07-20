import 'package:news_scraper/interfaces/resource.dart';
import 'package:news_scraper/news_scraper.dart';

void main(List<String> argument) async {
  NewsScraper().getListFromSource(source: NewsSource.goriau).then((value) {
    print(value);
  });
}
