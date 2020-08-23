class NewsInterface {
  final String id;
  final String title;
  final String thumbnail;
  final String description;
  final String content;
  final String url;
  final String writer;
  final String publisher;
  final DateTime publishedAt;

  NewsInterface(
      {this.id,
      this.title,
      this.thumbnail,
      this.description,
      this.content,
      this.url,
      this.writer,
      this.publisher,
      this.publishedAt});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'thumbnail': thumbnail,
      'description': description,
      'content': content,
      'url': url,
      'writer': writer,
      'publisher': publisher,
      'publishedAt': publishedAt
    };
  }

  NewsInterface.fromJson(Map<String, dynamic> payload)
      : id = payload['id'],
        title = payload['title'],
        thumbnail = payload['thumbnail'],
        description = payload['description'],
        content = payload['content'],
        url = payload['url'],
        writer = payload['writer'],
        publisher = payload['publisher'],
        publishedAt = payload['publishedAt'];
}
