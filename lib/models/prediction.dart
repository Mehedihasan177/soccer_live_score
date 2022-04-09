// ignore_for_file: non_constant_identifier_names

class Prediction {
  bool? status;
  List<Data>? data;

  Prediction({this.status, this.data});

  Prediction.fromJson(Map<String, dynamic> json) {
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
  String? teamOneWinningPrediction;
  String? teamOneImage;
  String? teamTwoName;
  String? teamTwoWinningPrediction;
  String? teamTwoImage;
  String? matchTitle;
  String? matchTiePrediction;
  String? prediction_details;

  Data(
      {this.id,
      this.teamOneName,
      this.teamOneWinningPrediction,
      this.teamOneImage,
      this.teamTwoName,
      this.teamTwoWinningPrediction,
      this.teamTwoImage,
      this.matchTitle,
      this.matchTiePrediction,
      this.prediction_details});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    teamOneName = json['team_one_name'];
    teamOneWinningPrediction = json['team_one_winning_prediction'];
    teamOneImage = json['team_one_image'];
    teamTwoName = json['team_two_name'];
    teamTwoWinningPrediction = json['team_two_winning_prediction'];
    teamTwoImage = json['team_two_image'];
    matchTitle = json['match_title'];
    matchTiePrediction = json['match_tie_prediction'];
    prediction_details = json['prediction_details'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['team_one_name'] = teamOneName;
    data['team_one_winning_prediction'] = teamOneWinningPrediction;
    data['team_one_image'] = teamOneImage;
    data['team_two_name'] = teamTwoName;
    data['team_two_winning_prediction'] = teamTwoWinningPrediction;

    data['team_two_image'] = teamTwoImage;
    data['match_title'] = matchTitle;
    data['match_tie_prediction'] = matchTiePrediction;
    data['prediction_details'] = prediction_details;
    return data;
  }
}
