class Highlight {
  bool? status;
  Highlights? highlights;

  Highlight({this.status, this.highlights});

  Highlight.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    highlights = json['highlights'] != null
        ? Highlights.fromJson(json['highlights'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (highlights != null) {
      data['highlights'] = highlights?.toJson();
    }
    return data;
  }
}

class Highlights {
  int? currentPage;
  List<Data>? data;
  int? lastPage;

  Highlights({this.currentPage, this.data, this.lastPage});

  Highlights.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data?.add(Data.fromJson(v));
      });
    }
    lastPage = json['last_page'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['current_page'] = currentPage;
    if (this.data != null) {
      data['data'] = this.data?.map((v) => v.toJson()).toList();
    }
    data['last_page'] = lastPage;
    return data;
  }
}

class Data {
  int? id;
  String? title;
  String? shortDescription;
  String? type;
  String? video;
  String? referer;
  String? accessControlAllowOrigin;
  String? thumbnail;
  int? status;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.id,
      this.title,
      this.shortDescription,
      this.type,
      this.video,
      this.referer,
      this.accessControlAllowOrigin,
      this.thumbnail,
      this.status,
      this.createdAt,
      this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    shortDescription = json['short_description'];
    type = json['type'];
    video = json['video'];
    referer = json['referer'];
    accessControlAllowOrigin = json['access_control_allow_origin'];
    thumbnail = json['thumbnail'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['short_description'] = shortDescription;
    data['type'] = type;
    data['video'] = video;
    data['referer'] = referer;
    data['access_control_allow_origin'] = accessControlAllowOrigin;
    data['thumbnail'] = thumbnail;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
