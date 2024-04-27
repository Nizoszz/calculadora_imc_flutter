import 'package:calculadora_imc_flutter/model/imc_model.dart';
import 'package:calculadora_imc_flutter/repositories/imc_repository.dart';
import 'package:calculadora_imc_flutter/services/imc_service.dart';
import 'package:flutter/material.dart';

import '../services/storage_service.dart';

class RegisterData extends StatefulWidget {
  const RegisterData({super.key});

  @override
  State<RegisterData> createState() => _RegisterDataState();
}

class _RegisterDataState extends State<RegisterData> {
  late IMCRepository repository;
  IMCService service = IMCService();
  var _listIMC = <IMCModel>[];
  final _weightController = TextEditingController();
  final _heightController = TextEditingController();
  final _nameController = TextEditingController();
  AppStorageService storage = AppStorageService();
  bool save = false;

  @override
  void initState() {
    super.initState();
    loadIMCS();

  }

  void loadIMCS() async {
    repository = await IMCRepository.load();
    _listIMC = repository.findAll();
    var storage = AppStorageService();
    _nameController.text = await storage.getName();
    _heightController.text = (await Future.value(storage.getHeight())).toString();
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
          showDialog(
              context: context,
              builder: (BuildContext bc) {
                return AlertDialog(
                  title: const Text("Enter data to calculate IMC"),
                  content: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextField(
                          controller: _nameController,
                          keyboardType: TextInputType.text,
                          readOnly: _nameController.text.isNotEmpty? true : false,
                          decoration: const InputDecoration(
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color.fromRGBO(47, 79, 79, 1),
                                  )
                              ),
                              hintText: "Name"
                          ),
                        ),
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
                          readOnly: _heightController.text.isNotEmpty? true : false,
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
                          setState(() {
                            save = true;
                          });
                          Navigator.pop(context);
                          // var imcOjb = _imcService.
                          // calculate(double.tryParse(_weightController.text) ?? 0,
                          //     double.tryParse(_heightController.text) ?? 0);
                          await storage.setName(_nameController.text);
                          await storage.setHeight(double.tryParse(_heightController.text) ?? 0.0);
                          await storage.setWeight(double.tryParse(_weightController.text) ?? 0.0);
                          var imcModel = service.calculate(double.tryParse(_weightController.text) ?? 0.0, double.tryParse(_heightController.text) ?? 0.0);
                          await repository.save(imcModel);
                          ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                          content: Text("Dados salvos com sucesso!")));
                          loadIMCS();
                          setState(() {
                            save = false;
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
      body: save ? const Center(child: CircularProgressIndicator(
        backgroundColor: Color.fromRGBO(47, 79, 79, 1),
        color: Colors.white,
      )) : Column(
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
                     SizedBox(
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
                        await repository.remove(imc);
                        loadIMCS();
                      },
                        key: Key(imc.key.toString()),
                        child: Card(
                          color: Colors.transparent,
                          surfaceTintColor: Colors.black12,
                          shadowColor: Colors.transparent,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(3)
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
                                    child: Text(imc.rankIMC,
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500),
                                    )
                                ),
                                Expanded(
                                  flex: 1,
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: 60,
                                          child: Text(imc.weight.toStringAsFixed(2),
                                            style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.white
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        Text(imc.height.toStringAsFixed(2),
                                          style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.white
                                          ),
                                        ),
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

