import 'package:criminal/pages/resultado.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

final _formKey = GlobalKey<FormState>();

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<String> respostas = [];

  final TextEditingController telefoneController = TextEditingController();
  final TextEditingController localController = TextEditingController();
  final TextEditingController moradiaController = TextEditingController();
  final TextEditingController deviaController = TextEditingController();
  final TextEditingController trabalhouController = TextEditingController();

  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  void enviar() {
    respostas = [];
    respostas.add(telefoneController.text);
    respostas.add(localController.text);
    respostas.add(moradiaController.text);
    respostas.add(deviaController.text);
    respostas.add(trabalhouController.text);

    int respostasSim = 0;
    for (String resposta in respostas) {
      if (resposta.toLowerCase() == 'sim') {
        respostasSim++;
      }
    }

    //final prefs = await _prefs;
    //await prefs.setInt('Respostas Positivas', respostasSim);

    telefoneController.clear();
    localController.clear();
    moradiaController.clear();
    deviaController.clear();
    trabalhouController.clear();

  _formKey.currentState!.validate();

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Resultado(),
      settings: RouteSettings(arguments: respostasSim)),
    );

    //print(respostas);
    //print('Número de respostas positivas salvas: $respostasSim');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(30),
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: telefoneController,
                  decoration: InputDecoration(labelText: "Telefonou para a vítima ?",
                  hintText: "Sim ou Não ?"),
                  validator: (name) => name!.length > 3 ? 
                  'Sua resposta deve ser apenas sim ou não' : null,
                ),
                TextFormField(
                  controller: localController,
                  decoration: InputDecoration(labelText: "Esteve no local do crime?",
                  hintText: "Sim ou Não ?"),
                ),
                TextFormField(
                  controller: moradiaController,
                  decoration: InputDecoration(labelText: "Mora perto da vítima ?",
                  hintText: "Sim ou Não ?"),
                ),
                TextFormField(
                  controller: deviaController,
                  decoration: InputDecoration(labelText: "Devia para a vítima?",
                  hintText: "Sim ou Não ?"),
                ),
                SizedBox(height: 8),
                TextFormField(
                  controller: trabalhouController,
                  decoration: InputDecoration(labelText: "Já trabalhou com a vítima?",
                  hintText: "Sim ou Não ?"),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: enviar,
                  child: Text("Enviar"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
