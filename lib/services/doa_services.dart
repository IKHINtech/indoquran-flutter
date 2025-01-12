import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:indoquran/helpers/dio.dart';
import 'package:indoquran/models/doa_doa_model.dart';
import 'package:indoquran/models/doa_harian_model.dart';
import 'package:indoquran/models/doa_tahlil_model.dart';

class DoaServices {
  static Future<List<DoaHarian>> getListDoaHarian() async {
    try {
      final alquranAPI = dotenv.get("API_DOA_HARIAN");
      final Dio api = ClientApi(baseUrl: alquranAPI).dio;
      Response response = await api.get(
        '',
      );
      final result = doaHarianListFromJson(response.data);
      return result;
    } catch (e) {
      log(e.toString());
      throw Exception(e);
    }
  }

  static Future<List<DoaDoa>> getListDoaDoa() async {
    try {
      final alquranAPI = dotenv.get("API_DOA_DOA");
      final Dio api = ClientApi(baseUrl: alquranAPI).dio;
      Response response = await api.get(
        '',
      );
      final result = doaDoaListFromJson(response.data);
      return result;
    } catch (e) {
      log(e.toString());
      throw Exception(e);
    }
  }

  static Future<List<DoaTahlil>> getListDoaTahlil() async {
    try {
      final alquranAPI = dotenv.get("API_DOA_TAHLIL");
      final Dio api = ClientApi(baseUrl: alquranAPI).dio;
      Response response = await api.get(
        '',
      );
      final result = doaTahlilListFromJson(response.data);
      return result;
    } catch (e) {
      log(e.toString());
      throw Exception(e);
    }
  }
}
