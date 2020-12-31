library numbet_to_word;

import 'dart:math';

class NumberToWords {
  // ignore: non_constant_identifier_names
  static String ArabicWord(
      String inputNumber, String CurrencyName, String CurrencyPartName, {String SuffixText = ""}) {
    double numberFix = roundDouble(inputNumber, 2);
    List<String> stnumber = numberFix.toString().split(".");
    int number = int.parse(stnumber[0]);

    if (number == 0) {
      return "صفر";
    }
    String fullNumber = stnumber[0];
    String fNumber = stnumber[0];
    String CurrencyPart = "";
    int _CurrencyPart = int.parse( stnumber[1]);
    if (_CurrencyPart > 0) {
      CurrencyPart = " و " +
          _convertLessThanOneThousand(_CurrencyPart) +
          " " +
          CurrencyPartName;
    }
    for (var i = 0; i < 15 - fullNumber.length; i++) {
      fNumber = "0" + fNumber;
    }
    fullNumber = fNumber;

    int trillion = int.parse(fullNumber.substring(0, 3));
    int billions = int.parse(fullNumber.substring(3, 6));
    int millions = int.parse(fullNumber.substring(6, 9));
    int hundredThousands = int.parse(fullNumber.substring(9, 12));
    int thousands = int.parse(fullNumber.substring(12, 15));

    String tradtrillion;

    switch (trillion) {
      case 0:
        tradtrillion = "";
        break;
      case 1:
        tradtrillion = " تریلیون و ";
        break;
      case 2:
        tradtrillion = " تريليونان و ";
        break;
      default:
        tradtrillion = _convertLessThanOneThousand(trillion) + " تریلیون و";
    }
    String result = tradtrillion;

    String tradBillions;

    switch (billions) {
      case 0:
        tradBillions = "";
        break;
      case 1:
        tradBillions = " مليار و ";
        break;
      case 2:
        tradBillions = " ملياران و ";
        break;
      default:
        tradBillions = _convertLessThanOneThousand(billions) + " مليار و";
    }
    result += tradBillions;

    String tradMillions;

    switch (millions) {
      case 0:
        tradMillions = "";
        break;
      case 1:
        tradMillions = "ملیون و ";
        break;
      case 2:
        tradMillions = "مليونان و ";
        break;
      default:
        tradMillions = _convertLessThanOneThousand(millions) + " مليون و";
    }
    result = result + tradMillions;

    String tradHundredThousands;
    switch (hundredThousands) {
      case 0:
        tradHundredThousands = "";
        break;
      case 1:
        tradHundredThousands = " الف و ";
        break;
      case 2:
        tradHundredThousands = " الفان و";
        break;
      default:
        tradHundredThousands =
            _convertLessThanOneThousand(hundredThousands) + " الف و ";
    }
    result = result + tradHundredThousands;

    String tradThousand;
    tradThousand = _convertLessThanOneThousand(thousands);
    result = result + tradThousand;

    if (result.trim().endsWith("و")) {
      result = result.substring(0, result.length - 2);
    }
    return result + " " + CurrencyName + CurrencyPart + " " + SuffixText;
  }

  static String _convertLessThanOneThousand(int number) {
    List<String> tensNames = [
      "",
      "عشرة و ",
      "عشرون و ",
      "ثلاثون و ",
      "اربعون و ",
      "خمسون و ",
      "ستون و ",
      "سبعون و ",
      "ثمانون و ",
      "تسعون و "
    ];

    List<String> numNames = [
      "",
      "واحد و ",
      "اثنان و ",
      "ثلاثة و ",
      "اربعة و ",
      "خمسة و ",
      "ستة و ",
      "سبعة و ",
      "ثمانية و ",
      "تسعة و ",
      "عشرة و ",
      "احدى عشر و ",
      "اثنى عشر و ",
      "ثلاثة عشر و ",
      "اربعة عشر و ",
      "خمسة عشر و ",
      "ستة عشر و ",
      "سبعة عشر و ",
      "ثمانية عشر و ",
      "تسعة عشر و "
    ];

    List<String> thousandsNames = [
      "",
      "مائة و ",
      "مئتان و ",
      "ثلاثمائة و ",
      "اربعمائة و ",
      "خمسمائة و ",
      "ستمائة و ",
      "سبعمائة و ",
      "ثمانمائة و ",
      "تسعمائة و "
    ];
    String soFar;
    int n = number % 100;
    if (n < 20) {
      soFar = numNames[n];
      number = number ~/ 100;
    } else {
      soFar = numNames[number % 10];
      number = number ~/ 10;
      soFar = soFar + tensNames[number % 10];
      number = number ~/ 10;
    }
    if (number == 0) {
      if (soFar.trim().endsWith("و")) {
        soFar = soFar.substring(0, soFar.length - 2);
      }
      return soFar;
    }
    var str = "";
    str = (thousandsNames[number] + soFar);
    if (str.trim().endsWith("و")) {
      str = str.substring(0, str.length - 2);
    }
    return str;
  }

  static double roundDouble(String number, int i) {
    double mod = pow(10.0, i);
    return ((double.parse(number) * mod).round().toDouble() / mod);
  }
}
