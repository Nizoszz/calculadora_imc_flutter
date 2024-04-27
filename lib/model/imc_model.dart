import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';

part 'imc_model.g.dart';

@HiveType(typeId: 1)
class IMCModel extends HiveObject{
  @HiveField(0)
  final String _id = UniqueKey().toString();
  @HiveField(1)
  final double weight;
  @HiveField(2)
  final double height;
  @HiveField(3)
  final String rankIMC;

  IMCModel({required this.weight, required this.height, required this.rankIMC});

  String get id => _id;

}

