part of 'app_theme.dart';

TextTheme _buildTextTheme(TextTheme base, Color textColor) {
  return base.copyWith(
    
    bodyMedium: GoogleFonts.lato(
      textStyle: TextStyle(
        color: textColor,
        fontSize: 14,
      ),
    ),
    bodyLarge: GoogleFonts.lato(
      textStyle: TextStyle(
        color: textColor,
        fontSize: 16,
      ),
    ),

    bodySmall: GoogleFonts.lato(
      textStyle: TextStyle(
        color: textColor,
        fontSize: 12,
      ),
    ),
  
  );
}