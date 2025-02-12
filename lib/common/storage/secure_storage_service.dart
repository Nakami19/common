import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  FlutterSecureStorage _getSecureStorage() {
    return const FlutterSecureStorage(
      aOptions: AndroidOptions(
        encryptedSharedPreferences: true,
      ),
    );
  }

  // Leer valor individual
  ///[key] clave del valor que se desea recuperar
  //retorna el valor asociado a la clave
  Future getValue(String key) async {
    final secureStorage = _getSecureStorage();
    final value = await secureStorage.read(key: key);
    return value;
  }

  // Leer todos los valores almacenados
  Future<Map<String, String>> readAll() async {
    final secureStorage = _getSecureStorage();
    final data = await secureStorage.readAll();
    return data;
  }

  // Guardar un valor en el almacenamiento seguro
  Future<void> setKeyValue(String key, dynamic value) async {
    final secureStorage = _getSecureStorage();
    await secureStorage.write(key: key, value: value);
  }

  // Borrar un valor especifico del almacenamiento seguro
  Future<void> deleteValue(String key) async {
    final secureStorage = _getSecureStorage();
    secureStorage.delete(key: key);
  }

  // Borrar todos los valores del almacenamiento seguro.
  Future<void> deleteAll() async {
    final secureStorage = _getSecureStorage();
    await secureStorage.deleteAll();
  }
}

