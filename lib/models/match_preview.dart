
class MatchPreview {
  Header? header;
  GameInfo? gameInfo;
  // ignore: prefer_typing_uninitialized_variables
  var topScorers;
  // ignore: prefer_typing_uninitialized_variables
  var mostAssists;
  List<HeadToHead>? headToHead;

  MatchPreview(
      {this.header,
      this.gameInfo,
      this.topScorers,
      this.mostAssists,
      this.headToHead});

  MatchPreview.fromJson(Map<String, dynamic> json) {
    header =
        json['header'] != null ? Header.fromJson(json['header']) : null;
    gameInfo = json['game-info'] != null
        ? GameInfo.fromJson(json['game-info'])
        : null;
    topScorers = json['top-scorers'] ?? [];
    mostAssists = json['most-assists'] ?? [];

    if (json['headToHead'] != null) {
      headToHead = <HeadToHead>[];
      json['headToHead'].forEach((v) {
        headToHead!.add(HeadToHead.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (header != null) {
      data['header'] = header!.toJson();
    }
    if (gameInfo != null) {
      data['game-info'] = gameInfo!.toJson();
    }
    if (topScorers != null) {
      data['top-scorers'] = topScorers.map((v) => v.toJson()).toList();
    }
    if (mostAssists != null) {
      data['most-assists'] = mostAssists.map((v) => v.toJson()).toList();
    }
    if (headToHead != null) {
      data['headToHead'] = headToHead!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Header {
  String? league;
  String? tAway;
  String? tAwayImg;
  String? tAwaySnm;
  String? gameTime;
  String? homeAway;
  String? tHomeImg;
  String? tHomeSnm;

  Header(
      {this.league,
      this.tAway,
      this.tAwayImg,
      this.tAwaySnm,
      this.gameTime,
      this.homeAway,
      this.tHomeImg,
      this.tHomeSnm});

  Header.fromJson(Map<String, dynamic> json) {
    league = json['league'];
    tAway = json['tAway'];
    tAwayImg = json['tAwayImg'];
    tAwaySnm = json['tAwaySnm'];
    gameTime = json['game_time'].toString();
    homeAway = json['homeAway'];
    tHomeImg = json['tHomeImg'];
    tHomeSnm = json['tHomeSnm'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['league'] = league;
    data['tAway'] = tAway;
    data['tAwayImg'] = tAwayImg;
    data['tAwaySnm'] = tAwaySnm;
    data['game_time'] = gameTime;
    data['homeAway'] = homeAway;
    data['tHomeImg'] = tHomeImg;
    data['tHomeSnm'] = tHomeSnm;
    return data;
  }
}

class GameInfo {
  String? vanue;
  String? gtime;

  GameInfo({this.vanue, this.gtime});

  GameInfo.fromJson(Map<String, dynamic> json) {
    vanue = json['vanue'];
    gtime = json['gtime'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['vanue'] = vanue;
    data['gtime'] = gtime;
    return data;
  }
}

class TopScorers {
  String? pJarcyNo;
  String? pName;
  String? pStatus;

  TopScorers({this.pJarcyNo, this.pName, this.pStatus});

  TopScorers.fromJson(Map<String, dynamic> json) {
    pJarcyNo = json['pJarcyNo'];
    pName = json['pName'];
    pStatus = json['pStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['pJarcyNo'] = pJarcyNo;
    data['pName'] = pName;
    data['pStatus'] = pStatus;
    return data;
  }
}

class MostAssists {
  String? pJarcyNo;
  String? pName;
  String? pStatus;

  MostAssists({this.pJarcyNo, this.pName, this.pStatus});

  MostAssists.fromJson(Map<String, dynamic> json) {
    pJarcyNo = json['pJarcyNo'];
    pName = json['pName'];
    pStatus = json['pStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['pJarcyNo'] = pJarcyNo;
    data['pName'] = pName;
    data['pStatus'] = pStatus;
    return data;
  }
}

class HeadToHead {
  String? team1;
  String? t1Img;
  String? score;
  String? team2;
  String? t2Img;
  String? gameDate;
  String? league;

  HeadToHead(
      {this.team1,
      this.t1Img,
      this.score,
      this.team2,
      this.t2Img,
      this.gameDate,
      this.league});

  HeadToHead.fromJson(Map<String, dynamic> json) {
    team1 = json['team1'];
    t1Img = json['t1Img'];
    score = json['score'];
    team2 = json['team2'];
    t2Img = json['t2Img'];
    gameDate = json['gameDate'];
    league = json['league'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['team1'] = team1;
    data['t1Img'] = t1Img;
    data['score'] = score;
    data['team2'] = team2;
    data['t2Img'] = t2Img;
    data['gameDate'] = gameDate;
    data['league'] = league;
    return data;
  }
}
