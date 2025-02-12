import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

//Mostrar el estado de cargando con un circulo y un indicador "Cargando" o texto personalizado
spinKitLoader(BuildContext context,
      {bool isDismissible = false, String? loadingText}) {
    return WillPopScope(
      onWillPop: () async => isDismissible,
      child: AlertDialog(
        contentPadding: EdgeInsets.zero,
        content: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
          ),
          height: 75,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const SpinKitFadingCircle(
                color: Color(0xFF6A9CF3),
                size: 30,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                loadingText ?? 'Cargando...',
              ),
            ],
          ),
        ),
      ),
    );
  }