import 'package:flutter/material.dart';
import 'package:indoquran/models/hadits_model.dart';
import 'package:indoquran/services/hadits_services.dart';

class HaditsProvider extends ChangeNotifier {
  List<Hadits> _surat = [];
  List<Hadits> get surat => _surat;
  bool _loading = false;
  bool get loading => _loading;
  void setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> getListHadits() async {
    try {
      setLoading(true);
      List<Hadits> result = await HaditsServices.getListHadits();
      _surat = result;
      notifyListeners();
      setLoading(false);
    } catch (e) {
      setLoading(false);
      throw Exception(e);
    }
  }
}
