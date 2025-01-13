import 'package:flutter/material.dart';
import 'package:indoquran/models/surat_model.dart';
import 'package:indoquran/services/alquran_services.dart';

class SuratProvider extends ChangeNotifier {
  List<Surat> _surat = [];
  List<Surat> get surat => _surat;
  bool _loading = false;
  bool get loading => _loading;
  void setLoading(bool value) {
    _loading = value;
    notifyListeners();
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
}
