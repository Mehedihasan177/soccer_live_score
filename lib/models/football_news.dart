class FootballNews {
  List<News>? news;

  FootballNews({this.news});

  FootballNews.fromJson(Map<String, dynamic> json) {
    if (json['news'] != null) {
      news = <News>[];
      json['news'].forEach((v) {
        news!.add(News.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (news != null) {
      data['news'] = news!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class News {
  String? image;
  String? title;
  String? link;

  News({this.image, this.title, this.link});

  News.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    title = json['title'];
    link = json['link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['image'] = image;
    data['title'] = title;
    data['link'] = link;
    return data;
  }
}
