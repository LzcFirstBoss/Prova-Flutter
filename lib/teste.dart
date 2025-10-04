import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    home: ComparadorLiquidos(),
    debugShowCheckedModeBanner: false,
  ));
}

class ComparadorLiquidos extends StatefulWidget {
  const ComparadorLiquidos({Key? key}) : super(key: key);

  @override
  State<ComparadorLiquidos> createState() => _ComparadorLiquidosState();
}

class _ComparadorLiquidosState extends State<ComparadorLiquidos> {
  final mlController = TextEditingController();
  final preco1Controller = TextEditingController();
  final litrosController = TextEditingController();
  final preco2Controller = TextEditingController();

  String resultado = '';
  double precoPorLitro1 = 0;
  double precoPorLitro2 = 0;

  void comparar() {
    final ml = double.tryParse(mlController.text.replaceAll(',', '.')) ?? 0;
    final preco1 = double.tryParse(preco1Controller.text.replaceAll(',', '.')) ?? 0;
    final litros = double.tryParse(litrosController.text.replaceAll(',', '.')) ?? 0;
    final preco2 = double.tryParse(preco2Controller.text.replaceAll(',', '.')) ?? 0;

    if (ml <= 0 || preco1 <= 0 || litros <= 0 || preco2 <= 0) {
      setState(() => resultado = 'Preencha todos os campos corretamente.');
      return;
    }

    final litros1 = ml / 1000;
    precoPorLitro1 = preco1 / litros1;
    precoPorLitro2 = preco2 / litros;

    if (precoPorLitro1 < precoPorLitro2) {
      resultado = '💧 O primeiro líquido é mais vantajoso';
    } else if (precoPorLitro2 < precoPorLitro1) {
      resultado = '🧴 O segundo líquido é mais vantajoso';
    } else {
      resultado = '⚖️ Os dois têm o mesmo custo por litro';
    }

    setState(() {});
  }

  InputDecoration estiloCampo(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: Colors.blueAccent),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.blueAccent, width: 2),
        borderRadius: BorderRadius.circular(12),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('Comparador de Líquidos'),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Text(
              'Líquido 1 (em ml)',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: mlController,
              keyboardType: TextInputType.number,
              decoration: estiloCampo('Quantidade (ml)'),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: preco1Controller,
              keyboardType: TextInputType.number,
              decoration: estiloCampo('Preço (R\$)'),
            ),
            const SizedBox(height: 20),

            const Text(
              'Líquido 2 (em litros)',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: litrosController,
              keyboardType: TextInputType.number,
              decoration: estiloCampo('Quantidade (L)'),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: preco2Controller,
              keyboardType: TextInputType.number,
              decoration: estiloCampo('Preço (R\$)'),
            ),
            const SizedBox(height: 25),

            ElevatedButton(
              onPressed: comparar,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Calcular',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
            const SizedBox(height: 25),

            if (resultado.isNotEmpty)
              Column(
                children: [
                  Text(
                    '1º: R\$ ${precoPorLitro1.toStringAsFixed(2)} / L',
                    style: const TextStyle(fontSize: 16),
                  ),
                  Text(
                    '2º: R\$ ${precoPorLitro2.toStringAsFixed(2)} / L',
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    resultado,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
