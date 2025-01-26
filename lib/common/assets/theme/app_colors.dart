import 'package:flutter/material.dart';

const Color primaryColor = Color(0xFF14C6A4);
const Color secondaryColor = Color(0xFF6A9CF3);
const Color primaryScaffoldColor = Color(0xFFFFFFFF);
const Color lightColor = Color(0xFFf1f4f8);
const Color errorColor = Color(0xFFEA3A3D);
Color dialogsBarrierColor = const Color(0xFF24264D).withOpacity(0.75);
const lightThemeTextColor = Color.fromARGB(255, 35, 43, 58);
const hintTextColor = Colors.grey;
const appBarShadowColor = Colors.grey;
const dialogBackgroundColor = Colors.white;
const textFiledHintColor = Color(0xFFA09F9F);
const textFieldBorderColor = Colors.grey;
const cardsColor = Colors.white;

// Colores modo oscuro
const darkColor = Color(0xFF333333); //negro oscuro SOLO FONDO
const containerColor = Color(0xFF3f3f3f); //negro claro
const darkSecondaryColor = Color(0xFF2e2926);
const textColor = Colors.white;
const inputErrorColor = Color(0xFFFF0000);
var checkBoxColor = Colors.grey[700]; // Color cuando el Checkbox está deshabilitado
var unselectedItemColor = Colors.grey[600];
const textFieldColor = Color(0xFFEAEAEA);
var textFieldErrorBorderColor = Colors.red.shade800;

//Colores para los estados (Activo, Pagado...)
final Map<String, Color> statusColors = {
  "Pendiente": Color(0xff02a8f5),
  "Exitosa": primaryColor,
  "RECHAZADO": Color(0xffff0000),
  "ACTIVO": Color(0xff02a8f5),
  "PAGADA": primaryColor,
  "PAGADA CON SOBRANTE": Colors.green,
  "PAGADA CON FALTANTE": Colors.orange,
  "EXPIRADA": Color(0xff595959),
  "REVERSADA": Color.fromARGB(219, 246, 195, 26),
  'Confirmada': primaryColor,
  "Por Confirmar": const Color.fromARGB(219, 246, 195, 26),
  'APROBADO': primaryColor,
  'POR CARGAR': Colors.grey,
  'FINALIZADO': Color(0xff02a8f5),
  'PROCESANDO': Color(0xff02a8f5),
  'REVISIÓN MANUAL': Color.fromARGB(219, 246, 195, 26),
  'APPROVED': primaryColor,
  'REJECTED': Color(0xffff0000),
  'MANUAL-REVIEW': Color.fromARGB(219, 246, 195, 26),
  'PROCESSING': Color(0xff02a8f5),
  'TO-LOAD': Colors.grey,
};

//Color cintillos
const developerColor = 0xFF2B4B2C;
const qualityColor = 0xFFF0C200;
const productionColor = 0x00000000;


