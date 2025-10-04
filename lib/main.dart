import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      home: ComparadorLiquidos(),
      debugShowCheckedModeBanner: false,
    ),
  );
}

class ComparadorLiquidos extends StatefulWidget {
  const ComparadorLiquidos({super.key});

  @override
  State<ComparadorLiquidos> createState() => _ComparadorLiquidosState();
}

class _ComparadorLiquidosState extends State<ComparadorLiquidos> {
  final mlController = TextEditingController();
  final preco1Controller = TextEditingController();
  final litrosController = TextEditingController();
  final preco2Controller = TextEditingController();

  String resultado = '';

  void comparar() {
    final ml = double.tryParse(mlController.text.replaceAll(',', '.')) ?? 0;
    final preco1 =
        double.tryParse(preco1Controller.text.replaceAll(',', '.')) ?? 0;
    final litros =
        double.tryParse(litrosController.text.replaceAll(',', '.')) ?? 0;
    final preco2 =
        double.tryParse(preco2Controller.text.replaceAll(',', '.')) ?? 0;

    if (ml <= 0 || preco1 <= 0 || litros <= 0 || preco2 <= 0) {
      setState(() => resultado = 'Preencha todos os campos corretamente.');
      return;
    }

    final litros1 = ml / 1000;
    final precoPorLitro1 = preco1 / litros1;
    final precoPorLitro2 = preco2 / litros;

    if (precoPorLitro1 < precoPorLitro2) {

      final compensa = ((precoPorLitro1 - precoPorLitro2) / precoPorLitro2 * 100);

      resultado = 'O primeiro líquido vale mais a pena. e' + compensa.toStringAsFixed(0) + '%';
    } else if (precoPorLitro2 < precoPorLitro1) { 

      final compensa2 = ((precoPorLitro1 - precoPorLitro2) / precoPorLitro1 * 100);

      resultado = 'O primeiro líquido vale mais a pena. e ' + compensa2.toStringAsFixed(0) + '% mais barato';
    } else {
      resultado = 'Os dois custam o mesmo por litro.';
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Comparador de Líquidos'),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: mlController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Primeiro líquido (ml)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: preco1Controller,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Preço do primeiro (R\$)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: litrosController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Segundo líquido (litros)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: preco2Controller,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Preço do segundo (R\$)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: comparar,
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
                backgroundColor: Colors.blue,
              ),
              child: const Text('Calcular', style: TextStyle(fontSize: 18)),
            ),
            const SizedBox(height: 20),
            Text(
              resultado,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
