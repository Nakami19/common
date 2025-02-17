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
    onSessionExpired: () async {
      // Lógica para manejar sesión expirada
    },
    cachedServices: ["/api/products", "/api/users"], // Lista de endpoints que deseas cachear
  ),
);