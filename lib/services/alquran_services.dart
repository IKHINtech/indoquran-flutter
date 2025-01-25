import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:indoquran/helpers/dio.dart';
import 'package:indoquran/models/surat_model.dart';

class AlquranServices {
  static Future<List<Surat>> getListSurat() async {
    try {
      final alquranAPI = dotenv.get("API_1");
      final Dio api = ClientApi(baseUrl: alquranAPI).dio;
      Response response = await api.get(
        '/surat',
      );
      final result = suratListFromJson(response.data);
      return result;
    } catch (e) {
      log(e.toString());
      throw Exception(e);
    }
  }

  static Future<Surat> getDetailSurat(String nomorSurat) async {
    try {
      final alquranAPI = dotenv.get("API_1");
      final Dio api = ClientApi(baseUrl: alquranAPI).dio;
      Response response = await api.get(
        '/surat/$nomorSurat',
      );
      print("ini result =>${response.data}");
      final result = suratFromJson(response.data);
      return result;
    } catch (e) {
      log(e.toString());
      throw Exception(e);
    }
  }
}
