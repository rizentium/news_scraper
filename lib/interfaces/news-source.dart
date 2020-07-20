class NewsInterface {
  final String id;
  final String title;
  final String thumbnail;
  final String description;
  final String url;
  final DateTime publishedAt;

  NewsInterface(
      {this.id,
      this.title,
      this.thumbnail,
      this.description,
      this.url,
      this.publishedAt});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'thumbnail': thumbnail,
      'description': description,
      'url': url,
      'publishedAt': publishedAt
    };
  }

  NewsInterface.fromJson(Map<String, dynamic> payload)
      : id = payload['id'],
        title = payload['title'],
        thumbnail = payload['thumbnail'],
        description = payload['description'],
        url = payload['url'],
        publishedAt = payload['publishedAt'];
}
