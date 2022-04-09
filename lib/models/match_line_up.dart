class MatchLineUp {
  Header1? header1;
  Header1? header2;
  List<PlayerList>? playerList;

  MatchLineUp({this.header1, this.header2, this.playerList});

  MatchLineUp.fromJson(Map<String, dynamic> json) {
    header1 =
        json['header1'] != null ? Header1.fromJson(json['header1']) : null;
    header2 =
        json['header2'] != null ? Header1.fromJson(json['header2']) : null;
    if (json['player-list'] != null) {
      playerList = <PlayerList>[];
      json['player-list'].forEach((v) {
        playerList!.add(PlayerList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (header1 != null) {
      data['header1'] = header1!.toJson();
    }
    if (header2 != null) {
      data['header2'] = header2!.toJson();
    }
    if (playerList != null) {
      data['player-list'] = playerList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Header1 {
  String? t1Image;
  String? t1Text;

  Header1({this.t1Image, this.t1Text});

  Header1.fromJson(Map<String, dynamic> json) {
    t1Image = json['t1Image'];
    t1Text = json['t1Text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['t1Image'] = t1Image;
    data['t1Text'] = t1Text;
    return data;
  }
}

class PlayerList {
  String? iconT1Start;
  String? t1pNo;
  String? t1pName;
  EndIcon? endIcon;

  PlayerList({this.iconT1Start, this.t1pNo, this.t1pName, this.endIcon});

  PlayerList.fromJson(Map<String, dynamic> json) {
    iconT1Start = json['iconT1Start'];
    t1pNo = json['t1pNo'];
    t1pName = json['t1pName'];
    endIcon =
        json['endIcon'] != null ? EndIcon.fromJson(json['endIcon']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['iconT1Start'] = iconT1Start;
    data['t1pNo'] = t1pNo;
    data['t1pName'] = t1pName;
    if (endIcon != null) {
      data['endIcon'] = endIcon!.toJson();
    }
    return data;
  }
}

class EndIcon {
  String? yelloCrd;
  String? redCrd;
  String? goal;

  EndIcon({this.yelloCrd, this.redCrd, this.goal});

  EndIcon.fromJson(Map<String, dynamic> json) {
    yelloCrd = json['yelloCrd'];
    redCrd = json['redCrd'];
    goal = json['goal'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['yelloCrd'] = yelloCrd;
    data['redCrd'] = redCrd;
    data['goal'] = goal;
    return data;
  }
}
