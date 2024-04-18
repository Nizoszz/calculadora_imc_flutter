import 'package:calculadora_imc_flutter/model/imc.dart';
import 'package:calculadora_imc_flutter/repositories/imc_repository.dart';
import 'package:calculadora_imc_flutter/services/imc_service.dart';
import 'package:flutter/material.dart';

class RegisterData extends StatefulWidget {
  const RegisterData({super.key});

  @override
  State<RegisterData> createState() => _RegisterDataState();
}

class _RegisterDataState extends State<RegisterData> {
  final _imcRepository = IMCRepository();
  var _listIMC = <IMC>[];
  final _weightController = TextEditingController();
  final _heightController = TextEditingController();
  final _imcService = IMCService();

  @override
  void initState() {
    super.initState();
    loadIMCS();
  }

  void loadIMCS() async {
    _listIMC = await _imcRepository.readList();
    print(_listIMC);
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromRGBO(47, 79, 79, 1),
        child: const Icon(Icons.library_add_sharp,
          color: Colors.white
        ),
        onPressed: () {
          _weightController.text = "";
          _heightController.text = "";
          showDialog(
              context: context,
              builder: (BuildContext bc) {
                return AlertDialog(
                  title: const Text("Enter data to calculate IMC"),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(
                        controller: _weightController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Color.fromRGBO(47, 79, 79, 1),
                            )
                          ),
                          hintText: "Weight"
                        ),
                      ),
                      TextField(
                        controller: _heightController,
                        keyboardType: TextInputType.number,

                        decoration: const InputDecoration(
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color:  Color.fromRGBO(47, 79, 79, 1),
                                )
                            ),
                          hintText: "Height"
                        ),
                      ),
                    ],
                  ),
                  actions: [
                    TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: const Color.fromRGBO(47, 79, 79, 1),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                        Radius.circular(4)
                          )
                        ),
                      ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("Cancel",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 16
                            )
                        )
                    ),
                    TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: const Color.fromRGBO(47, 79, 79, 1),
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(4)
                              )
                          ),
                        ),
                        onPressed: () async {
                          // await _imcRepository.add(IMC(8, 8));
                          var imcOjb = _imcService.
                          calculate(double.tryParse(_weightController.text) ?? 0,
                              double.tryParse(_heightController.text) ?? 0);
                          await _imcRepository.add(imcOjb);
                          Navigator.pop(context);
                          setState(() {
                          });
                        },
                        child: const Text("Confirm",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 16
                          )
                        )
                    ),
                  ],
                );
              }
          );
        },
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(left: 20, right: 24, top: 10, bottom: 10),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 1,
                    child: Text("Ranking",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        color: Colors.white
                      )
                    ),
                  ),
                 Expanded(
                   flex: 1,
                   child: Row(
                     crossAxisAlignment: CrossAxisAlignment.center,
                     mainAxisAlignment: MainAxisAlignment.end,
                   children: [
                     Text("Weight",
                         style: TextStyle(
                             fontSize: 18,
                             fontWeight: FontWeight.w600,
                             color: Colors.white
                         )
                     ),
                     const SizedBox(
                       width: 20,
                     ),
                     Text("Height",
                         style: TextStyle(
                             fontSize: 18,
                             fontWeight: FontWeight.w600,
                             color: Colors.white
                         ),
                     ),
                   ],
                  ),
                 ),
                ],
              ),
            ),
          Expanded(
              child: ListView.builder(
                  itemCount: _listIMC.length,
                  itemBuilder: (BuildContext bc, int index){
                    var imc = _listIMC[index];
                    return Dismissible(
                      onDismissed: (DismissDirection direction) async {
                        await _imcRepository.remove(imc.id);
                        loadIMCS();
                      },
                        key: Key(imc.id),
                        child: Card(
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(4)
                            ),
                          ),
                          elevation: 5,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 2,
                                    child: Container(
                                        child: Text(imc.rankIMC)
                                    )
                                ),
                                Expanded(
                                  flex: 1,
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: 40,
                                          child: Text(imc.weight.toString(),
                                            style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 40,
                                        ),
                                        Text(imc.height.toString()),
                                      ],
                                    )
                                ),
                              ],
                            ),
                          )),
                    );
                  }
              ),
          ),
        ],
      ),
    );
  }
}

