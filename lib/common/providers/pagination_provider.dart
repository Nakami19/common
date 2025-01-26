import '/common/providers/general_provider.dart';
import 'package:flutter/material.dart';

class PaginationProvider extends GeneralProvider {
  int _total = 0; // Total de elementos
  int _limit = 5; // Límites por página
  int _page = 0;  // Página actual


  int get total => _total;
  int get limit => _limit;
  int get page => _page;


  void setTotal(int value) {
    _total = value;
    notifyListeners();
  }

/// Calcula y redondea el número total de páginas basado en el total de elementos y el límite por página.
  int getNumPages() {
      return (_total / _limit).ceil();
   
    
  }

// Avanza a la siguiente página, si no es la última.
  Future<void> nextPage(BuildContext context) async {
    if (_page + 1 < getNumPages()) {
      _page++;
    }
  }

// Retrocede a la página anterior, si no es la primera.
  Future<void> previousPage(BuildContext context) async {
    if (_page > 0) {
      _page--;
    }
  }

  //Estableciendo la página actual a la primera.
  void resetPagination() {
    _page = 0;
    notifyListeners();
  }

}


