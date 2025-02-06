import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

import '../../common_index.dart';

class MultiSelectDropdown<T> extends StatefulWidget {
  const MultiSelectDropdown({
    required this.options,
    required this.onChanged,
    required this.itemValueMapper,
    required this.itemLabelMapper,
    this.selectedValues,
    this.title,
    this.hintText,
    this.height,
    this.hintTextStyle,
    super.key,
  });

  final ValueChanged<List<String>> onChanged;
  final List<T> options;
  final String? title;
  final String? hintText;
  final List<String>? selectedValues;
  final double? height;
  final TextStyle? hintTextStyle;

  final String Function(dynamic option) itemValueMapper;
  final String Function(dynamic option) itemLabelMapper;

  @override
  State<MultiSelectDropdown> createState() => _MultiSelectDropdownState();
}

class _MultiSelectDropdownState extends State<MultiSelectDropdown> {
  List<String> selectedValues = [];
  List<String> selectedValuesNames = [];

  @override
  void initState() {
    super.initState();
    selectedValues = widget.selectedValues != null ? List.from(widget.selectedValues!) : [];
  }

  @override
  void didUpdateWidget(covariant MultiSelectDropdown oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selectedValues != oldWidget.selectedValues) {
      setState(() {
        selectedValues = List.from(widget.selectedValues!);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.title != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: Text(
              widget.title!,
              style: textStyle.bodyMedium!.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
        const SizedBox(height: 2),
        Container(
          height: widget.height,
          decoration: BoxDecoration(
            border: Border.all(color: primaryColor, width: 2),
            borderRadius: BorderRadius.circular(borderRadiusValue),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: DropdownButtonHideUnderline(
              child: DropdownButton2(
                isExpanded: true,
                //Contenido del dropdown que permite mostrar los textos seleccionados
                customButton: Container(
                  width: double.infinity,
                  height: widget.height ?? 45,
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //Texto a mostrar, si no hay nada seleccionado se muestra el hintText
                      Expanded(
                        child: Text(
                          selectedValuesNames.isEmpty ? widget.hintText ?? "" : selectedValuesNames.join(", "),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: selectedValuesNames.isEmpty ? widget.hintTextStyle??textStyle.bodyLarge!.copyWith(color: hintTextColor) : textStyle.bodyLarge,
                        ),
                      ),
                      const Icon(Icons.arrow_drop_down), // Agregar la flecha manualmente
                    ],
                  ),
                ),
                onChanged: (_) {},
                //Elementos del dropdown, checkBoxs junto a texto
                items: widget.options.map((option) {
                  String optionValue = widget.itemValueMapper(option);
                  String optionLabel = widget.itemLabelMapper(option);
                  return DropdownMenuItem<String>(
                    value: optionValue,
                    enabled: false,
                    child: StatefulBuilder(
                      builder: (context, setStateDropdown) {
                        return CheckboxListTile(
                          value: selectedValues.contains(optionValue),
                          title: Text(optionLabel),
                          controlAffinity: ListTileControlAffinity.leading,
                          onChanged: (bool? isChecked) {
                            setState(() {
                              if (isChecked == true) {
                                selectedValues.add(optionValue);
                                selectedValuesNames.add(optionLabel);
                              } else {
                                selectedValues.remove(optionValue);
                                selectedValuesNames.remove(optionLabel);
                              }
                              widget.onChanged(selectedValues);
                            });
                            setStateDropdown(() {}); // Asegura que el dropdown se actualice en tiempo real
                          },
                        );
                      },
                    ),
                  );
                }).toList(),
                dropdownStyleData: DropdownStyleData(
                  maxHeight: 300,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
