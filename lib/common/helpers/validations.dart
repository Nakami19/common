class Validations {
  //Validacion de campo vacio
  static String? required(String? value) {
    if (value == null || value.isEmpty) {
      return 'Campo requerido';
    }
    return null;
  }

  //Validacion de espacios
  static String? noSpaces(String? value) {
    if (value != null && value.contains(' ')) {
      return 'El campo no permite espacios';
    }
    return null;
  }

  //Validacion longitud minima de caracteres
  static String? minLength(String? value, int length) {
    if (value != null && value.isNotEmpty && value.length < length) {
      return 'Debe tener al menos $length caracteres';
    }
    return null;
  }

  //Validacion longitud maxima de caracteres
  static String? maxLength(String? value, int length) {
    if (value != null && value.isNotEmpty && value.length > length) {
      return 'Máximo $length caracteres';
    }
    return null;
  }

  //Validacion de numero telefonico
  static String? phoneFormat(String? value) {
    final phoneRegex =
        RegExp(r'^(0424|0414|0412|0426|0416|424|414|412|426|416)[0-9]{7}$');

    if (value != null && value.isNotEmpty) {
      //Longitud estandar de numero telefonico
      if (value.length < 10 || value.length > 11) {
        return 'El formato no es válido';
      }
      //Que cumpla con el formato
      if (!phoneRegex.hasMatch(value)) {
        return 'El código de área no es válido';
      }
    }

    return null;
  }

  //Validacion solo numeros
  static String? noLetters(String? value) {
    final letterRegex = RegExp(r'[a-zA-Z]');
    if (value != null && letterRegex.hasMatch(value)) {
      return 'No se permiten letras en este campo';
    }
    return null;
  }

  // Validación para requerir al menos `minLetters` letras en el campo
  static String? requiresLetters(String? value, int minLetters) {
    final letterRegex = RegExp(r'[a-zA-Z]');
    if (value == null || value.isEmpty) return 'Campo requerido';

    // Contar cuántas letras hay en el valor
    int letterCount = value.split('').where((char) => letterRegex.hasMatch(char)).length;

    if (letterCount < minLetters) {
      if(minLetters ==1) {
        return 'Debe contener al menos $minLetters carácter';
      } else {
       return 'Debe contener al menos $minLetters carácteres'; 
      }
    }


    return null;
  }

  //Validacion requiere una letra minuscula
  static String? requiresLowercase(String? value) {
    if (value != null && !RegExp(r'[a-z]').hasMatch(value)) {
      return 'Debe contener al menos una letra minúscula';
    }
    return null;
  }

  //Validacion requiere una letra mayuscula
  static String? requiresUppercase(String? value) {
    if (value != null && !RegExp(r'[A-Z]').hasMatch(value)) {
      return 'Debe contener al menos una letra mayúscula';
    }
    return null;
  }

  //Validacion requiere un numero
  static String? requiresNumber(String? value) {
    if (value != null && !RegExp(r'[0-9]').hasMatch(value)) {
      return 'Debe contener al menos un número';
    }
    return null;
  }

  //Validacion requiere caracteres especiales
  static String? requiresSpecialChar(String? value) {
    if (value != null && !RegExp(r'[-_+=(){}%!@#\$&*~]').hasMatch(value)) {
      return 'Debe contener al menos un carácter especial';
    }
    return null;
  }

  //combina múltiples validaciones en una sola función de validator para el TextFormField
  static String? Function(String?) combine(
      List<String? Function(String?)> validators) {
    return (String? value) {
      for (var validator in validators) {
        final result = validator(value);
        if (result != null) return result;
      }
      return null;
    };
  }
}
