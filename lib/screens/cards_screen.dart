import 'package:common/common/common_index.dart';
import 'package:flutter/material.dart';

class CardsScreen extends StatefulWidget {
  const CardsScreen({super.key});

  @override
  State<CardsScreen> createState() => _CardsScreenState();
}

class _CardsScreenState extends State<CardsScreen> {
  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.center,
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 50,),
            Align(
              alignment: Alignment.center,
              child: LargeCard(
                image: "${Constants.imagesChinchin}/chinchin_logo_favicon.svg", 
                title: 'Prueba', 
                textStyle: textStyle.bodyLarge,
                width: 300,
                center: false,
                imageHeight: 30,
                ),
            )
          ],
        ),
      ),
    );
  }
}
