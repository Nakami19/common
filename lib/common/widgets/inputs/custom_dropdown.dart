import '/common/assets/theme/app_colors.dart';
import '/common/assets/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class CustomDropdown<T> extends StatefulWidget {
  const CustomDropdown(
      {required this.options,
      required this.onChanged,
      this.autoSelectFirst = false,
      this.showError,
      this.errorText,
      this.title,
      this.titleTextStyle,
      this.hintText,
      this.hintTextStyle,
      required this.itemValueMapper,
      required this.itemLabelMapper,
      this.selectedValue,
      this.optionsTextsStyle,
      this.titleAlignment,
      this.height,
      this.label,
      this.menuMaxheight,
      this.returnLabelAsValue = false,
      super.key});

  final ValueChanged<String?> onChanged;
  final List<T> options;
  final String? errorText;
  final bool? showError;
  final String? label;
  final String? title;
  final String? hintText;
  final String? selectedValue;
  final bool autoSelectFirst;
  final TextStyle? optionsTextsStyle;
  final TextStyle? hintTextStyle;
  final TextStyle? titleTextStyle;
  final AlignmentGeometry? titleAlignment;
  final double? menuMaxheight;
  final double? height;
  final bool returnLabelAsValue;


  //Funciones que toman un objeto option y devuelve un String, permiten que el widget sea reutilizable
  final String Function(dynamic option) itemValueMapper;
  final String Function(dynamic option) itemLabelMapper;

  @override
  State<CustomDropdown> createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  // Variable para almacenar el valor seleccionado actualmente.
  String? value;
  String? errorText;

  @override
  void initState() {
    super.initState();

    if (widget.selectedValue != null) {
      value = widget.selectedValue; // Si se pasa un valor seleccionado
    } else if (widget.autoSelectFirst && widget.options.isNotEmpty) {
      value = widget.itemValueMapper(widget
          .options.first); // Selecciona la primera opción automáticamente.
    } else {
      value = null; // No seleccionar nada (placeholder activo)
    }

    errorText = widget.errorText;
  }

@override
void didUpdateWidget(covariant CustomDropdown oldWidget) {
  super.didUpdateWidget(oldWidget);

  // Si el error cambia, se actualiza el estado del widget
  if (widget.errorText != oldWidget.errorText) {
    setState(() {
      errorText = widget.errorText; // Actualizamos el error solo cuando cambia
    });
  }

  // Si el valor seleccionado ha cambiado, actualiza el estado.
  if (widget.selectedValue != oldWidget.selectedValue &&
      widget.selectedValue != value) {
    setState(() {
      value = widget.selectedValue;
    });
  }
}

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;

    return Column(
      children: [
        //Si hay un titulo se muestra sobre el dropdown
        if (widget.title != null)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Align(
              alignment: widget.titleAlignment ?? Alignment.centerLeft,
              child: Text(
                widget.title ?? "",
                style: GoogleFonts.lato(
                  fontSize: 14,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

        const SizedBox(height: 2),

        //Contenerdor del dropdown
        Container(
          //Color y radio del borde
          height: widget.height,
          decoration: BoxDecoration(
            border: Border.all(color: primaryColor, width: 2),
            borderRadius: BorderRadius.circular(borderRadiusValue),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: DropdownButtonHideUnderline(
              child: DropdownButton2(
                isExpanded: true, //se ocupa todo el ancho
                hint: Text(
                  widget.hintText ?? "",
                  style: widget.hintTextStyle ??
                      textStyle.bodyLarge!.copyWith(color: hintTextColor),
                ),

                value: value, //valor seleccionado

                //opciones del dropdown
                items: widget.options.map((option) {
                  return DropdownMenuItem<String>(
                      value:
                          widget.itemValueMapper(option), //valor del elemento
                      child: Text(
                        widget.itemLabelMapper(option), //texto que se muestra

                        // Aplica estilo adicional si es el elemento seleccionado.
                        style: widget.optionsTextsStyle != null
                            ? widget.optionsTextsStyle!.copyWith(
                                fontWeight:
                                    value == widget.itemValueMapper(option)
                                        ? FontWeight.w600
                                        : FontWeight.normal,
                              )
                            : TextStyle(
                                fontWeight:
                                    value == widget.itemValueMapper(option)
                                        ? FontWeight.w600
                                        : FontWeight.normal,
                              ),
                      ));
                }).toList(),

                onChanged: (String? newValue) {
                  if (newValue != null && newValue != value) {
                    setState(() {
                      value = newValue;
                    });
                    // Aquí se envía el label o el value según la opción elegida
                    String? selectedOptionLabel = widget.options
                        .where((option) =>
                            widget.itemValueMapper(option) == newValue)
                        .map((option) => widget.itemLabelMapper(option))
                        .firstOrNull;

                    widget.onChanged(widget.returnLabelAsValue
                        ? selectedOptionLabel
                        : newValue);
                  }
                },

                //Configuracion del dropdown al abrise
                dropdownStyleData: DropdownStyleData(
                    maxHeight: widget.menuMaxheight ??
                        MediaQuery.of(context).size.height / 3,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.circular(borderRadiusValue))),
              ),
            ),
          ),
        ),
        //Texto de error abajo del dropdown
        if (errorText != null && errorText!.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 5, left: 10),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                errorText!,
                style: textStyle.bodySmall!.copyWith(
                  color: Colors.red,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
