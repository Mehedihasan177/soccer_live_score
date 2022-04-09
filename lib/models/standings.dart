// ignore_for_file: file_names

class Standings {
  List<Team>? team;
  List<Point>? point;

  Standings({this.team, this.point});

  Standings.fromJson(Map<String, dynamic> json) {
    if (json['team'] != null) {
      team = <Team>[];
      json['team'].forEach((v) {
        team!.add(Team.fromJson(v));
      });
    }
    if (json['point'] != null) {
      point = <Point>[];
      json['point'].forEach((v) {
        point!.add(Point.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (team != null) {
      data['team'] = team!.map((v) => v.toJson()).toList();
    }
    if (point != null) {
      data['point'] = point!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Team {
  String? heding;
  String? logo;

  Team({this.heding, this.logo});

  Team.fromJson(Map<String, dynamic> json) {
    heding = json['heding'];
    logo = json['logo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['heding'] = heding;
    data['logo'] = logo;
    return data;
  }
}

class Point {
  String? gP;
  String? w;
  String? d;
  String? l;
  String? gF;
  String? gA;
  String? gD;
  String? p;

  Point({this.gP, this.w, this.d, this.l, this.gF, this.gA, this.gD, this.p});

  Point.fromJson(Map<String, dynamic> json) {
    gP = json['GP'];
    w = json['W'];
    d = json['D'];
    l = json['L'];
    gF = json['GF'];
    gA = json['GA'];
    gD = json['GD'];
    p = json['P'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['GP'] = gP;
    data['W'] = w;
    data['D'] = d;
    data['L'] = l;
    data['GF'] = gF;
    data['GA'] = gA;
    data['GD'] = gD;
    data['P'] = p;
    return data;
  }
}
