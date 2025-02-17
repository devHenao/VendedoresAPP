import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'lat_lng.dart';
import 'place.dart';
import 'uploaded_file.dart';
import '/backend/schema/structs/index.dart';
import '/auth/custom_auth/auth_util.dart';

bool? showSearchResult(
  String? textSearchFor,
  String? textSearchIn,
) {
  try {
    if (textSearchFor != null && textSearchIn != null) {
      return textSearchIn.toLowerCase().contains(textSearchFor.toLowerCase());
    } else {
      return false;
    }
  } catch (e) {
    return false;
  }
}

double calculateTotal(
  List<double> prices,
  List<double> quantities,
) {
  if (prices.length != quantities.length) {
    throw ArgumentError(
        'Las listas de precios y cantidades deben tener el mismo tamaño.');
  }

  /// CALCULAR EL TOTAL
  double total = 0;
  for (int i = 0; i < prices.length; i++) {
    total += prices[i] * quantities[i];
  }
  return total;
}

bool onList(
  List<String> list,
  String element,
) {
// Verifica si el elemento es nulo
  if (element == null) {
    return false; // Si es nulo, retorna false directamente
  }

  // Recorre la lista y verifica si el elemento existe
  for (var item in list) {
    if (item == element) {
      return true; // Retorna true si el elemento está en la lista
    }
  }

  return false; // Retorna false si no se encuentra
}

double acumulate(
  List<double> listValues,
  String targetCode,
  List<String> codes,
) {
  double sum = 0.0;
  for (int i = 0; i < codes.length; i++) {
    if (codes[i] == targetCode) {
      sum += listValues[i];
    }
  }
  return sum;
}
