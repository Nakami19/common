import '/common/assets/theme/app_colors.dart';
import '/common/assets/theme/app_theme.dart';
import 'package:flutter/material.dart';

class InformationCard extends StatefulWidget {
  const InformationCard({
    super.key,
    this.title = "",
    required this.texts,
    this.subtitle,
    this.bottomRightWidget,
    this.isInformationinColumn = true,
    // this.nextPage,
    // this.onTapnextPage,
    // this.nextPageRoute
  });
  final String title;
  final List<Map<String, dynamic>> texts;
  final String? subtitle;
  final Widget? bottomRightWidget;
  final bool isInformationinColumn;
  // final String? nextPage; //Nombre a mostrar de la ruta
  // final String? nextPageRoute; //Una a una siguiente vista de ser necesario
  // final GestureTapCallback? onTapnextPage; //Funcion a ejecutar al presionar opcion para ir a siguiente vista

  @override
  State<InformationCard> createState() => _InformationCardState();
}

class _InformationCardState extends State<InformationCard> {
  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
    return Container(
      //Contenedor donde estara la informacion
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadiusValue),
        color: Colors.white,
        boxShadow: [
          //Sombra del contenedor
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: widget.isInformationinColumn
          ? Column(
              //Informacion
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //Titulo
                Center(
                  child: Text(widget.title,
                      style: textStyle.titleMedium!.copyWith(
                          color: primaryColor, fontWeight: FontWeight.w600)),
                ),
                const SizedBox(
                  height: 5,
                ),
                //Subtitulo
                if (widget.subtitle != null) ...[
                  Center(
                    child: Text(
                      widget.subtitle!,
                      style: textStyle.bodyMedium!.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                ],
                //Se generan los textos
                ...widget.texts.map((entry) {
                  //Parte izquierda
                  final label = entry['label'] ?? "";
                  //Parte derecha
                  final value = entry['value'] ?? "";

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //Parte izquierda
                      Text(
                        label,
                        style: textStyle.bodyMedium!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                          height: 4), // Espaciado entre label y value
                      //Parte derecha
                      Text(
                        value,
                        style: textStyle.bodyMedium!.copyWith(
                          fontWeight: FontWeight.normal,
                        ),
                      ),

                      const SizedBox(height: 15),
                    ],
                  );
                }),
                //Indicador de ir hacia otra vista
                if (widget.bottomRightWidget != null)
                  Align(
                      alignment: Alignment.bottomRight,
                      child: widget.bottomRightWidget!),
              ],
            )
          : IntrinsicHeight(
            child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      //Se generan los textos
                      children: widget.texts
                          //se salta el status ya que se usa para el boton
                          .where((entry) => (entry['label'] != 'status'))
                          .map((entry) {
                        //Parte izquierda
                        final label = entry['label'] ?? "";
            
                        //Parte derecha
                        final value = entry['value'] ?? "";
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text.rich(
                              TextSpan(
                                children: [
                                  //Parte izquierda
                                  TextSpan(
                                    text: label,
                                    style: textStyle.bodyMedium!.copyWith(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  //Parte derecha
                                  TextSpan(
                                    text: value,
                                    style: textStyle.bodyMedium!.copyWith(
                                      fontSize: 13,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 4), // Espaciado entre textos
                          ],
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                 if (widget.bottomRightWidget != null)
                  Expanded(
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: widget.bottomRightWidget!,
                    ),
                  ),
                ],
              ),
          ),
    );
  }
}
