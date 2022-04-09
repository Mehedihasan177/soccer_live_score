class LiveMatches {
  bool? status;
  List<Data>? data;

  LiveMatches({this.status, this.data});

  LiveMatches.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data?.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  String? matchTitle;
  String? teamOneName;
  String? teamOneImage;
  String? teamTwoName;
  String? teamTwoImage;
  String? streamUrl;

  Data(
      {this.id,
      this.matchTitle,
      this.teamOneName,
      this.teamOneImage,
      this.teamTwoName,
      this.teamTwoImage,
      this.streamUrl});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    matchTitle = json['match_title'];
    teamOneName = json['team_one_name'];
    teamOneImage = json['team_one_image'];
    teamTwoName = json['team_two_name'];
    teamTwoImage = json['team_two_image'];
    streamUrl = json['stream_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['match_title'] = matchTitle;
    data['team_one_name'] = teamOneName;
    data['team_one_image'] = teamOneImage;
    data['team_two_name'] = teamTwoName;
    data['team_two_image'] = teamTwoImage;
    data['stream_url'] = streamUrl;
    return data;
  }
}
