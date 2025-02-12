import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../common_index.dart';

// Tarjeta que contiene una imagen y texto, con texto debajo de la imagen si no hay suficiente espacio
class LargeCard extends StatelessWidget {
  const LargeCard({
    super.key,
    required this.image,
    required this.title,
    this.placeholder,
    this.height,
    this.width,
    this.imageHeight,
    this.textStyle,
    this.onTap,
    this.center = true,
  });

  final String image; // imagen
  final String? placeholder; // imagen default por si sucede error con la imagen principal
  final String title;
  final double? height;
  final double? width;
  final double? imageHeight;
  final TextStyle? textStyle;
  final VoidCallback? onTap;
  final bool center;

  // Método para determinar si la imagen es SVG
  bool _isSvg(String imagePath) {
    return imagePath.toLowerCase().endsWith('.svg');
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap ?? () {},

      // Contenedor de los elementos
      child: Container(
        height: height,
        width: width,
        padding: const EdgeInsets.all(13),

        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadiusValue),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              spreadRadius: 3,
              blurRadius: 5,
              offset: const Offset(0, 5),
            ),
          ],
        ),

        // Usamos Wrap para permitir que el texto se desplace debajo de la imagen
        child: Wrap(
          alignment: center? WrapAlignment.center : WrapAlignment.start, // Alineación de los elementos
          crossAxisAlignment: WrapCrossAlignment.center, // Centrar verticalmente
          spacing: 20, // Espacio horizontal entre la imagen y el texto
          children: [
            
            // Imagen
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 4),
              child: _isSvg(image)
                  ? SvgPicture.asset(
                      image,
                      height: imageHeight ?? 70,
                      placeholderBuilder: (context) => 
                      SvgPicture.asset(
                        placeholder ?? "${Constants.imagesChinchin}/chinchin_logo_favicon.svg",
                        height: imageHeight ?? 70,
                      ),
                    )
                  : Image.asset(
                      image,
                      height: imageHeight ?? 70,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) => 
                      SvgPicture.asset(
                        placeholder ?? "${Constants.imagesChinchin}/chinchin_icono.png",
                        height: imageHeight ?? 70,
                      ),
                    ),
            ),


            // Texto
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 4),
              child: Text(
                title,
                style: textStyle,
                softWrap: true, 
              ),
            ),
          ],
        ),
      ),
    );
  }
}