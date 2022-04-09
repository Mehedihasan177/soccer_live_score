class FootballNewsDetails {
  NewsDtls? newsDtls;

  FootballNewsDetails({this.newsDtls});

  FootballNewsDetails.fromJson(Map<String, dynamic> json) {
    newsDtls =
        json['news-dtls'] != null ? NewsDtls.fromJson(json['news-dtls']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (newsDtls != null) {
      data['news-dtls'] = newsDtls!.toJson();
    }
    return data;
  }
}

class NewsDtls {
  String? title;
  String? time;
  String? figcaption;
  String? image;
  List<Desc>? desc;

  NewsDtls({this.title, this.time, this.figcaption, this.image, this.desc});

  NewsDtls.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    time = json['time'];
    figcaption = json['figcaption'];
    image = json['image'];
    if (json['desc'] != null) {
      desc = <Desc>[];
      json['desc'].forEach((v) {
        desc!.add(Desc.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['time'] = time;
    data['figcaption'] = figcaption;
    data['image'] = image;
    if (desc != null) {
      data['desc'] = desc!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Desc {
  String? details;

  Desc({this.details});

  Desc.fromJson(Map<String, dynamic> json) {
    details = json['details'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['details'] = details;
    return data;
  }
}
