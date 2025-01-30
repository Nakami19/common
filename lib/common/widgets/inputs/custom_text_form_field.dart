import '/common/assets/theme/app_colors.dart';
import 'package:flutter/material.dart';
import '../../assets/theme/app_theme.dart';

class CustomTextFormField extends StatefulWidget {
  const CustomTextFormField(
      {super.key,
      required this.controller,
      this.node,
      this.hintText,
      this.hintStyle,
      this.suffixText,
      this.suffixTextStyle,
      this.inputType,
      this.suffixIcon,
      this.preffixIcon,
      this.label,
      this.validator,
      this.errorMessage,
      this.obscureText = false,
      this.borderColor = primaryColor,
      this.maxLength,
      this.readOnly,
      this.showCursor,
      this.autofocus,
      this.enabled,
      this.paddingV = 5,
      this.paddingH = 5,
      this.isPaddingZero = false,
      this.hasShadow = true,
      this.onChanged,
      this.onTap,
      this.onValue,
      this.onIconButton});

  final TextEditingController controller;
  final FocusNode? node;
  final String? hintText;
  final TextStyle? hintStyle;
  final String? suffixText;
  final TextStyle? suffixTextStyle;
  final TextInputType? inputType;
  final Icon? suffixIcon;
  final Widget? preffixIcon;
  final String? label;
  final String? errorMessage;
  final bool obscureText;
  final int? maxLength;
  final double paddingV;
  final double paddingH;
  final bool? readOnly;
  final bool? showCursor;
  final bool? autofocus;
  final bool? enabled;
  final bool isPaddingZero;
  final bool hasShadow;
  final String? Function(String?)? validator;
  final Function(String)? onChanged;
  final ValueChanged<String>? onValue;
  final Function()? onTap;
  final Function()? onIconButton;
  final Color borderColor;

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  final form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textStyle = Theme.of(context).textTheme;

    return Padding(
      // padding: EdgeInsets.zero,
      padding: widget.isPaddingZero
          ? EdgeInsets.zero
          : EdgeInsets.symmetric(
              vertical: widget.paddingV, horizontal: widget.paddingH),
    
      child: TextFormField(
        // Configura el campo con las opciones proporcionadas.
        keyboardType: widget.inputType ?? TextInputType.text,
        autofocus: widget.autofocus ?? false,
        controller: widget.controller,
        focusNode: widget.node,
        readOnly: widget.readOnly ?? false,
        showCursor: widget.showCursor ?? true,
        obscureText: widget.obscureText,
        maxLength: widget.maxLength,
        onChanged: widget.onChanged,
        validator: widget.validator,
        
    
        //Estilo del campo
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: 23, vertical: 13),
          fillColor: Colors.white,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          counterText: '',
          prefixIcon: widget.preffixIcon,
          suffixIcon: widget.suffixIcon != null
              ? IconButton(
                  onPressed: () {
                    if (widget.onIconButton != null) {
                        widget.onIconButton!();
                      
                    }
                  },
                  style: TextButton.styleFrom(
                        elevation: 0, overlayColor: Colors.transparent),
                  icon: widget.suffixIcon!)
              : null,
          suffixText: widget.suffixText,
          suffixStyle: widget.suffixTextStyle,
          isDense: true,
    
          label: widget.label != null
              ? Text(
                  widget.label!,
                  maxLines: 1,
                )
              : null,
    
          hintText: widget.enabled == true ? widget.hintText : null,
          hintStyle: widget.hintStyle ?? textStyle.bodyLarge!.copyWith(color: hintTextColor),
    
          errorText: widget.errorMessage,
          focusColor: colors.primary,
    
          // Bordes según el estado del campo.
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadiusValue),
            borderSide:  BorderSide(
              color: widget.borderColor,
              width: 2,
            ),
          ),
    
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadiusValue),
            borderSide: const BorderSide(
              color: hintTextColor,
              width: 2,
            ),
          ),
    
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadiusValue),
            borderSide: BorderSide(
              color: widget.borderColor,
              width: 2,
            ),
          ),
    
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadiusValue),
            borderSide: const BorderSide(
              color: errorColor,
              width: 2,
            ),
          ),
    
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadiusValue),
            borderSide: const BorderSide(
              color: errorColor,
              width: 2,
            ),
          ),
        ),
    
        onTap: () {
          //Oculta el teclado en dispositivos iOS si el tipo es numérico.
          if (widget.inputType == TextInputType.number &&
              Theme.of(context).platform == TargetPlatform.iOS) {
            FocusScope.of(context).unfocus();
          }
    
          if (widget.node != null) {
            FocusScope.of(context).requestFocus(widget.node);
          }
    
          //Se ejecuta la funcion onTap si fue proporcionada
          if (widget.onTap != null) {
            widget.onTap!();
          }
        },
        onFieldSubmitted: widget.onValue,
      ),
    );
  }
}
