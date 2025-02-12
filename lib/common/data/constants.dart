// Tipo de conexión 
enum Connection {
  developer,
  qa,
  sandbox,
  preProduction,
  production,
}

//version de la app, build y rutas a Assets de common
class Constants{
  static String? appVersion;
  static String? buildNumber;
  static String imagesChinchin = 'lib/common/assets/images/chinchin';
  static String banksLogo = 'lib/common/assets/images/logos/banks_logo';
  static String socialMedia = 'lib/common/assets/images/logos/social_media';
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

