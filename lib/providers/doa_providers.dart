import 'package:flutter/material.dart';
import 'package:indoquran/models/doa_doa_model.dart';
import 'package:indoquran/models/doa_harian_model.dart';
import 'package:indoquran/models/doa_tahlil_model.dart';
import 'package:indoquran/repository/doa/doa_doa_repository.dart';
import 'package:indoquran/services/doa_services.dart';

class DoaProvider extends ChangeNotifier {
  List<DoaHarian> _doaHarian = [];
  List<DoaDoa> _doaDoa = [];
  List<DoaTahlil> _doaTahlil = [];
  List<DoaHarian> get doaHarian => _doaHarian;
  List<DoaDoa> get doaDoa => _doaDoa;
  List<DoaTahlil> get doaTahlil => _doaTahlil;

  bool _loadingDoaHarian = false;
  bool get loadingDoaHarian => _loadingDoaHarian;
  void setloadingDoaHarian(bool value) {
    _loadingDoaHarian = value;
    notifyListeners();
  }

  bool _loadingDoaDoa = false;
  bool get loadingDoaDoa => _loadingDoaDoa;
  void setloadingDoaDoa(bool value) {
    _loadingDoaDoa = value;
    notifyListeners();
  }

  bool _loadingDoaTahlil = false;
  bool get loadingDoaTahlil => _loadingDoaTahlil;
  void setloadingDoaTahlil(bool value) {
    _loadingDoaTahlil = value;
    notifyListeners();
  }

  Future<void> getListDoaHarian() async {
    try {
      if (_doaHarian.isEmpty) {
        setloadingDoaHarian(true);
        List<DoaHarian> result = await DoaServices.getListDoaHarian();
        _doaHarian = result;
        notifyListeners();
        setloadingDoaHarian(false);
      }
    } catch (e) {
      setloadingDoaHarian(false);
      throw Exception(e);
    }
  }

  Future<List<DoaDoa>> getListDoaDoa() async {
    try {
      if (_doaDoa.isEmpty) {
        setloadingDoaDoa(true);
        List<DoaDoa> result = await DoaServices.getListDoaDoa();
        print("ini result => ${result}");
        _doaDoa = result;
        notifyListeners();
        setloadingDoaDoa(false);
        return result;
      }
      return _doaDoa;
    } catch (e) {
      setloadingDoaDoa(false);
      throw Exception(e);
    }
  }

  Future<List<DoaDoa>> getListDodDoaFromDB() async {
    try {
      final doaList = await DoaDoaRepository().getDoaDoa();
      List<DoaDoa> res = doaList.map((item) => DoaDoa.fromJson(item)).toList();
      _doaDoa = res;
      notifyListeners();
      return res;
    } catch (e) {
      print("Error loading doa from database: $e");
      throw Exception(e);
    }
  }

  Future<void> getListDoaTahlil() async {
    try {
      if (_doaTahlil.isEmpty) {
        setloadingDoaTahlil(true);
        List<DoaTahlil> result = await DoaServices.getListDoaTahlil();
        _doaTahlil = result;
        notifyListeners();
        setloadingDoaTahlil(false);
      }
    } catch (e) {
      setloadingDoaTahlil(false);
      throw Exception(e);
    }
  }
}
