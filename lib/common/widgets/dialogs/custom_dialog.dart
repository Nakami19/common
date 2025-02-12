import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../common_index.dart';

//Dialogo custom
//Requiere un titulo para mostrar
//content: Widgets que representan el contenido del dialog
//Por default se muestran los botones de Confirmar y Cancelar con su respectivo texto
//Un provider para los botones
//Requiere la funcion a ejecutar si se presionar Confirmar 
customDialog(BuildContext context,
      {required String title,
      Widget? content,
      bool? showButtons = true,
      bool? showOnlyConfirmButton = false,
      String? confirmButtonText = 'CONFIRMAR',
      String? cancelButtonText = 'CANCELAR',
      GeneralProvider? provider,
      VoidCallback? actionSuccess,
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
                      onTap: actionSuccess??(){},
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
                              buttonType: ButtonType.text,
                              width: 90,
                              height: 50,
                              paddingH: 0,
                              styleText: textStyle.bodySmall!.copyWith(
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
                              width: 90,
                              paddingH: 0,
                              height: 50,
                              onTap: actionSuccess??(){},
                              styleText: textStyle.bodySmall!.copyWith(
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