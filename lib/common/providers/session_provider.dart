import 'dart:async';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../app.dart';
import '../common_index.dart';



//no se movieron a general provider ya que en otros providers no son necesarios estos metodos
class SessionProvider extends GeneralProvider {
  final storage = SecureStorageService();
  bool _isAuthenticated = false;
  bool _isDialogOpen = false;
  int? _expirationTime;
  Timer? _timer;
  bool _isTimerPaused = false; 
  bool _isMaintenanceMode = false;
  bool get isMaintenanceMode => _isMaintenanceMode;
  static const int maxSeconds = 20;


// Funcion para refrescar la sesión
  Future<Response<dynamic>> Function()? _refreshSessionCallback;

  // Método para configurar la funcion de refrescar sesión
  void setRefreshSessionCallback(Future<Response<dynamic>> Function() callback) {
    _refreshSessionCallback = callback;
  }


  void setMaintenanceMode(bool value) {
    _isMaintenanceMode = value;
    notifyListeners(); 
  }

  void startSessionTimer(int time) {
    bool isActionSuccessClicked = false;

    if (!_isAuthenticated) {
      return;
    }

    _expirationTime = time;
    final context = navigatorKey.currentContext ?? navigatorKey.currentState!.context;

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) async {
      
      if (_isTimerPaused) return; // No realizar acciones si está pausado
      time -= 1000;

      if (_timer != null) {
        if (time <= 30000 && !_isDialogOpen) {
          //Cuando queden 10 segundos se muestra el dialogo de refrescar
          if (time <= 10000 && !_isDialogOpen) {
          _isDialogOpen = true;
          await showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => WillPopScope(
              onWillPop: () async => false,
              child: customDialog(
                context,
                // showTimer: true,
                title: 'Refrescar sesión',
                content: const Text('¿Deseas extender el tiempo de tu sesión?'),
                cancelButtonText: 'CERRAR',
                provider: SessionProvider(),
                closeAction: () {
                  timer.cancel();
                  destroySession();
                },
                actionSuccess: () async {
                  if (!isActionSuccessClicked) {
                    isActionSuccessClicked = true;

                   await refreshSession().then(
                      (value) {
                        if (statusCode == HttpStatus.ok) {
                          Navigator.pop(context, true);
                        }
                      },
                    );

                    if (statusCode != HttpStatus.ok) {
                      return;
                    }

                    _isDialogOpen = false;
                    _timer?.cancel();
                    timer.cancel();
                    resetSessionTimer();
                  }
                },
              ),
            ),
          );
        }
      }
    // Destruye la sesión si el tiempo expira
      if (time <= 0) {
        _isTimerPaused = false;
        timer.cancel();
        _timer?.cancel();
        destroySession();
      }
    }});
  }

// Pausa el temporizador
  void pauseTimer() {
    if (_timer != null && !_isTimerPaused) {
      _isTimerPaused = true;
      _timer?.cancel();
    }
  }

