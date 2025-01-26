import '/common/assets/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

//Tarjeta que contiene de manera horizontal una imagen y texto
class LargeCard extends StatelessWidget {
  const LargeCard(
      {super.key,
      required this.image,
      required this.title,
      required this.placeholder,
      this.height,
      this.width,
      this.imageHeight,
      this.textStyle,
      this.onTap});

  final String image; //imagen
  final String placeholder; //imagen default por si sucede error con la imagen principal
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
        
        height: height ?? double.infinity,
        width: width ?? double.infinity,
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

      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [

          //imagen a la izquierda
          SvgPicture.asset(
            image,
            height: imageHeight ?? 70,
            placeholderBuilder: (context) => 
            SvgPicture.asset(
              placeholder,
              height: imageHeight ?? 70,
              ),
            ),

         const SizedBox(width: 20,),

          //Texto a la derecha
          Expanded(
            child: Text(
              title,
              style: textStyle,
              ),
          )
        ],
      ),
      ),
    );
  }
}
