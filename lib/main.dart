import 'package:calculator/helper/color.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(MaterialApp(
    home: calculatorApp(),
  ));
}

class calculatorApp extends StatefulWidget {
  const calculatorApp({super.key});

  @override
  State<calculatorApp> createState() => _calculatorAppState();
}

class _calculatorAppState extends State<calculatorApp> {
  double firstNum = 0.0;
  double secondNum = 0.0;
  var input = '';
  var output = '';
  var operation = '';
  var hideInput = false;
  var outputSize = 35.0;
  onButtonClick(value) {
    if (value == "AC") {
      input = '';
      output = '';
    } else if (value == "⇚") {
      if (input.isNotEmpty) {
        input = input.substring(0, input.length - 1);
      }
    } else if (value == "=") {
      if (input.isNotEmpty) {
        var userInput = input;
        userInput = input.replaceAll("x", "*");
        Parser p = Parser();
        Expression expression = p.parse(userInput);
        ContextModel cm = ContextModel();
        var finalValue = expression.evaluate(EvaluationType.REAL, cm);
        output = finalValue.toString();
        if (output.endsWith(".0")) {
          output = output.substring(0, output.length - 2);
        }
        input = output;
        hideInput = true;
        outputSize = 45;
      }
    } else {
      input = input + value;
      hideInput = false;
      outputSize = 35;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        child: Column(
          children: [
            Expanded(
                child: Container(
              width: double.infinity,
              padding: EdgeInsets.all(10),
              color: Colors.black,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    hideInput ? '' : input,
                    style: TextStyle(fontSize: 35, color: Colors.white),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    output,
                    style: TextStyle(
                        fontSize: outputSize,
                        color: Colors.white.withOpacity(0.6)),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            )),
            Container(
              margin: EdgeInsets.only(top: 20),
              child: Row(
                children: [
                  button(
                      text: "AC",
                      textColor: Color.fromARGB(
                          255, 223, 113, 10) //buttonbgColor: Colors.black
                      ),
                  button(
                      text: "⇚",
                      textColor: Color.fromARGB(255, 241, 119, 4),
                      textWeight: FontWeight.w900),
                  button(text: " ", buttonbgColor: Colors.transparent),
                  button(
                      text: "/", textColor: Color.fromARGB(255, 223, 113, 10))
                ],
              ),
            ),
            Row(
              children: [
                button(
                  text: "7",
                ),
                button(
                  text: "8",
                ),
                button(
                  text: "9",
                ),
                button(
                  text: "x",
                  textColor: Color.fromARGB(255, 223, 113, 10),
                )
              ],
            ),
            Row(
              children: [
                button(
                  text: "4",
                ),
                button(
                  text: "5",
                ),
                button(
                  text: "6",
                ),
                button(
                  text: "-",
                  textColor: Color.fromARGB(255, 223, 113, 10),
                )
              ],
            ),
            Row(
              children: [
                button(
                  text: "1",
                ),
                button(
                  text: "2",
                ),
                button(
                  text: "3",
                ),
                button(
                  text: "+",
                  textColor: Color.fromARGB(255, 223, 113, 10),
                )
              ],
            ),
            Container(
              margin: EdgeInsets.only(bottom: 20),
              child: Row(
                children: [
                  button(
                    text: "%",
                  ),
                  button(
                    text: "0",
                  ),
                  button(
                    text: ".",
                  ),
                  button(
                      text: "=",
                      buttonbgColor: Colors.amber,
                      textColor: Colors.black)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget button(
      {text,
      textColor = Colors.white,
      buttonbgColor = buttonColor,
      textWeight = FontWeight.w500}) {
    return Expanded(
        child: Container(
      margin: EdgeInsets.all(8),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              padding: EdgeInsets.all(22),
              backgroundColor: buttonbgColor),
          onPressed: () => onButtonClick(text),
          child: Text(
            text,
            style: TextStyle(
                fontSize: 18, color: textColor, fontWeight: textWeight),
          )),
    ));
  }
}
