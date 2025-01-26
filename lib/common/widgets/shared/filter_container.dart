import '/common/assets/theme/app_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



class Filter<T> extends StatefulWidget {
  const Filter(
      {super.key,
      required this.inputs,
      required this.onReset,
      required this.icons});

  final List<T> inputs;
  final VoidCallback onReset; // Acción al presionar icono de papelera
  final List<IconButton> icons;

  @override
  State<Filter> createState() => _FilterState();
}

class _FilterState extends State<Filter> {
  final form = GlobalKey<FormState>();
  bool _isFilterVisible = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadiusValue),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            spreadRadius: 3,
            blurRadius: 5,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          // Botón para mostrar/ocultar filtro
          Padding(
            padding: const EdgeInsets.all(5),
            child: Row(
              children: [
                //botones pasados como parametros a la izquierda
                Row(
                  children: widget.icons.map((icon) {
                    return icon;
                  }).toList(),
                ),

                Spacer(),

                //botones para limpiar filtro y mostrar/ocultar filtro a la derecha
                Row(
                  children: [
                    _isFilterVisible
                        ? IconButton(
                            onPressed: widget.onReset,
                            icon: Icon(CupertinoIcons.delete, size: 22,))
                        : Container(),
                    SizedBox(
                      width: 5,
                    ),
                    IconButton(
                      icon: Icon(
                        _isFilterVisible
                            ? Icons.expand_less
                            : Icons.expand_more,
                      ),
                      onPressed: () {
                        setState(() {
                          _isFilterVisible = !_isFilterVisible;
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Filtro con animación
          AnimatedSize(
            duration: Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            child: _isFilterVisible
                ? Form(
                    key: form,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          maxHeight: MediaQuery.of(context).size.height *
                              0.43, // Altura máxima
                        ),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ...widget.inputs.map((widget) {
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 16),
                                  child: widget,
                                );
                              }).toList(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                : const SizedBox.shrink(),
          )
        ],
      ),
    );
  }
}
