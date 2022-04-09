class MatchDetailsHeader {
  Data? data;

  MatchDetailsHeader({this.data});

  MatchDetailsHeader.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? league;
  String? teamAway;
  String? teamAwayS;
  String? teamAwayImg;
  String? teamAwayScore;
  String? gameTime;
  String? gamePlay;
  String? homeAway;
  String? homeAwayS;
  String? teamHomeImg;
  String? teamHomeScore;

  Data(
      {this.league,
      this.teamAway,
      this.teamAwayS,
      this.teamAwayImg,
      this.teamAwayScore,
      this.gameTime,
      this.gamePlay,
      this.homeAway,
      this.homeAwayS,
      this.teamHomeImg,
      this.teamHomeScore});

  Data.fromJson(Map<String, dynamic> json) {
    league = json['league'];
    teamAway = json['teamAway'];
    teamAwayS = json['teamAwayS'];
    teamAwayImg = json['teamAwayImg'];
    teamAwayScore = json['teamAwayScore'];
    gameTime = json['game_time'];
    gamePlay = json['game_play'];
    homeAway = json['homeAway'];
    homeAwayS = json['homeAwayS'];
    teamHomeImg = json['teamHomeImg'];
    teamHomeScore = json['teamHomeScore'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['league'] = league;
    data['teamAway'] = teamAway;
    data['teamAwayS'] = teamAwayS;
    data['teamAwayImg'] = teamAwayImg;
    data['teamAwayScore'] = teamAwayScore;
    data['game_time'] = gameTime;
    data['game_play'] = gamePlay;
    data['homeAway'] = homeAway;
    data['homeAwayS'] = homeAwayS;
    data['teamHomeImg'] = teamHomeImg;
    data['teamHomeScore'] = teamHomeScore;
    return data;
  }
}
