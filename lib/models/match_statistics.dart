class MatchStatistics {
  Team? team;
  List<Info>? info;

  MatchStatistics({this.team, this.info});

  MatchStatistics.fromJson(Map<String, dynamic> json) {
    team = json['team'] != null ? Team.fromJson(json['team']) : null;
    if (json['info'] != null) {
      info = <Info>[];
      json['info'].forEach((v) {
        info!.add(Info.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (team != null) {
      data['team'] = team!.toJson();
    }
    if (info != null) {
      data['info'] = info!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Team {
  String? awayTname;
  String? awayTimg;
  String? homeTname;
  String? homeTimg;
  Graph? graph;

  Team(
      {this.awayTname,
      this.awayTimg,
      this.homeTname,
      this.homeTimg,
      this.graph});

  Team.fromJson(Map<String, dynamic> json) {
    awayTname = json['awayTname'];
    awayTimg = json['awayTimg'];
    homeTname = json['homeTname'];
    homeTimg = json['homeTimg'];
    graph = json['graph'] != null ? Graph.fromJson(json['graph']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['awayTname'] = awayTname;
    data['awayTimg'] = awayTimg;
    data['homeTname'] = homeTname;
    data['homeTimg'] = homeTimg;
    if (graph != null) {
      data['graph'] = graph!.toJson();
    }
    return data;
  }
}

class Graph {
  String? awayChart;
  String? homeChart;
  String? homeShots;
  String? awayShots;

  Graph({this.awayChart, this.homeChart, this.homeShots, this.awayShots});

  Graph.fromJson(Map<String, dynamic> json) {
    awayChart = json['awayChart'];
    homeChart = json['homeChart'];
    homeShots = json['homeShots'];
    awayShots = json['awayShots'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['awayChart'] = awayChart;
    data['homeChart'] = homeChart;
    data['homeShots'] = homeShots;
    data['awayShots'] = awayShots;
    return data;
  }
}

class Info {
  String? home;
  String? problem;
  String? away;

  Info({this.home, this.problem, this.away});

  Info.fromJson(Map<String, dynamic> json) {
    home = json['home'];
    problem = json['problem'];
    away = json['away'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['home'] = home;
    data['problem'] = problem;
    data['away'] = away;
    return data;
  }
}
