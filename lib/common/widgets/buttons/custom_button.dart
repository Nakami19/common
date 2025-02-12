import '/common/assets/theme/app_colors.dart';
import '/common/providers/providers_index.dart';
import '/common/widgets/widget_index.dart';
import 'package:flutter/material.dart';

import '../../assets/theme/app_theme.dart';

class CustomButton extends StatelessWidget {
  final String title; // Texto del botón.
  final Function onTap; // Acción a ejecutar al presionar el botón.
  final GeneralProvider provider;
  final ButtonType buttonType; //Define el tipo de boton a mostrar, por default es filled
  final double? paddingH; // Espaciado horizontal del botón.
  final double? paddingV; // Espaciado vertical del botón.
  final double? height; // Altura del botón.
  final double? width; // Ancho del botón.
  final double borderRadius = borderRadiusValue; // Radio de los bordes.
  final bool isPrimaryColor; // Define si el botón usa el color primario, por default lo usa

  //Estilos opcionales para los botones
  final ButtonStyle? styleTextButton;
  final ButtonStyle? styleOutlineButton;
  final ButtonStyle? styleFilledButton;
  final TextStyle? styleText;
  final Icon? leftIcon; // Icono opcional para mostrar en el botón en el lado izquierdo
  final Icon? rightIcon; // Icono opcional para mostrar en el botón en el lado derecho

  const CustomButton({
    super.key,
    required this.title,
    required this.onTap,
    required this.provider,
    this.isPrimaryColor = true,
    this.paddingH,
    this.paddingV,
    this.height,
    this.width,
    this.buttonType = ButtonType.filled,
    this.styleTextButton,
    this.styleText,
    this.leftIcon,
    this.rightIcon,
    this.styleOutlineButton,
    this.styleFilledButton,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: paddingH ?? 5,
        vertical: paddingV ?? 5,
      ),
      child: SizedBox(
        width: width ?? double.infinity,
        height: height ?? 55,

        //Se verifica si el boton debe ser outline o text, por default sera filled
        child: buttonType == ButtonType.text
            ? TextButton(
                style: styleTextButton ?? styleTextButton,
                onPressed: !provider.isLoading ? () => onTap() : null,
                child: Text(
                  title,
                  style: styleText ?? styleText,
                ),
              )
            : buttonType == ButtonType.outline
                ? OutlinedButton(
                    style: styleOutlineButton ??
                        OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(borderRadius),
                          ),
                          side: BorderSide(
                            color:
                                isPrimaryColor ? primaryColor : secondaryColor,
                          ),
                          foregroundColor:
                              isPrimaryColor ? primaryColor : secondaryColor,
                        ),
                    onPressed: !provider.isLoading ? () => onTap() : null,
                    child: LoadingButtonText(
                      text: title,
                      provider: provider,
                      styleText: styleText,
                      leftIcon: leftIcon,
                      rightIcon: rightIcon,
                    ),
                  )
                : FilledButton(
                    style: styleFilledButton ??
                        FilledButton.styleFrom(
                          backgroundColor:
                              isPrimaryColor ? primaryColor : secondaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(borderRadius),
                          ),
                        ),
                    onPressed: !provider.isLoading ? () => onTap() : null,
                    child: LoadingButtonText(
                      text: title,
                      provider: provider,
                      styleText: styleText,
                      leftIcon: leftIcon,
                      rightIcon: rightIcon,
                    ),
                  ),
      ),
    );
  }
}

enum ButtonType {
  outline,
  text,
  filled,
}
