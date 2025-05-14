import 'package:calc_ativ/enum/operacao.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 97, 199, 224),
        ),
      ),
      home: const MyHomePage(title: 'CalcAtiv'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String valor = '';
  String numero = '';
  String total = '';

  // ignore: avoid_types_as_parameter_names
  void _digitar(var num) {
    setState(() {
      if (num.runtimeType == String) {
        switch (num) {
          case ".":
            if (!valor.contains('.')) {
              valor += '.';
            }
            break;
          case "back":
            if (valor.isNotEmpty) {
              valor = valor.substring(0, valor.length - 1);
            }
            break;
          case "clear":
            total = '';
            valor = '';
            break;
          case "=":
            if (valor.isNotEmpty) {
              total += ' $valor';
            }

            var item = total.split(' ');
            List<double> valores = [];
            List<String> operandos = [];

            for (int i = 0; i < item.length; i++) {
              if (i % 2 != 0) {
                valores.add(double.parse(item[i].toString()));
              } else {
                if (i != 0 && i != item.length - 1) {
                  operandos.add(item[i]);
                }
              }
            }

            valor += ' ${valores.length}, ${operandos.length}';

            do {
              for (int i = 0; i < operandos.length; i++) {
                double calculo = 0;
                if (operandos.contains('÷') ||
                    operandos.contains('x') ||
                    operandos.contains('%')) {
                  switch (operandos[i]) {
                    case "x":
                      calculo = valores[i] * valores[i + 1];
                      operandos.removeAt(i);
                      break;
                    case "÷":
                      calculo = valores[i] / valores[i + 1];
                      operandos.removeAt(i);
                      break;
                    case "%":
                      calculo = (valores[i] * valores[i + 1]) / 100;
                      operandos.removeAt(i);
                      break;
                    default:
                      break;
                  }
                } else {
                  switch (operandos[i]) {
                    case "+":
                      calculo = valores[i] + valores[i + 1];
                      operandos.removeAt(i);
                      break;
                    case "-":
                      calculo = valores[i] - valores[i + 1];
                      operandos.removeAt(i);
                      break;
                  }
                }
                valores.removeAt(i);
                valores[i] = calculo;
              }
            } while (operandos.isNotEmpty);

            var split = valores[0].toString().split('.');

            valor =
                split.length == 1
                    ? split[0]
                    : split[1] == '0'
                    ? split[0]
                    : split[1].length < 7
                    ? '${split[0]}.${split[1]}'
                    : '${split[0]}.${split[1].substring(0, 6)}';

            total = '';
            break;

          case '+/-':
            if (valor.isNotEmpty) {
              if (!valor.contains('-')) {
                valor = '-$valor';
              } else {
                valor = valor.substring(1, valor.length);
              }
            } else {
              valor = '-';
            }
            break;

          default:
            if (valor.isNotEmpty) {
              total += ' $valor $num';
              valor = '';
            } else {
              if (total.isNotEmpty) {
                if (total.substring(total.length - 1, total.length) != '') {
                  total = total.substring(0, total.length - 1) + num;
                }
              }
            }
            break;
        }
      } else {
        valor += num.toString();
      }
    });
  }

  SizedBox _criarBotao(String img, Operacao op) {
    return SizedBox(
      width: 95,
      height: 80,
      child: Padding(
        padding: EdgeInsets.all(10),
        child: IconButton(
          onPressed: () => _digitar(op.op),
          tooltip: op.nome,
          icon: Image(image: AssetImage('assets/icons/$img.png')),
        ),
      ),
    );
  }

  SizedBox _criarNum(int num) {
    return SizedBox(
      width: 95,
      height: 80,
      child: TextButton(
        onPressed: () => _digitar(num),
        child: Text(num.toString(), textScaler: TextScaler.linear(3)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              color: const Color.fromARGB(255, 107, 238, 255),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 100.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(total, textScaler: TextScaler.linear(2), maxLines: 2),
                    Padding(padding: EdgeInsets.all(10)),
                  ],
                ),
              ),
            ),

            Container(
              color: Colors.cyan,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(valor, textScaler: TextScaler.linear(3)),
                  Padding(padding: EdgeInsets.all(20)),
                ],
              ),
            ),

            SizedBox(height: 25),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _criarBotao('backspace-reverse-icon', Operacao.apagar),
                _criarBotao('trash-can-icon', Operacao.limpar),
                _criarBotao('percentage-icon', Operacao.perc),
                _criarBotao('math-division-icon', Operacao.div),
              ],
            ),

            SizedBox(height: 10),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _criarNum(7),
                _criarNum(8),
                _criarNum(9),
                _criarBotao('math-multiplication-icon', Operacao.mult),
              ],
            ),

            SizedBox(height: 10),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _criarNum(4),
                _criarNum(5),
                _criarNum(6),
                _criarBotao('math-minus-icon', Operacao.sub),
              ],
            ),

            SizedBox(height: 10),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _criarNum(1),
                _criarNum(2),
                _criarNum(3),
                _criarBotao('math-plus-icon', Operacao.add),
              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _criarBotao('mais-menos', Operacao.maismenos),
                _criarNum(0),
                _criarBotao('virgula', Operacao.virgula),
                _criarBotao('equal-sign-icon', Operacao.igual),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
