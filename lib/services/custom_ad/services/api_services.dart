import 'dart:convert';

import 'package:http/http.dart' as http;
import '../models/custom_ad.dart';
import '/consts/consts.dart';

class CustomAdApiService {
  static var client = http.Client();

  static Future<CustomAdModel> loadAd(type) async {
    var response = await client.post(
      Uri.parse(
          AppConsts.BASE_URL + '/api/v1/customads/$type/' + AppConsts.APP_ID),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'api_key': AppConsts.API_KEY,
      }),
    );

    if (response.statusCode == 200) {
      var jsonString = response.body;
      return CustomAdModel.fromJson(jsonDecode(jsonString));
    } else {
      //show error message
      return CustomAdModel();
    }
  }
}
