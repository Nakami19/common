import 'package:flutter/material.dart';
import '../common_index.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {

      // Busca en el mapa de rutas si existe un builder para la ruta solicitada
        final builder = AppRoutes.routes[settings.name];
        if (builder != null) {
          return FadePageTransition(builder: builder);
        }
        // Si la ruta no está definida, muestra vista de mantenimiento
        return FadePageTransition(
            builder: (_) => Scaffold(
              body: Center(
                child: Text('Ruta no definida para ${settings.name}'),
              ),
            )
                );
    }
  }
