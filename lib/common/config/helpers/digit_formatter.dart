import 'dart:ui';

import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:money_formatter/money_formatter.dart';


class DigitFormatter {
  static CurrencyTextInputFormatter inputMoneyFormatter =
      CurrencyTextInputFormatter.currency(
    locale: 'es',
    decimalDigits: 2,
    symbol: '',
    enableNegative: false,
  );

  /// Formato texto para moneda (USD, BS)
  static String getMoneyFormatter(
    String mount, {
    thousandSeparator = '.',
    decimalSeparator = ',',
    int decimalCurrency = 2,
    bool showBsCurrency = false,
  }) {
    return showBsCurrency
        ? MoneyFormatter(
            amount: double.parse(mount.replaceAll(RegExp(','), '.')),
            settings: MoneyFormatterSettings(
              thousandSeparator: thousandSeparator,
              decimalSeparator: decimalSeparator,
              fractionDigits: decimalCurrency,
              symbol: showBsCurrency ? 'BS' : null,
            ),
          ).output.symbolOnRight
        : MoneyFormatter(
            amount: double.parse(mount),
            settings: MoneyFormatterSettings(
              thousandSeparator: thousandSeparator,
              decimalSeparator: decimalSeparator,
              fractionDigits: decimalCurrency,
            ),
          ).output.nonSymbol;
  }

  // Quita el formato de valor monetario y lo convierte a un valor numérico.
  static String? getUnformattedValue(String value,
      {bool? showBsCurrency = false}) {
    if (value.isEmpty) {
      return null;
    } else {
      final mount =
          double.tryParse(value.replaceAll('.', '').replaceAll(',', '.'))
              .toString();

      return showBsCurrency != null && showBsCurrency ? '$mount BS' : mount;
    }
  }

  /// Enmascarar número de cuenta bancaria
  static String maskNumberAccount(String accountNumber) {
    return accountNumber.replaceRange(
      4,
      accountNumber.length - 4,
      'XXXXXXXXXXXX',
    );
  }

  // Enmascarar balance bancario con un Blur
  static Widget maskBalanceAccount(
      String accountBalance, String? nameCurrency) {
    return ImageFiltered(
      imageFilter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
      child: Text('$accountBalance  $nameCurrency',
          style: const TextStyle(fontSize: 12)),
    );
  }

  // Formatea un número de cuenta bancaria insertando guiones cada 4 caracteres.
  static String formattAccountNumber(String accountNumber) {
    String stringWithDashes = accountNumber.replaceAllMapped(
        RegExp(r".{4}"), (match) => "${match.group(0)}-");

    stringWithDashes =
        stringWithDashes.substring(0, stringWithDashes.length - 1);

    return stringWithDashes;
  }
}