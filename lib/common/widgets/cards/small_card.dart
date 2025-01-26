import '/common/assets/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

//Tarjeta que contiene de manera vertical una imagen y texto
class SmallCard extends StatelessWidget {
  const SmallCard({
    super.key,
    required this.image,
    required this.title,
    this.placeholder,
    this.height,
    this.width,
    this.imageHeight,
    this.textStyle,
    this.onTap
    });
  final String image;
  final String? placeholder;
  final String title;
  final double? height;
  final double? width;
  final double? imageHeight;
  final TextStyle? textStyle;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap ?? ()=>{},

      //contenedor de los elementos
      child: Container(
        width: width ?? double.infinity,

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
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,

        children: [
          //imagen arriba
          SvgPicture.asset(
            image,
            height: imageHeight ?? 50,
            //Imagen de respaldo
            placeholderBuilder: (context) => 
            SvgPicture.asset(
              placeholder??image,
              height: imageHeight ?? 50,
              ),
            ),

            const SizedBox(height: 5,),

          //Texto abajo
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              title,
              style: textStyle,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              ),
          )
        ],
      ),
      ),
    );
  }
}