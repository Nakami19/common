// Tipo de conexión 
enum Connection {
  developer,
  qa,
  sandbox,
  preProduction,
  production,
}

//version de la app y build
class Constants{
  static String? appVersion;
  static String? buildNumber;
  static String imagesChinchin = 'lib/common/assets/images/chinchin';
}

//tipo de documento de identidad
List<String> typeDocuments = [
  'V',
  'J',
  'G',
  'E',
  'P',
  'Cancelar', // Cancelar
];

//Formato para numeros de telefono
final phoneRegex = RegExp(r'^(0424|0414|0412|0426|0416|424|414|412|426|416)[0-9]{7}$');

