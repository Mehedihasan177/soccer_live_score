// ignore_for_file: file_names

class StandingLeague {
  List<League>? league;

  StandingLeague({this.league});

  StandingLeague.fromJson(Map<String, dynamic> json) {
    if (json['league'] != null) {
      league = <League>[];
      json['league'].forEach((v) {
        league!.add(League.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (league != null) {
      data['league'] = league!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class League {
  String? ids;
  String? name;
  String? link;

  League({this.ids, this.name, this.link});

  League.fromJson(Map<String, dynamic> json) {
    ids = json['ids'];
    name = json['name'];
    link = json['link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ids'] = ids;
    data['name'] = name;
    data['link'] = link;
    return data;
  }
}
