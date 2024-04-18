import 'package:calculadora_imc_flutter/model/imc.dart';

class IMCRepository{
  final List<IMC> _imcs = [];

  Future<void> add(IMC imc) async {
    await Future.delayed(const Duration(milliseconds: 300));
    _imcs.add(imc);
  }

  Future<void> update(String id) async {
    await Future.delayed(const Duration(milliseconds: 100));
    _imcs
        .where((element) => element.id == id)
        .first;
  }

  Future<void> remove(String id) async {
    await Future.delayed(const Duration(milliseconds: 100));
    _imcs.remove(
        _imcs
            .where((element) => element.id == id)
            .first
    );
  }

  Future<List<IMC>> readList() async {
    await Future.delayed(const Duration(milliseconds: 100));

    return _imcs;
  }

}