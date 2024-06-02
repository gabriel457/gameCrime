import 'package:flutter/material.dart';
import 'package:criminal/pages/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Resultado extends StatefulWidget {
  const Resultado({super.key});

  @override
  State<Resultado> createState() => _ResultadoState();
}

class _ResultadoState extends State<Resultado> {
  String classificacao = "Inocente";

  @override
  Widget build(BuildContext context) {

    int respostas = ModalRoute.of(context)?.settings.arguments as int;

    if(respostas == 2) {
      classificacao = "Suspeito";
    } else if(respostas >= 3 && respostas <= 4) {
      classificacao = "Cúmplice";
    } else if(respostas >= 5) {
      classificacao = "Assassino";
    } else if(respostas <= 1) {
      classificacao = "Inocente";
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Resultado'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              classificacao,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
                color: const Color.fromARGB(255, 243, 2, 2),
                fontSize: 32
              ),
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Voltar'),
            ),
          ],
        ),
      ),
    );
  }
}