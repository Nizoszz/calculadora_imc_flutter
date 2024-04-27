import 'package:calculadora_imc_flutter/model/imc_model.dart';

class IMCService{

  IMCModel calculate(double weight, double height) {
    double imc = weight / (height * height);
    var ranking = _typeIMC(imc);
    var imcObj = IMCModel(weight: weight, height: height, rankIMC: ranking);
    return imcObj;
  }

  String _typeIMC(imc){
    final ranking = {
      16: 'Magreza Grave',
      17: 'Magreza Moderada',
      18.5: 'Magreza Leve',
      25: 'Saudável',
      30: 'Sobrepeso',
      35: 'Obesidade Grau I',
      40: 'Obesidade Grau II (severa)',
      double.infinity: 'Obesidade Grau III (mórbida)',
    };

    final rankingResult = ranking.entries
        .firstWhere((entry) => imc <= entry.key, orElse: () => ranking.entries.last)
        .value;

    return rankingResult;
  }
}