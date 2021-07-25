import 'package:flutter/material.dart';

enum KeySet {
  allClear,
  backSpace,
  percent,
  divide,
  nine,
  eight,
  seven,
  multiply,
  six,
  five,
  four,
  add,
  three,
  two,
  one,
  minus,
  dot,
  zero,
  doubleZero,
  equals
}

KeySet getKey(String value) {
  switch (value) {
    case "0":
      return KeySet.zero;
    case "00":
      return KeySet.doubleZero;
    case "1":
      return KeySet.one;
    case "2":
      return KeySet.two;
    case "3":
      return KeySet.three;
    case "4":
      return KeySet.four;
    case "5":
      return KeySet.five;
    case "6":
      return KeySet.six;
    case "7":
      return KeySet.seven;
    case "8":
      return KeySet.eight;
    case "9":
      return KeySet.nine;
    case "+":
      return KeySet.add;
    case "-":
      return KeySet.minus;
    case "*":
      return KeySet.multiply;
    case "/":
      return KeySet.divide;
    case "<":
      return KeySet.backSpace;
    case "=":
      return KeySet.equals;
    case "%":
      return KeySet.percent;
    case "AC":
      return KeySet.allClear;
    case ".":
      return KeySet.dot;
    default:
      throw Error();
  }
}

extension KeySetExtension on KeySet {
  String get value {
    switch (this) {
      case KeySet.zero:
        return "0";
      case KeySet.doubleZero:
        return "00";
      case KeySet.one:
        return "1";
      case KeySet.two:
        return "2";
      case KeySet.three:
        return "3";
      case KeySet.four:
        return "4";
      case KeySet.five:
        return "5";
      case KeySet.six:
        return "6";
      case KeySet.seven:
        return "7";
      case KeySet.eight:
        return "8";
      case KeySet.nine:
        return "9";
      case KeySet.add:
        return "+";
      case KeySet.minus:
        return "-";
      case KeySet.multiply:
        return "*";
      case KeySet.divide:
        return "/";
      case KeySet.backSpace:
        return "<";
      case KeySet.equals:
        return "=";
      case KeySet.percent:
        return "%";
      case KeySet.allClear:
        return "AC";
      case KeySet.dot:
        return ".";
    }
  }

  Color get color {
    switch (this) {
      case KeySet.allClear:
        return Colors.orange;
      case KeySet.add:
      case KeySet.minus:
      case KeySet.multiply:
      case KeySet.divide:
      case KeySet.percent:
        return Colors.lightBlue;
      case KeySet.backSpace:
        return Colors.brown;
      case KeySet.equals:
        return Colors.white;
      default:
        return Colors.black;
    }
  }

  Color get bgColor {
    switch (this) {
      case KeySet.equals:
        return Colors.lightBlue;
      default:
        return Colors.transparent;
    }
  }

  bool get isFunction {
    switch (this) {
      case KeySet.add:
      case KeySet.minus:
      case KeySet.multiply:
      case KeySet.divide:
      case KeySet.percent:
      case KeySet.equals:
        return true;
      default:
        return false;
    }
  }
}
