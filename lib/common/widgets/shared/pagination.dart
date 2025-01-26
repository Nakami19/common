import '/common/providers/pagination_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Pagination extends StatelessWidget {
  const Pagination({super.key, this.onPreviousPressed, this.onNextPressed});

  final void Function()? onPreviousPressed;
  final void Function()? onNextPressed;

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<PaginationProvider>();
    final textStyle = Theme.of(context).textTheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        //Boton de volver a pagina anterior
        TextButton(
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero, // Elimina el padding adicional
            tapTargetSize: MaterialTapTargetSize
                .shrinkWrap, // Reduce el tamaño del área tocable
          ),
          onPressed: provider.page > 0
              ? () async {
                  await provider.previousPage(context);
                  if (onPreviousPressed != null) {
                    onPreviousPressed!();
                  }
                }
              : null,
          child: const Row(
            children: [Icon(Icons.arrow_back_ios, size: 14)],
          ),
        ),

        //Texto indicando pagina actual
        Text(
          'Página ${provider.page + 1} de ${provider.getNumPages()}',
          style: textStyle.bodyMedium!.copyWith(
            fontWeight: FontWeight.bold
          ),
        ),

        //Boton para ir a pagina siguiente
        TextButton(
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero, // Elimina el padding adicional
            tapTargetSize: MaterialTapTargetSize
                .shrinkWrap, // Reduce el tamaño del área tocable
          ),
          onPressed: provider.page + 1 < provider.getNumPages()
              ? () async {
                  await provider.nextPage(context);
                  if (onNextPressed != null) {
                    onNextPressed!();
                  }
                  // _resetScroll();
                }
              : null,
          child: const Row(
            children: [Icon(Icons.arrow_forward_ios, size: 14)],
          ),
        ),
      ],
    );
  }
}
