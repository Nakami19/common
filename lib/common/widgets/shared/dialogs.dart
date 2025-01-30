import '/common/assets/theme/app_colors.dart';
import '/common/assets/theme/app_theme.dart';
import '/common/widgets/widget_index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../providers/providers_index.dart';

class Dialogs {
  

  //Dialogo custom
  static customDialog(BuildContext context,
      {required String title,
      Widget? content,
      bool? showButtons = true,
      bool? showOnlyConfirmButton = false,
      String? confirmButtonText = 'CONFIRMAR',
      String? cancelButtonText = 'CANCELAR',
      GeneralProvider? provider,
      required VoidCallback actionSuccess,
      VoidCallback? closeAction}) {
    final themeProvider = context.watch<ThemeProvider>();
    final textStyle = Theme.of(context).textTheme;
    return AlertDialog(
      backgroundColor:
          themeProvider.isDarkModeEnabled ? darkColor : primaryScaffoldColor,
      title: Text(
        title,
        style: textStyle.bodyLarge,
        textAlign: TextAlign.center,
      ),
      content: content,
      actionsAlignment: MainAxisAlignment.center,

      //El contenido cambia si se muestran uno o dos botones
      actions: showButtons != null && showButtons
          ? showOnlyConfirmButton != null && showOnlyConfirmButton
              ? <Widget>[
                //Caso donde se muestra un boton
                  CustomButton(
                      title: confirmButtonText ?? 'ACEPTAR',
                      isPrimaryColor: true,
                      isOutline: false,
                      onTap: actionSuccess,
                      height: 50,
                      provider:provider ?? GeneralProvider())
                ]
              : <Widget>[

                //Caso donde se muestran dos botones
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 2),

                          child: CustomButton(
                              title: cancelButtonText ?? 'CANCELAR',
                              isPrimaryColor: false,
                              isOutline: false,
                              isText: true,
                              width: 90,
                              height: 50,
                              paddingH: 0,
                              styleText: GoogleFonts.lato(
                                color: const Color.fromRGBO(252, 198, 20, 100),
                                fontSize: 10,
                                fontWeight: FontWeight.bold
                              ),
                              styleTextButton: TextButton.styleFrom(
                                side: const BorderSide(
                                  color: Color.fromRGBO(252, 198, 20,
                                      100), 
                                  width: 2,
                                ),
                              ),
                              onTap: closeAction ??
                                  () => Navigator.pop(context, false),
                              provider: GeneralProvider()),
                        ),
                      ),


                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 2),

                          child: CustomButton(
                              title: confirmButtonText ?? 'CONFIRMAR',
                              isPrimaryColor: true,
                              isOutline: false,
                              width: 90,
                              paddingH: 0,
                              height: 50,
                              onTap: actionSuccess,
                              styleText: GoogleFonts.lato(
                                color: Colors.white,
                                fontSize: 9,
                                fontWeight: FontWeight.bold
                              ),
                              provider: GeneralProvider()),
                        ),
                      ),
                    ],
                  )

                ]
          : null,
    );
  }

  /// Dialogo que se muestra si no hay conexión a internet agregada
  static connectivityDialog(BuildContext context) {
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


  //Mostrar el estado de cargando con un circulo y un indicador "Cargando" o texto personalizado
  static spinKitLoader(BuildContext context,
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

  //* Menu desplegable
  /// Función para mostrar menu desplegable
  /// - List<String> menuOptios (lista de widgets a mostrar)
  /// - String headerTitle: titulo del menú
  /// - String routeScreen: ruta
  /// - widget? contentBody: widget a mostrar
  static showMenuBottomSheet(BuildContext context,
      {List? menuOptios,
      String? headerTitle,
      Color? color,
      String? routeScreen,
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


}
