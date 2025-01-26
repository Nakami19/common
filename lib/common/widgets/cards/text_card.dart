import '/common/assets/theme/app_colors.dart';
import '/common/assets/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextCard extends StatelessWidget {
  const TextCard({
    super.key,
    this.height,
    this.width,
    this.onTap,
    this.textsStyle,
    this.statusTextStyle,
    required this.texts,
  });

  final VoidCallback? onTap;
  final double? height;
  final double? width;
  final List<Map<String, dynamic>> texts;
  final TextStyle? textsStyle;
  final TextStyle? statusTextStyle;

  @override
  Widget build(BuildContext context) {
    // Buscar el status y su color
    final statusEntry = texts.firstWhere(
      (entry) => entry.containsValue('status'),
      orElse: () => {}, // Valor por defecto si no se encuentra
    );

    final status = statusEntry['value'];
    final statusColor = statusEntry['statusColor'];

    return InkWell(
      onTap: onTap ?? () {},
      //Contenedor principal de la informacion
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadiusValue),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.25),
              spreadRadius: 3,
              blurRadius: 5,
              offset: Offset(0, 5),
            ),
          ],
        ),

        //Para que ocupe toda la altura disponible
        child: IntrinsicHeight(
          child: Row(
            children: [
              // Textos a la izquierda
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  //Se generan los textos
                  children: texts
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
                                style: textsStyle?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ) ?? GoogleFonts.lato(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              //Parte derecha
                              TextSpan(
                                text: value,
                                style: textsStyle?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ) ?? GoogleFonts.lato(
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

              // Botón e icono

              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Icon(
                    Icons.info_outline,
                    color: primaryColor,
                    size: 25,
                  ),


                  const Spacer(),

                  //si se tiene un estatus se muestra
                  if (status != null && status != "")
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        side: BorderSide(
                          color: statusColor ?? primaryColor,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(borderRadiusValue),
                        ),
                      ).copyWith(
                        //Quita efecto al presionar
                        overlayColor: MaterialStateProperty.all(Colors
                            .transparent), 
                        elevation: MaterialStateProperty.all(0),
                      ),
                      onPressed: () {},
                      //Nombre del estatus
                      child: SizedBox(
                        width: 90,
                        child: Text(
                          status,
                          style: statusTextStyle?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: statusColor ?? primaryColor,
                          ) ?? GoogleFonts.lato(
                            fontWeight: FontWeight.w600,
                            color: statusColor ?? primaryColor,
                            fontSize: 13,
                          ),
                          softWrap: true, // Permite saltos de línea
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  SizedBox(
                    height: 5,
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
