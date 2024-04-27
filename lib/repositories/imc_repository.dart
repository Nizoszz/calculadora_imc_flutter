import 'dart:convert';

import 'package:calculadora_imc_flutter/model/imc_model.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IMCRepository {

  static late Box _box;

  IMCRepository._create();

  static Future<IMCRepository> load() async {
    Hive.isBoxOpen('imc') ?
    _box = Hive.box('imc') :
    _box = await Hive.openBox('imc');
    return IMCRepository._create();
  }

  save(IMCModel imcModel) {
    _box.add(imcModel);
  }

  dynamic findAll() {
    return _box.values.cast<IMCModel>().toList();
  }

  remove(IMCModel imcModel) {
    imcModel.delete();
  }

}
