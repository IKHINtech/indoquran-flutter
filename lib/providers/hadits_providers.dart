import 'package:flutter/material.dart';
import 'package:indoquran/models/hadits_model.dart';
import 'package:indoquran/repository/hadits/hadits_repository.dart';
import 'package:indoquran/services/hadits_services.dart';

class HaditsProvider extends ChangeNotifier {
  List<Hadits> _hadits = [];
  List<Hadits> get hadits => _hadits;
  bool _loading = false;
  bool get loading => _loading;
  void setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> getListHadits() async {
    try {
      if (_hadits.isEmpty) {
        setLoading(true);
        List<Hadits> result = await HaditsServices.getListHadits();
        _hadits = result;
        notifyListeners();
        setLoading(false);
      }
    } catch (e) {
      setLoading(false);
      throw Exception(e);
    }
  }

  Future<List<Hadits>> getListHaditsFromDB() async {
    try {
      setLoading(true);
      final doaList = await HaditsRepository().getHadits();
      List<Hadits> res = doaList.map((item) => Hadits.fromJson(item)).toList();
      if (res.isEmpty) {
        List<Hadits> result = await HaditsServices.getListHadits();
        await HaditsRepository().insertListHadits(result);
        _hadits = result;
      } else {
        _hadits = res;
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
}
