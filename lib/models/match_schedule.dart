class MatchSchedule {
  List<RexFix>? rexFix;

  MatchSchedule({this.rexFix});

  MatchSchedule.fromJson(Map<String, dynamic> json) {
    if (json['rex-fix'] != null) {
      rexFix = <RexFix>[];
      json['rex-fix'].forEach((v) {
        rexFix!.add(RexFix.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (rexFix != null) {
      data['rex-fix'] = rexFix!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class RexFix {
  int? leagueId;
  String? title;
  int? matchCount;
  List<Matches>? matches;

  RexFix({leagueId, this.title, this.matchCount, this.matches});

  RexFix.fromJson(Map<String, dynamic> json) {
    leagueId = json['league_id'];
    title = json['title'];
    matchCount = json['match_count'];
    if (json['matches'] != null) {
      matches = <Matches>[];
      json['matches'].forEach((v) {
        matches!.add(Matches.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['league_id'] = leagueId;
    data['title'] = title;
    data['match_count'] = matchCount;
    if (matches != null) {
      data['matches'] = matches!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Matches {
  int? sId;
  String? matchId;
  String? tName1;
  String? sTName1;
  String? image1;
  String? result;
  String? tName2;
  String? sTName2;
  String? image2;
  String? score;
  String? mtime;

  Matches(
      {this.sId,
      this.matchId,
      this.tName1,
      this.sTName1,
      this.image1,
      this.result,
      this.tName2,
      this.sTName2,
      this.image2,
      this.score,
      this.mtime});

  Matches.fromJson(Map<String, dynamic> json) {
    sId = json['s_id'];
    matchId = json['match_id'];
    tName1 = json['tName1'];
    sTName1 = json['s_tName1'];
    image1 = json['image1'];
    result = json['result'];
    tName2 = json['tName2'];
    sTName2 = json['s_tName2'];
    image2 = json['image2'];
    score = json['score'];
    mtime = json['mtime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['s_id'] = sId;
    data['match_id'] = matchId;
    data['tName1'] = tName1;
    data['s_tName1'] = sTName1;
    data['image1'] = image1;
    data['result'] = result;
    data['tName2'] = tName2;
    data['s_tName2'] = sTName2;
    data['image2'] = image2;
    data['score'] = score;
    data['mtime'] = mtime;
    return data;
  }
}
