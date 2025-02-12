import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../common_index.dart';

/// Función para mostrar menu desplegable
  /// - List<String> menuOptios (lista de widgets a mostrar)
  /// - String? headerTitle: titulo del menú
  /// - widget? contentBody: widget a mostrar
 showMenuBottomSheet(BuildContext context,
      {List? menuOptios,
      String? headerTitle,
      Color? color,
      IconData? iconTitle,
      bool allowClose = true,
      required Widget contentBody}) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    final textStyle = Theme.of(context).textTheme;

    showModalBottomSheet<void>(
      isDismissible: allowClose, //dice si es posible clickear afuera del menu
      
      backgroundColor:
          themeProvider.isDarkModeEnabled ? darkColor : primaryScaffoldColor,
      elevation: 10,
      shape: const RoundedRectangleBorder(
        borderRadius:
            BorderRadius.vertical(top: Radius.circular(borderRadiusValue)),
      ),
      context: context,
      isScrollControlled: true,
      builder: (BuildContext _) {
  return LayoutBuilder(
    builder: (context, constraints) {
      return SingleChildScrollView(
        child: Container(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.9, // Ajuste dinámico, en caso de que necesite moverse por aparicion de teclado
          ),
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Encabezado
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: color ?? primaryColor,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(borderRadiusValue),
                      topRight: Radius.circular(borderRadiusValue),
                    ),
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.keyboard_arrow_down_sharp,
                            color: Colors.white,
                          ),
                          if (headerTitle != null)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                if (iconTitle != null) ...[
                                  Icon(iconTitle, color: Colors.white),
                                  const SizedBox(width: 7),
                                ],
                                Text(
                                  headerTitle,
                                  style: textStyle.titleMedium!.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              // Contenido del modal
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 0),
                child: contentBody,
              ),
            ],
          ),
        ),
      );
    },
  );
},

    );
  }