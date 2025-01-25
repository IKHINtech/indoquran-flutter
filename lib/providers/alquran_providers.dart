import 'package:flutter/material.dart';
import 'package:indoquran/models/surat_model.dart';
import 'package:indoquran/repository/surah/surah_repository.dart';
import 'package:indoquran/services/alquran_services.dart';

class SuratProvider extends ChangeNotifier {
  List<Surat> _surat = [];
  Surat? _suratDetail;
  List<Surat> get surat => _surat;
  Surat? get suratDetail => _suratDetail;
  bool _loading = false;
  bool _loadingDetail = false;
  bool get loading => _loading;
  bool get loadingDetail => _loadingDetail;

  void setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  void setLoadingDetail(bool value) {
    _loadingDetail = value;
    notifyListeners();
  }

  Future<List<Surat>> getListSuratFromDB() async {
    try {
      setLoading(true);
      final doaList = await SuratRepository().getSurat();
      List<Surat> res = doaList.map((item) => Surat.fromJson(item)).toList();
      if (res.isEmpty) {
        List<Surat> result = await AlquranServices.getListSurat();
        await SuratRepository().insertListSurat(result);
        _surat = result;
      } else {
        _surat = res;
      }
      notifyListeners();

      setLoading(false);
      return res;
    } catch (e) {
      setLoading(false);
      print("Error loading doa from database: $e");
      throw Exception(e);
    }
  }

  Future<void> getListSurat() async {
    try {
      if (_surat.isEmpty) {
        setLoading(true);
        List<Surat> result = await AlquranServices.getListSurat();
        _surat = result;
        notifyListeners();
        setLoading(false);
      }
    } catch (e) {
      setLoading(false);
      throw Exception(e);
    }
  }

  Future<void> getDetailSurah(String? nomorSurat) async {
    print("ini nomot =>$nomorSurat");
    try {
      if (_suratDetail == null) {
        String id = "1";
        if (nomorSurat != null) {
          id = nomorSurat;
        }
        setLoadingDetail(true);
        Surat result = await AlquranServices.getDetailSurat(id);
        print("ini result => $result");
        _suratDetail = result;
        notifyListeners();
        setLoadingDetail(false);
      }
    } catch (e) {
      print("$e");
      setLoading(false);
      throw Exception(e);
    }
  }
}
