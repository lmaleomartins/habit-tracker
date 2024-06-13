import 'package:flutter/material.dart';
import 'dark_mode.dart';
import 'light_mode.dart';

class ThemeProvider extends ChangeNotifier {
  // Inicialmente, tema claro
  ThemeData _themeData = lightMode;

  // Pegar o tema atual
  ThemeData get themeData => _themeData;

  // Já está no tema escuro
  bool get isDarkMode => _themeData == darkMode;

  // definir o tema
  set themeData(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }

  // mudar o tema
  void toggleTheme() {
    if (_themeData == lightMode) {
      themeData = darkMode;
    } else {
      themeData = lightMode;
    }
  }
}
