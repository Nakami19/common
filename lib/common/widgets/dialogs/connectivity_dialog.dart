import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../common_index.dart';

/// Dialogo que se muestra si no hay conexión a internet agregada
connectivityDialog(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();

    return AlertDialog(
      backgroundColor:
          themeProvider.isDarkModeEnabled ? darkColor : primaryScaffoldColor,
      title: const Text(
        'No hay conexión a internet',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      content:const Text('Intenta conectarte a una red wifi o móvil'),
    );
  }