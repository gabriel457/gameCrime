import 'package:criminal/pages/resultado.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  void enviar() async {
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

    final prefs = await _prefs;
    await prefs.setInt('Respostas Positivas', respostasSim);

    telefoneController.clear();
    localController.clear();
    moradiaController.clear();
    deviaController.clear();
    trabalhouController.clear();

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Resultado()),
    );

    print(respostas);
    print('Número de respostas positivas salvas: $respostasSim');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(30),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: telefoneController,
                decoration: InputDecoration(labelText: "Telefonou para a vítima ?"),
              ),
              TextField(
                controller: localController,
                decoration: InputDecoration(labelText: "Esteve no local do crime?"),
              ),
              TextField(
                controller: moradiaController,
                decoration: InputDecoration(labelText: "Mora perto da vítima ?"),
              ),
              TextField(
                controller: deviaController,
                decoration: InputDecoration(labelText: "Devia para a vítima?"),
              ),
              SizedBox(height: 8),
              TextField(
                controller: trabalhouController,
                decoration: InputDecoration(labelText: "Já trabalhou com a vítima?"),
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
    );
  }
}
