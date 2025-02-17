import 'package:common/common/common_index.dart';
import 'package:flutter/material.dart';

class CardsScreen extends StatefulWidget {
  const CardsScreen({super.key});

  @override
  State<CardsScreen> createState() => _CardsScreenState();
}

class _CardsScreenState extends State<CardsScreen> {
  List<Map<String, dynamic>> texts = [
    {
      'label': 'Nombre: ',
      'value': 'Juan Pérez',
    },
    {
      'label': 'Edad: ',
      'value': '30 años',
    },
    {
      'label': 'Correo electrónico: ',
      'value': 'juan.perez@example.com',
    },
    {
      'label': 'Teléfono: ',
      'value': '+1 234 567 890',
    },
    {
      'label': 'Dirección: ',
      'value': 'Calle Falsa 123, Springfield',
    },
    {
      'label': 'Estado: ',
      'value': 'Activo',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.center,
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 50,
            ),
            Align(
              alignment: Alignment.center,
              child: LargeCard(
                image: "${Constants.imagesChinchin}/chinchin_logo_favicon.svg",
                title: 'Prueba',
                textStyle: textStyle.bodyLarge,
                width: 100,
                center: false,
                imageHeight: 30,
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            InformationCard(
              title: 'Prueba',
              texts: texts,
              isInformationinColumn: true,
              bottomRightWidget: GestureDetector(
              onTap: (){},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Siguiente',
                    style: textStyle.bodyMedium!
                        .copyWith(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Icon(Icons.arrow_forward)
                ],
              ),
            ),
            )
          ],
        ),
      ),
    );
  }
}
