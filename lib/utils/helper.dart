import 'package:flutter/material.dart';

class Helper {
  static const String app_name = 'Awesome Clock';
  static const String app_version = 'version 1.0.0';
  static const int app_v_code = 1;
  static const String font = 'CodaCaption';

  static const Color secondry_text_color = Color(0xFFEBC25C); // #EBC25C
  static const Color primary_text_color = Color(0xFF252525); // #252525
  static const Color dark_bg_color = Color(0xFFF9F2B7); //  #F9F2B7
  static const Color light_bg_color = Color(0xFF252525); // #0f1620

  static TextStyle awesometextStyle(colors, size) => TextStyle(
        color: colors[_Element.text],
        fontFamily: font,
        fontSize: size,
      );

  static final lightTheme = {
    _Element.background: primary_text_color,
    _Element.text: secondry_text_color,
  };

  static final darkTheme = {
    _Element.background: secondry_text_color,
    _Element.text: primary_text_color,
  };

  static final selected_bg_color = _Element.background;
  static final selected_text_color = _Element.text;
}

enum _Element {
  background,
  text,
  qoutes,
}
