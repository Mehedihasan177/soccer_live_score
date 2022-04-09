class LiveMatch {
  bool? status;
  List<Data>? data;

  LiveMatch({this.status, this.data});

  LiveMatch.fromJson(Map<String, dynamic> json) {
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
  String? teamOneName;
  String? teamTwoName;
  String? matchTitle;
  String? matchTime;
  String? teamOneImage;
  String? teamTwoImage;
  List<StreamingSources>? streamingSources;

  Data(
      {this.id,
      this.teamOneName,
      this.teamTwoName,
      this.matchTitle,
      this.matchTime,
      this.teamOneImage,
      this.teamTwoImage,
      this.streamingSources});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    teamOneName = json['team_one_name'];
    teamTwoName = json['team_two_name'];
    matchTitle = json['match_title'];
    matchTime = json['match_time'];
    teamOneImage = json['team_one_image'];
    teamTwoImage = json['team_two_image'];
    if (json['streaming_sources'] != null) {
      streamingSources = <StreamingSources>[];
      json['streaming_sources'].forEach((v) {
        streamingSources?.add(StreamingSources.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['team_one_name'] = teamOneName;
    data['team_two_name'] = teamTwoName;
    data['match_title'] = matchTitle;
    data['match_time'] = matchTime;
    data['team_one_image'] = teamOneImage;
    data['team_two_image'] = teamTwoImage;
    if (streamingSources != null) {
      data['streaming_sources'] =
          streamingSources?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class StreamingSources {
  int? id;
  int? matchId;
  String? streamTitle;
  String? streamType;
  String? streamUrl;
  String? createdAt;
  String? updatedAt;

  StreamingSources(
      {this.id,
      this.matchId,
      this.streamTitle,
      this.streamType,
      this.streamUrl,
      this.createdAt,
      this.updatedAt});

  StreamingSources.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    matchId = json['match_id'];
    streamTitle = json['stream_title'];
    streamType = json['stream_type'];
    streamUrl = json['stream_url'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['match_id'] = matchId;
    data['stream_title'] = streamTitle;
    data['stream_type'] = streamType;
    data['stream_url'] = streamUrl;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
