class MatchCommentary {
  List<Commentary>? commentary;
  List<Commentary>? keyCommentary;

  MatchCommentary({this.commentary, this.keyCommentary});

  MatchCommentary.fromJson(Map<String, dynamic> json) {
    if (json['commentary'] != null) {
      commentary = <Commentary>[];
      json['commentary'].forEach((v) {
        commentary!.add(Commentary.fromJson(v));
      });
    }
    if (json['key_commentary'] != null) {
      keyCommentary = <Commentary>[];
      json['key_commentary'].forEach((v) {
        keyCommentary!.add(Commentary.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (commentary != null) {
      data['commentary'] = commentary!.map((v) => v.toJson()).toList();
    }
    if (keyCommentary != null) {
      data['key_commentary'] =
          keyCommentary!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Commentary {
  String? timeStamp;
  String? gameDetails;
  String? iconFinder;

  Commentary({this.timeStamp, this.gameDetails, this.iconFinder});

  Commentary.fromJson(Map<String, dynamic> json) {
    timeStamp = json['timeStamp'];
    gameDetails = json['gameDetails'];
    iconFinder = json['iconFinder'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['timeStamp'] = timeStamp;
    data['gameDetails'] = gameDetails;
    data['iconFinder'] = iconFinder;
    return data;
  }
}
