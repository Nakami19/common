import '/common/assets/theme/app_colors.dart';
import 'package:flutter/material.dart';

class StatusCheckboxs extends StatefulWidget {
  const StatusCheckboxs(
      {super.key,
      required this.status,
      this.onTap,
      required this.selectedStatuses});

  final List<dynamic> status;
  final Function()? onTap;
  final Set<String> selectedStatuses;

  @override
  State<StatusCheckboxs> createState() => _StatusCheckboxsState();
}

class _StatusCheckboxsState extends State<StatusCheckboxs> {
  ///Si el estado está en selectedStatuses, se elimina. Si no, se añade.
  void filterStatus(String idStatus) {
    setState(() {
      if (widget.selectedStatuses.contains(idStatus)) {
        widget.selectedStatuses.remove(idStatus);
      } else {
        widget.selectedStatuses.add(idStatus);
      }
    //Si hay una funcion asociada al seleccionar un estatus se ejecuta
      if (widget.onTap != null) {
        widget.onTap!();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //Titulo e icono de mostrar estados
        Row(
          children: [
            const SizedBox(
              width: 20,
            ),
            Text(
              "Filtrar por estado",
              style:
                  textStyle.bodyMedium!.copyWith(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
           const  SizedBox(width: 5,),
            GestureDetector(
              child: const Icon(Icons.info_outline_rounded, color: darkColor,),
              onTap: () {
                showStatusNames(context);
              },
            )
          ],
        ),
        const SizedBox(
          height: 16,
        ),
        Row(
          children: [
            const SizedBox(
              width: 20,
            ),
            //Lista de estados
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: widget.status.map((status) {
                //verifica que el estado este seleccionado
                final bool isSelected =
                    widget.selectedStatuses.contains(status['idStatus']);
                return GestureDetector(
                  onTap: () => {
                    filterStatus(status['idStatus']),
                  },
                  child: AnimatedContainer(
                    width: 35,
                    height: 35,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    decoration: BoxDecoration(
                      color: isSelected
                          ? statusColors[status['name']]
                          : Colors.transparent,
                      border: Border.all(
                          color: statusColors[status['name']] ??
                              Colors.transparent,
                          width: 2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ],
    );
  }

  //Muestra un diálogo con la lista de estados y sus colores asociados.
   showStatusNames(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
     showDialog(
      context: context, 
      builder: (context) {
        return AlertDialog(
          backgroundColor: primaryScaffoldColor,
          title: Text("Estados", style: textStyle.bodyLarge!.copyWith(fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
          content: SizedBox(
            height: MediaQuery.of(context).size.height * 0.30,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ... widget.status.map((singleStatus){
                  return Column(
                    children: [
                      Row(
                        children: [
                          //Cuadrado con el color del estado
                          Container(
                            width: 25,
                            height: 25,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              shape: BoxShape.rectangle,
                              color: statusColors[singleStatus['name']]
                            ),
                          ),
                          const SizedBox(width: 10,),
                          //Nombre del estado
                          Text(singleStatus['name'], style: textStyle.bodySmall,),
                        ],
                      ),
                      const SizedBox(height: 15,)
                    ],
                  );
                })
              ],
            ),
          ),
        );
      }
      );
  }
}
