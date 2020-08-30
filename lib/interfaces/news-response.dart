import 'package:news_scraper/interfaces/news-source.dart';

class NewsResponseInterface {
  final int code;
  final List<NewsInterface> data;
  final String message;

  NewsResponseInterface({
    this.code,
    this.data,
    this.message,
  });

  Map<String, dynamic> toMap() {
    return {
      'code': code,
      'data': data,
      'message': message,
    };
  }

  NewsResponseInterface.fromJson(Map<String, dynamic> payload)
      : code = payload['code'],
        data = payload['data'],
        message = payload['message'];
}
