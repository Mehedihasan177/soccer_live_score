// ignore_for_file: file_names

class StandingYears {
  List<Year>? year;

  StandingYears({this.year});

  StandingYears.fromJson(Map<String, dynamic> json) {
    if (json['year'] != null) {
      year = <Year>[];
      json['year'].forEach((v) {
        year!.add(Year.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (year != null) {
      data['year'] = year!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Year {
  String? ids;
  String? year;
  String? link;

  Year({this.ids, this.year, this.link});

  Year.fromJson(Map<String, dynamic> json) {
    ids = json['ids'];
    year = json['year'];
    link = json['link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ids'] = ids;
    data['year'] = year;
    data['link'] = link;
    return data;
  }
}
