import 'package:flutter/material.dart';

void main() {
  runApp(const CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculator',
      theme: ThemeData.dark(),
      home: const CalculatorPage(),
    );
  }
}

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({super.key});

  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  String output = "0";
  String current = "";
  double num1 = 0;
  String operand = "";

  void buttonPressed(String value) {
    setState(() {
      if (value == "C") {
        output = "0";
        current = "";
        num1 = 0;
        operand = "";
      } else if (value == "+" ||
          value == "-" ||
          value == "×" ||
          value == "÷") {
        num1 = double.parse(output);
        operand = value;
        current = "";
      } else if (value == "=") {
        double num2 = double.parse(current);

        switch (operand) {
          case "+":
            output = (num1 + num2).toString();
            break;

          case "-":
            output = (num1 - num2).toString();
            break;

          case "×":
            output = (num1 * num2).toString();
            break;

          case "÷":
            output = (num1 / num2).toString();
            break;
        }

        current = output;
      } else {
        current += value;
        output = current;
      }
    });
  }

  Widget calcButton(String text,
      {Color color = Colors.orange}) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
            padding: const EdgeInsets.all(24),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          onPressed: () => buttonPressed(text),
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget buildRow(List<String> buttons) {
    return Row(
      children: buttons.map((e) {
        Color color = Colors.grey.shade800;

        if (e == "C") {
          color = Colors.red;
        }

        if (["+", "-", "×", "÷", "="].contains(e)) {
          color = Colors.orange;
        }

        return calcButton(e, color: color);
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Calculator"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.bottomRight,
              padding: const EdgeInsets.all(24),
              child: Text(
                output,
                style: const TextStyle(
                  fontSize: 56,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          buildRow(["7", "8", "9", "÷"]),
          buildRow(["4", "5", "6", "×"]),
          buildRow(["1", "2", "3", "-"]),
          buildRow(["C", "0", "=", "+"]),
        ],
      ),
    );
  }
}