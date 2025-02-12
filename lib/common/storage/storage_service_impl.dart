import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  Future<SharedPreferences> getSharedPrefs() async {
    return await SharedPreferences.getInstance();
  }

  // Recupera un valor del almacenamiento dado su clave y el tipo esperado.
  Future<T?> getValue<T>(String key) async {
    final prefs = await getSharedPrefs();
    // Determina el tipo de dato a recuperar según `T`.
    if (T == int) {
      return prefs.getInt(key) as T?;
    } else if (T == String) {
      return prefs.getString(key) as T?;
    } else if (T == bool) {
      return prefs.getBool(key) as T?;
    } else {
      throw UnimplementedError('GET not implemented for type ${T.runtimeType}');
    }
  }

  /// Elimina un valor del almacenamiento dado su clave.
  Future<bool> removeKey(String key) async {
    final prefs = await getSharedPrefs();
    return await prefs.remove(key);
  }

  /// Guarda un valor en el almacenamiento dado su clave y tipo.
  Future<void> setKeyValue<T>(String key, T value) async {
    final prefs = await getSharedPrefs();

    // Determina el tipo de dato a guardar según `T`.
    if (T == int) {
      await prefs.setInt(key, value as int);
    } else if (T == String) {
      await prefs.setString(key, value as String);
    } else if (T == bool) {
      await prefs.setBool(key, value as bool);
    } else {
      throw UnimplementedError(
          'Set not implemented for type ${T.runtimeType}');
    }
  }

  /// Método para eliminar todos los datos
  Future<void> deleteAll() async {
    final prefs = await getSharedPrefs();
    final keys = prefs.getKeys(); // Obtener todas las claves almacenadas
    for (String key in keys) {
      await prefs.remove(key); // Eliminar cada clave
    }
  }
}
