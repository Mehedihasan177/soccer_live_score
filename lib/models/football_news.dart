class FootballNews {
  List<News>? news;

  FootballNews({this.news});

  FootballNews.fromJson(Map<String, dynamic> json) {
    if (json['news'] != null) {
      news = <News>[];
      json['news'].forEach((v) {
        news!.add(new News.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.news != null) {
      data['news'] = this.news!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class News {
  String? link;
  String? image;
  String? titles;
  String? summary;
  String? time;

  News({this.link, this.image, this.titles, this.summary, this.time});

  News.fromJson(Map<String, dynamic> json) {
    link = json['link'];
    image = json['image'];
    titles = json['titles'];
    summary = json['summary'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['link'] = this.link;
    data['image'] = this.image;
    data['titles'] = this.titles;
    data['summary'] = this.summary;
    data['time'] = this.time;
    return data;
  }
}