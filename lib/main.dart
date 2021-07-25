import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:simple_calculator/animation/fade_animation.dart';
import 'package:simple_calculator/widgets/button.dart';
import 'package:simple_calculator/constants/keyset.dart' as key_set;

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Calculator',
      themeMode: ThemeMode.light,
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _expression = '';
  var _display = '0';
  var _calculated = false;
  FToast? fToast;

  @override
  void initState() {
    super.initState();
  }

  void onTap(String text) {
    setState(() {
      if (_calculated && !key_set.getKey(text).isFunction) {
        allClear(text);
        _calculated = false;
        _display = text;
        return;
      }
      _calculated = false;

      if ((_display == "0" || _display == "00") && text != ".") {
        if (key_set.getKey(text).isFunction) {
          allClear(text);
          return;
        }
        _display = text;
        return;
      }

      if (key_set.getKey(_display.characters.last).isFunction &&
          key_set.getKey(text).isFunction) {
        final length = _display.characters.length;
        _display = _display.substring(0, length - 1);
        onTap(text);
        return;
      }

      if (_display.length == 13 && !key_set.getKey(text).isFunction) return;

      if (_display.length != 15) {
        _display += text;
      }
    });
  }

  void allClear(String text) {
    setState(() {
      _display = '0';
      _expression = '';
      _calculated = false;
    });
  }

  void clear(String text) {
    setState(() {
      _display = '0';
      _calculated = false;
    });
  }

  void pop(String text) {
    setState(() {
      final length = _display.characters.length;
      final _tempStr = _display.substring(0, length - 1);
      if (_tempStr.isEmpty) {
        _display = '0';
      } else {
        _display = _tempStr;
      }
    });
  }

  void calculate(String text) {
    if (_display == "0" || _display == "00" && text != ".") {
      return;
    }

    if (key_set.getKey(_display.characters.last).isFunction) {
      showSnackBar(context, "Complete the expression");
      return;
    }

    final parser = Parser();
    final parsedExpression = parser.parse(_display);
    final constextModel = ContextModel();

    setState(() {
      _expression = _display;
      _display = parsedExpression
          .evaluate(EvaluationType.REAL, constextModel)
          .toString();
      _calculated = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.only(top: 20),
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomRight,
                      colors: <Color>[Colors.lightBlue, Colors.blueAccent],
                    ),
                  ),
                  child: Column(
                    children: [
                      FadeAnimation(
                          1,
                          Center(
                            child: Text(
                              "CalCi",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: size.height / 35,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.5,
                              ),
                            ),
                          )),
                      const Expanded(child: SizedBox()),
                      FadeAnimation(
                        1,
                        Align(
                          alignment: Alignment.bottomRight,
                          child: ConstrainedBox(
                            constraints:
                                BoxConstraints(minHeight: size.height / 8),
                            child: Container(
                              padding:
                                  const EdgeInsets.only(right: 20, left: 20),
                              alignment: Alignment.bottomRight,
                              child: Text(
                                _expression,
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: size.height / 18,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.5,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      FadeAnimation(
                        1,
                        Align(
                          alignment: Alignment.bottomRight,
                          child: ConstrainedBox(
                            constraints:
                                BoxConstraints(minHeight: size.height / 10),
                            child: Container(
                              padding:
                                  const EdgeInsets.only(right: 20, left: 20),
                              alignment: Alignment.bottomRight,
                              child: Text(
                                _display,
                                textDirection: TextDirection.ltr,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: size.height / 11,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.5,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      )
                    ],
                  ),
                ),
              ),
              Row(
                children: [
                  KeyButton(symbol: key_set.KeySet.allClear, onTap: allClear),
                  KeyButton(symbol: key_set.KeySet.percent, onTap: onTap),
                  KeyButton(symbol: key_set.KeySet.divide, onTap: onTap),
                  KeyButton(symbol: key_set.KeySet.backSpace, onTap: pop),
                ],
              ),
              Row(
                children: [
                  KeyButton(symbol: key_set.KeySet.nine, onTap: onTap),
                  KeyButton(symbol: key_set.KeySet.eight, onTap: onTap),
                  KeyButton(symbol: key_set.KeySet.seven, onTap: onTap),
                  KeyButton(symbol: key_set.KeySet.multiply, onTap: onTap),
                ],
              ),
              Row(
                children: [
                  KeyButton(symbol: key_set.KeySet.six, onTap: onTap),
                  KeyButton(symbol: key_set.KeySet.five, onTap: onTap),
                  KeyButton(symbol: key_set.KeySet.four, onTap: onTap),
                  KeyButton(symbol: key_set.KeySet.add, onTap: onTap),
                ],
              ),
              Row(
                children: [
                  KeyButton(symbol: key_set.KeySet.three, onTap: onTap),
                  KeyButton(symbol: key_set.KeySet.two, onTap: onTap),
                  KeyButton(symbol: key_set.KeySet.one, onTap: onTap),
                  KeyButton(symbol: key_set.KeySet.minus, onTap: onTap),
                ],
              ),
              Row(
                children: [
                  KeyButton(symbol: key_set.KeySet.dot, onTap: onTap),
                  KeyButton(symbol: key_set.KeySet.zero, onTap: onTap),
                  KeyButton(symbol: key_set.KeySet.doubleZero, onTap: onTap),
                  KeyButton(symbol: key_set.KeySet.equals, onTap: calculate),
                ],
              )
            ],
          ),
        ));
  }
}

void showSnackBar(BuildContext context, String message) {
  final snackBar = SnackBar(
    content: Text(message),
    duration: const Duration(milliseconds: 800),
    action: SnackBarAction(
      label: 'OK',
      textColor: Colors.lightBlue,
      onPressed: () {},
    ),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
