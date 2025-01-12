import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:indoquran/helpers/dio.dart';
import 'package:indoquran/models/hadits_model.dart';

class HaditsServices {
  static Future<List<Hadits>> getListHadits() async {
    try {
      final alquranAPI = dotenv.get("API_HADITS");
      final Dio api = ClientApi(baseUrl: alquranAPI).dio;
      Response response = await api.get(
        '',
      );
      final result = haditsListFromJson(response.data);
      return result;
    } catch (e) {
      log(e.toString());
      throw Exception(e);
    }
  }
}
