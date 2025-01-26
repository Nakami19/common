import '/common/assets/theme/app_colors.dart';
import '/common/config/config_index.dart';
import '/common/providers/theme_provider.dart';
import '/common/widgets/widget_index.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//input para seleccionar fecha de un calendario
class DateInput extends StatelessWidget {
  final TextEditingController controller;
  final bool rangeDate;
  final String? label;
  final String? hintText;
  final Function()? onDateChanged;

  const DateInput(
      {super.key,
      required this.controller,
      required this.rangeDate,
      this.label,
      this.onDateChanged,
      this.hintText});

  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
      controller: controller,
      inputType: TextInputType.none,
      isPaddingZero: true,
      label: label,
      enabled: true,
      hintText: hintText,
      readOnly: true,
      showCursor: false,
      suffixIcon: const Icon(
        Icons.calendar_month_rounded,
        size: 20,
      ),
      onIconButton: () {
        showCalendars(context);
      },
      onTap: () => {
        showCalendars(context)
      },
    );
  }

  showCalendars(BuildContext context) {
    final themeProvider = context.read<ThemeProvider>();
    //Si no se necesita escoger un rango de fechas
    if (!rangeDate) {
      showDatePicker(
          context: context,
          locale: const Locale('es'),
          initialDate: DateTime.now(),
          firstDate: DateTime(2000), // el calendario empieza en enero del 2000
          lastDate: DateTime.now(),
          cancelText: 'CANCELAR',
          builder: (context, child) {
            return Theme(
              data: Theme.of(context).copyWith(
                colorScheme: themeProvider.isDarkModeEnabled
                    ? const ColorScheme.dark(
                        primary: primaryColor,
                        onPrimary: darkColor,
                      )
                    : const ColorScheme.light(
                        primary: primaryColor,
                      ),
              ),
              child: child!,
            );
          }).then(
        (value) {
          if (value != null) {
            String formattedDate = DateFormatter.formatDatePicker(
              value,
              'dd/MM/yyyy',
            );

            controller.text = formattedDate;
          }
        },
      );
    }

    //Si el calendario es de tipo de rango de fecha
    else {
      showDateRangePicker(
        context: context,
        locale: const Locale('es'),
        firstDate: DateTime(2000), // el calendario empieza en enero del 2000
        lastDate: DateTime.now(),
        cancelText: 'CANCELAR',
        confirmText: 'SELECCIONAR',
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: themeProvider.isDarkModeEnabled
                  ? const ColorScheme.dark(
                      primary: primaryColor,
                      onPrimary: darkColor,
                    )
                  : const ColorScheme.light(
                      primary: primaryColor,
                    ),
            ),
            child: child!,
          );
        },
      ).then((value) {
        if (value != null) {
          // Formatear las fechas seleccionadas
          String formattedStartDate = DateFormatter.formatDatePicker(
            value.start,
            'yyyy/MM/dd',
          );
          String formattedEndDate = DateFormatter.formatDatePicker(
            value.end,
            'yyyy/MM/dd',
          );

          controller.text = "$formattedStartDate - $formattedEndDate";

          if (onDateChanged != null) {
            onDateChanged!();
          }
        }
      });
    }
  }
}
