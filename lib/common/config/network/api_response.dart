import 'api_error.dart';


class ApiResponse<T> {
  final String apiVersion; // Versión de la API.
  final String trackingCode; // Código de seguimiento para la solicitud.
  T? data; // Datos devueltos por la API (puede ser de cualquier tipo).
  List<ApiError>? errors; // Lista de errores devueltos por la API.
  final String message; // Mensaje general de la API.
  final bool maintenance; // Indica si la API está en mantenimiento.
  final int date; // Fecha de la respuesta en formato timestamp.
  final dynamic langVersion; // Versión del lenguaje, si aplica.
  final dynamic token; // Token de autenticación, si aplica.
  final List<dynamic> privileges; // Lista de privilegios asociados al usuario.
  final dynamic appVersion; // Versión de la aplicación, si aplica.

  ApiResponse({
    required this.apiVersion,
    required this.trackingCode,
    this.data,
    this.errors,
    required this.message,
    required this.maintenance,
    required this.date,
    this.langVersion,
    this.token,
    required this.privileges,
    this.appVersion,
  });

  //Crear una instancia de `ApiResponse` a partir de un JSON.
  factory ApiResponse.fromJson(
    Map<String, dynamic> json,
    Function? dataFromJson,
    Function? errorDataFromJson,
  ) {
    T? data;
    List<ApiError>? errorList;

    // Procesa los datos si se proporciona `dataFromJson` y el JSON contiene una clave `data`.
    if (dataFromJson != null && json.containsKey('data')) {
      final jsonData = json['data'];

     // Si `T` es una lista, mapea cada elemento usando `dataFromJson`.
      if (T == List) {
        if (jsonData is List) {
          data = jsonData.map((item) => dataFromJson(item)).toList() as T?;
        }
      } else {
        // Si no es una lista, aplica `dataFromJson` directamente.
        if (jsonData != null) {
          data = dataFromJson(jsonData) as T?;
        } else {
          data = null;
        }
      }
    } 
    // Procesa los errores si se proporciona `errorDataFromJson` y el JSON contiene una clave `data`.
    else if (errorDataFromJson != null && json.containsKey('data')) {
      if (json['data'] is List) {
        final errorDataList = json['data'] as List<dynamic>;
        errorList = errorDataList
            .map((errorData) => errorDataFromJson(errorData))
            .cast<ApiError>()
            .toList();
      } else {
        errorList = [errorDataFromJson(json['data'])];
      }
    }

    // Crea y devuelve una instancia de `ApiResponse` con los datos procesados.
    return ApiResponse<T>(
      apiVersion: json['apiVersion'],
      trackingCode: json['trackingCode'],
      data: data,
      message: json['message'],
      maintenance: json['maintenance'],
      date: json['date'],
      langVersion: json['langVersion'],
      token: json['token'],
      errors: errorList,
      privileges: List<dynamic>.from(json['privileges'].map((x) => x)),
      appVersion: json['appVersion'],
    );
  }

  //Representar la respuesta como un String.
  @override
  String toString() {
    return '''
    ApiResponse(
      apiVersion: $apiVersion,
      trackingCode $trackingCode,
      data: $data,
      message: $message,
      maintenance: $maintenance,
      date: $date,
      langVersion: $langVersion,
      token: $token,
      privileges: $privileges,
      appVersion: $apiVersion,
    )
    ''';
  }
}
