import '/common/assets/theme/app_colors.dart';
import '/common/providers/providers_index.dart';
import '/common/widgets/widget_index.dart';
import 'package:flutter/material.dart';

import '../../assets/theme/app_theme.dart';

class CustomButton extends StatelessWidget {
  final String title; // Texto del botón.
  final Function onTap; // Acción a ejecutar al presionar el botón.
  final GeneralProvider provider; 
  final bool isPrimaryColor; // Define si el botón usa el color primario.
  final bool isOutline; // Indica si el botón es un OutlineButton.
  final bool isText; // Indica si el botón es un TextButton.
  final double? paddingH; // Espaciado horizontal del botón.
  final double? paddingV; // Espaciado vertical del botón.
  final double? height; // Altura del botón.
  final double? width; // Ancho del botón.
  final double borderRadius = borderRadiusValue; // Radio de los bordes.

  //Estilos opcionales para los botones
  final ButtonStyle? styleTextButton;
  final ButtonStyle? styleOutlineButton;
  final ButtonStyle? styleFilledButton;
  final TextStyle? styleText;
  final Color? colorFilledButton;
  final Color? colorOutlineButton;
  final IconData? icon; // Icono opcional para mostrar en el botón.
  final Color? iconColor; // Color del icono.

  const CustomButton({
    super.key,
    required this.title,
    required this.isPrimaryColor,
    required this.isOutline,
    required this.onTap,
    required this.provider,
    this.paddingH,
    this.paddingV,
    this.height,
    this.width,
    this.isText = false,
    this.styleTextButton,
    this.styleText,
    this.colorFilledButton,
    this.icon,
    this.iconColor,
    this.colorOutlineButton,
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
        child: isText
            ? TextButton(
                style: styleTextButton ?? styleTextButton,
                onPressed: !provider.isLoading ? () => onTap() : null,
                child: Text(
                  title,
                  style: styleText ?? styleText,
                ),
              )
            : isOutline
                ? OutlinedButton(
                    style: styleOutlineButton ?? OutlinedButton.styleFrom(
                      
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(borderRadius),
                      ),
                      side: BorderSide(
                        color:  isPrimaryColor
                          ? primaryColor
                          : (colorOutlineButton ?? secondaryColor),
                      ),
                      foregroundColor:
                           isPrimaryColor
                          ? primaryColor
                          : (colorOutlineButton ?? secondaryColor),
                    ),
                    onPressed: !provider.isLoading ? () => onTap() : null,
                    child: LoadingButtonText(
                      text: title,
                      provider: provider,
                      styleText: styleText,
                      icon: icon,
                      iconColor: iconColor,
                    ),
                  )
                : FilledButton(
                    style: styleFilledButton?? FilledButton.styleFrom(
                      backgroundColor: isPrimaryColor
                          ? primaryColor
                          : (colorFilledButton ?? secondaryColor),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(borderRadius),
                      ),
                    ),
                    onPressed: !provider.isLoading ? () => onTap() : null,
                    child: LoadingButtonText(
                      text: title,
                      provider: provider,
                      styleText: styleText,
                      icon: icon,
                      iconColor: iconColor,
                    ),
                  ),
      ),
    );
  }
}
