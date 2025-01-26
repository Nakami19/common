import '/common/infrastructure/shared/key_value_storage_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageService extends KeyValueStorageService {
  Future<SharedPreferences> getSharedPrefs() async {
    return await SharedPreferences.getInstance();
  }

 // Recupera un valor del almacenamiento dado su clave y el tipo esperado.
  @override
  Future<T?> getValue<T>(String key) async {
    final prefs = await getSharedPrefs();
    // Determina el tipo de dato a recuperar según `T`.
    switch (T) {
      case int:
        return prefs.getInt(key) as T?;

      case String:
        return prefs.getString(key) as T?;

      case bool:
        return prefs.getBool(key) as T?;

      default:
        throw UnimplementedError(
            'GET not implemented for type ${T.runtimeType}');
    }
  }

/// Elimina un valor del almacenamiento dado su clave.
  @override
  Future<bool> removeKey(String key) async {
    final prefs = await getSharedPrefs();
    return await prefs.remove(key);
  }

  /// Guarda un valor en el almacenamiento dado su clave y tipo.
  @override
  Future<void> setKeyValue<T>(String key, T value) async {
    final prefs = await getSharedPrefs();

    // Determina el tipo de dato a guardar según `T`.
    switch (T) {
      case int:
        await prefs.setInt(key, value as int);
        break;

      case String:
        await prefs.setString(key, value as String);
        break;

      case bool:
        await prefs.setBool(key, value as bool);
        break;

      default:
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
