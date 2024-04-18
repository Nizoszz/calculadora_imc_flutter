import 'package:flutter/cupertino.dart';

class IMC{
  final String _id = UniqueKey().toString();
  double _weight = 0;
  double _height = 0;
  String _rankIMC = "";

  IMC(this._weight, this._height);

  double get weight => _weight;

  set weight(double value) {
    _weight = value;
  }

  String get rankIMC => _rankIMC;

  set rankIMC(String value) {
    _rankIMC = value;
  }

  String get id => _id;

  double get height => _height;

  set height(double value) {
    _height = value;
  }
}