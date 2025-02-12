import 'package:flutter/material.dart';

import 'common/common_index.dart';

final navigatorKey = GlobalKey<NavigatorState>();

final dio = createDio(
    baseUrl: 'https://api.example.com',
    httpInterceptor: HttpInterceptor(
      cacheOptions: cacheOptions,
      cacheInterceptor: cacheInterceptor,
      onSessionExpired: () async {
        print("Sesión expirada. Redirigiendo...");
      },

    ) 
);