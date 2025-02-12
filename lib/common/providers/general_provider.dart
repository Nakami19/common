import 'package:flutter/material.dart';

class GeneralProvider extends ChangeNotifier {

  bool enabledBiometric = false;

  //Status de la biometria
  void changeBiometricStatus(bool val) {
    enabledBiometric = val;
    notifyListeners();
  }

  bool existUser = false;
  void setUserExist(bool val) {
    existUser = val;
    notifyListeners();
  }

  // 1. usuario o correo
  // 2. telefono
  // 3. CI/RIF
  int userType = 1;
  void setUserType(int val) {
    userType = val;
    notifyListeners();
  }

  bool actionWithUser = true;
  void isActionWithUser(bool val) {
    actionWithUser = val;
    notifyListeners();
  }

  //identificar si hay errores
  bool haveErrors = false;
  void setErrors(bool val) {
    haveErrors = val;
    notifyListeners();
  }

  //mensaje de error
  dynamic errorMessage;
  void setErrorMessage(dynamic val) {
    errorMessage = val;
    notifyListeners();
  }

  // objeto data que viene en los errores de las peticiones
  dynamic errorData;
  void setErrorData(dynamic val) {
    errorData = val;
    notifyListeners();
  }

  //identificar si hay errores
  bool haveSimpleError = false;
  void setSimpleError(bool val) {
    haveSimpleError = val;
    notifyListeners();
  }

  //identificar tracking code
  String? trackingCode;
  void setTrackingCode(String val) {
    trackingCode = val;
    notifyListeners();
  }

  //identificar si el input tiene errores
  bool _haveInputErrors = false;
  bool get haveInputErrors => _haveInputErrors;
  void setInputErrors(bool val) {
    _haveInputErrors = val;
    notifyListeners();
  }

  //codigo del status de la peticion
  int? statusCode;
  void setStatusCode(int val) {
    statusCode = val;
    notifyListeners();
  }

  //Funcion para colocar primera letra en mayuscula
  String capitalize(String str) {
    return str
        .split(' ')
        .map((str) => str.isEmpty
            ? ''
            : '${str[0].toUpperCase()}${str.substring(1).toLowerCase()}')
        .join(' ');
  }

  //identificar si se esta cargando algo
  bool isLoading = false;
  void setLoadingStatus(bool val) {
    isLoading = val;
    notifyListeners();
  }

  //se reinician los valores
  void disposeValues() {
    setErrors(false);
    setSimpleError(false);
    setErrorMessage('');
    setTrackingCode('');
    setInputErrors(false);
    setStatusCode(0);
    setLoadingStatus(false);
    setUserExist(false);
    notifyListeners();
  }

  void resetValues() {
    setErrors(false);
    setSimpleError(false);
    setErrorMessage('');
    setTrackingCode('');
    setInputErrors(false);
    setStatusCode(0);
    setLoadingStatus(false);
    setUserExist(false);
    notifyListeners();
  }
}