// Reinicia el temporizador
  void resetSessionTimer() {
    if (!_isAuthenticated) {
      _isTimerPaused = false;
      return;
    }

    if (_timer != null) {
      _isTimerPaused = false;
      _timer?.cancel();
      startSessionTimer(_expirationTime!);
    }
  }

  void showNoInternetPopup() async {
    final context = navigatorKey.currentContext;
    if (context != null) {
      // ignore: use_build_context_synchronously
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return WillPopScope(
            onWillPop: () async => false,
            child: StatefulBuilder(
              builder: (BuildContext context, setState) {
                return AlertDialog(
                  title: const Text(
                    'No se ha podido procesar su solicitud',
                    textAlign: TextAlign.center,
                  ),
                  content: const Text(
                    'Verifica tu conexión a internet',
                    textAlign: TextAlign.center,
                  ),
                  actions: <Widget>[
                    Align(
                      alignment: Alignment.center,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryColor,
                        ),
                        onPressed: () async {
                          final connectivityResult =
                              await Connectivity().checkConnectivity();
                          if (connectivityResult == ConnectivityResult.none) {
                            // ignore: use_build_context_synchronously
                            Navigator.of(context).pop();
                            await Future.delayed(
                                const Duration(milliseconds: 500));
                            showNoInternetPopup();
                          } else {
                            // ignore: use_build_context_synchronously
                            Navigator.of(context).pop();
                          }
                        },
                        child: const Text(
                          'Reintentar',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          );
        },
      );
    }
  }

 // Destruye la sesión del usuario
  void destroySession({bool? haveModalAction = true, String firstScreen='/firstLoginScreen'}) {
    _timer?.cancel();
    _timer = null;
    _isDialogOpen = false;
    _isAuthenticated = false;


    storage
      ..deleteValue(
        'userData',
      )
      ..deleteValue(
        'timeExpiration',
      );

    if (haveModalAction != null && haveModalAction) {
      Navigator.pop(
        navigatorKey.currentContext ?? navigatorKey.currentState!.context,
      );

      navigatorKey.currentState?.pushNamedAndRemoveUntil(
        firstScreen,
        (route) => false,
      );

      WidgetsBinding.instance.addPostFrameCallback((_) {
        Snackbars.customSnackbar(
          navigatorKey.currentContext!,
          title: '¡Vuelva pronto!',
          message: 'Su sesión ha expirado exitosamente.',
        );

        AppProviders.disposeAllProviders(
          navigatorKey.currentContext ?? navigatorKey.currentState!.context,
        );
      });
    }
  }

  void authenticateUser() {
    _isAuthenticated = true;
  }

  void cancelTimer({bool? haveModalAction = true, String firstScreen='/firstLoginScreen'}) {
    _timer?.cancel();
    _isDialogOpen = false;
    _isAuthenticated = false;

    storage
      ..deleteValue(
        'userData',
      )
      ..deleteValue(
        'timeExpiration',
      );

    if (haveModalAction != null && haveModalAction) {
      Navigator.pop(
        navigatorKey.currentContext ?? navigatorKey.currentState!.context,
      );

      navigatorKey.currentState?.pushNamedAndRemoveUntil(
        firstScreen,
        (route) => false,
      );

      WidgetsBinding.instance.addPostFrameCallback((_) {
        AppProviders.disposeAllProviders(
          navigatorKey.currentContext ?? navigatorKey.currentState!.context,
        );
      });
    }
  }


  // Refresca la sesión del usuario usando la funcion configurada
  Future<void> refreshSession() async {
    pauseTimer();
    if (_refreshSessionCallback == null) {
      throw Exception('Refresh session callback not set');
    }

    try {
      super.setLoadingStatus(true);
      final req = await _refreshSessionCallback!();
      super.setStatusCode(req.statusCode!);

      ApiResponse.fromJson(
        req.data,
        (json) => null,
        (json) => null,
      );
    } on DioError catch (error) {
      final response = error.response;
      final data = response?.data as Map<String, dynamic>;
      super.setStatusCode(response!.statusCode!);

      final resp = ApiResponse.fromJson(
        data,
        (json) => null, // No hay data para el caso de error
        (json) => ApiError(
          message: json['message'],
          value: json['value'],
          trackingCode: json['trackingCode'],
        ),
      );

      super.setErrors(true);
      super.setErrorMessage(resp.message);
      super.setTrackingCode(resp.trackingCode);

      Snackbars.customSnackbar(
        navigatorKey.currentContext!,
        title: resp.trackingCode,
        message: resp.message,
      );
    } finally {
      super.setLoadingStatus(false);
    }

    notifyListeners();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _isAuthenticated = false;
    super.dispose();
  }

  void onDioerror(error) {
     final response = error.response;
      final data = response?.data as Map<String, dynamic>;

      final resp = ApiResponse.fromJson(
        response?.data as Map<String, dynamic>,
        (json) => data['data'], // No hay data para el caso de error
        (json) => ApiError(
          message: json['message'],
          value: json['value'],
          trackingCode: json['trackingCode'],
        ),
      );

      super.setSimpleError(true);
      super.setErrorMessage(resp.message);
      

      super.setTrackingCode(resp.trackingCode);

      Snackbars.customSnackbar(
        navigatorKey.currentContext!,
        title: resp.trackingCode,
        message: resp.message
      );
  }



}
