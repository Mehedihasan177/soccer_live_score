import 'dart:convert';

import 'package:big_soccer/models/football_news.dart';
import 'package:big_soccer/models/live_matches.dart';
import 'package:http/http.dart' as http;
import '../models/prediction.dart';
import '/models/standing_leagues.dart';
import '/models/standing_years.dart';
import '/models/standings.dart';
import '/models/match_commentary.dart';
import '/models/match_details_header.dart';
import '/models/match_line_up.dart';
import '/models/match_preview.dart';
import '/models/match_statistics.dart';
import '/consts/consts.dart';
import '/models/match_schedule.dart';
import '/models/setting.dart';

class ApiService {
  static var client = http.Client();

  static Future<Setting> loadSettings() async {
    var response = await client.post(
      Uri.parse(AppConsts.BASE_URL + AppConsts.SETTINGS + AppConsts.APP_ID),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'api_key': AppConsts.API_KEY,
      }),
    );
    if (response.statusCode == 200) {
      var jsonString = response.body;
      return Setting.fromJson(jsonDecode(jsonString));
    } else {
      return Setting();
    }
  }

  static Future<LiveMatches> loadLiveMatches() async {
    var response = await client.post(
      Uri.parse(AppConsts.BASE_URL + AppConsts.LIVE_MATCHES + AppConsts.APP_ID),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'api_key': AppConsts.API_KEY,
      }),
    );
    if (response.statusCode == 200) {
      var jsonString = response.body;
      return LiveMatches.fromJson(jsonDecode(jsonString));
    } else {
      return LiveMatches();
    }
  }

  static Future<MatchSchedule> loadFootballSchedule(matchDate, type) async {
    Uri uri = Uri.parse(AppConsts.BASE_URL + AppConsts.schedule);

    String body = jsonEncode(<String, dynamic>{
      'api_key': AppConsts.API_KEY,
      'date': matchDate,
      'type': type,
    });

    var response = await client.post(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: body,
    );

    if (response.statusCode == 200) {
      var jsonString = response.body;
      return MatchSchedule.fromJson(jsonDecode(jsonString));
    } else {
      return MatchSchedule();
    }
  }

  static Future<MatchPreview> loadMatchPreview(matchId) async {
    var response = await client.post(
      Uri.parse(AppConsts.BASE_URL + AppConsts.matchPreview),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'api_key': AppConsts.API_KEY,
        'gameId': matchId,
      }),
    );
    if (response.statusCode == 200) {
      var jsonString = response.body;
      return MatchPreview.fromJson(jsonDecode(jsonString));
    } else {
      return MatchPreview();
    }
  }

  static Future<StandingLeague> loadStandingLeagues() async {
    var response = await client.post(
      Uri.parse(AppConsts.BASE_URL + AppConsts.standingLeague),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'api_key': AppConsts.API_KEY,
      }),
    );

    if (response.statusCode == 200) {
      var jsonString = response.body;
      return StandingLeague.fromJson(jsonDecode(jsonString));
    } else {
      return StandingLeague();
    }
  }

  static Future<StandingYears> loadStandingYears(link) async {
    var response = await client.post(
      Uri.parse(AppConsts.BASE_URL + AppConsts.standingYear),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'api_key': AppConsts.API_KEY,
        'url': link,
      }),
    );
    if (response.statusCode == 200) {
      var jsonString = response.body;
      return StandingYears.fromJson(jsonDecode(jsonString));
    } else {
      return StandingYears();
    }
  }

  static Future<Standings> loadStandings(url) async {
    var response = await client.post(
      Uri.parse(AppConsts.BASE_URL + AppConsts.standing),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'api_key': AppConsts.API_KEY,
        'url': url,
      }),
    );
    if (response.statusCode == 200) {
      var jsonString = response.body;
      return Standings.fromJson(jsonDecode(jsonString));
    } else {
      return Standings();
    }
  }

  static Future<MatchDetailsHeader> loadMatchHeader(matchId) async {
    var response = await client.post(
      Uri.parse(AppConsts.BASE_URL + AppConsts.matchDetailsHeader),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'api_key': AppConsts.API_KEY,
        'gameId': matchId,
      }),
    );
    if (response.statusCode == 200) {
      var jsonString = response.body;
      return MatchDetailsHeader.fromJson(jsonDecode(jsonString));
    } else {
      return MatchDetailsHeader();
    }
  }

  static Future<MatchLineUp> loadLineUp(matchId, team) async {
    var response = await client.post(
      Uri.parse(AppConsts.BASE_URL + AppConsts.matchLineUps),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'api_key': AppConsts.API_KEY,
        'gameId': matchId,
        'teamNo': team,
      }),
    );
    if (response.statusCode == 200) {
      var jsonString = response.body;
      return MatchLineUp.fromJson(jsonDecode(jsonString));
    } else {
      return MatchLineUp();
    }
  }

  static Future<MatchCommentary> loadCommentary(matchId) async {
    var response = await client.post(
      Uri.parse(AppConsts.BASE_URL + AppConsts.matchCommentary),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'api_key': AppConsts.API_KEY,
        'gameId': matchId,
      }),
    );
    if (response.statusCode == 200) {
      var jsonString = response.body;
      return MatchCommentary.fromJson(jsonDecode(jsonString));
    } else {
      return MatchCommentary();
    }
  }

  static Future<MatchStatistics> loadStatistics(matchId) async {
    var response = await client.post(
      Uri.parse(AppConsts.BASE_URL + AppConsts.matchStatistics),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'api_key': AppConsts.API_KEY,
        'gameId': matchId,
      }),
    );
    if (response.statusCode == 200) {
      var jsonString = response.body;
      return MatchStatistics.fromJson(jsonDecode(jsonString));
    } else {
      return MatchStatistics();
    }
  }

  static Future<FootballNews> laodFootballNews() async {
    var response = await client.post(
      Uri.parse(AppConsts.BASE_URL + AppConsts.NEWS),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'api_key': AppConsts.API_KEY,
      }),
    );
    if (response.statusCode == 200) {
      var jsonString = response.body;
      return FootballNews.fromJson(jsonDecode(jsonString));
    } else {
      return FootballNews();
    }
  }

  static Future<Prediction> laodPrediction() async {
    var response = await client.post(
      Uri.parse(AppConsts.BASE_URL + AppConsts.predictions + AppConsts.APP_ID),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'api_key': AppConsts.API_KEY,
      }),
    );
    if (response.statusCode == 200) {
      var jsonString = response.body;
      return Prediction.fromJson(jsonDecode(jsonString));
    } else {
      return Prediction();
    }
  }

  static Future addUser(data) async {
    data['api_key'] = AppConsts.API_KEY;

    var response = await client.post(
      Uri.parse(AppConsts.BASE_URL + AppConsts.ADD_USER + AppConsts.APP_ID),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(data),
    );
    if (response.statusCode == 200) {
      var jsonString = response.body;
      return jsonDecode(jsonString);
    } else {
      return null;
    }
  }

  //------------//
}
