import 'package:common/flavors.dart';
import 'package:flutter/material.dart';

import 'common/common_index.dart';

final navigatorKey = GlobalKey<NavigatorState>();

//Configurar las peticiones
final dio = createDio(
    baseUrl: FlavorConfig.flavorValues.baseUrl,
    httpInterceptor: HttpInterceptor(
      cacheOptions: cacheOptions,
      cacheInterceptor: cacheInterceptor,
      //Funcion que se ejecuta al tener que cerrar la sesion por errores/problemas en las peticiones
      onSessionExpired: () async {
        print("Sesión expirada. Redirigiendo...");
      },

    ) 
);