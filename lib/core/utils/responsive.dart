import 'package:flutter/material.dart';

class Responsive {
  static late MediaQueryData _mediaQueryData;
  static late double screenWidth;
  static late double screenHeight;
  static late double blockSizeHorizontal;
  static late double blockSizeVertical;

  static late double _safeAreaHorizontal;
  static late double _safeAreaVertical;
  static late double safeBlockSizeHorizontal;
  static late double safeBlockSizeVertical;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    blockSizeHorizontal = screenWidth / 100;
    blockSizeVertical = screenHeight / 100;

    _safeAreaHorizontal = _mediaQueryData.padding.left + _mediaQueryData.padding.right;
    _safeAreaVertical = _mediaQueryData.padding.top + _mediaQueryData.padding.bottom;
    safeBlockSizeHorizontal = (screenWidth - _safeAreaHorizontal) / 100;
    safeBlockSizeVertical = (screenHeight - _safeAreaVertical) / 100;
  }

  // Helper methods for dynamic sizing
  static double setWidth(double width) => blockSizeHorizontal * (width / 3.75); // based on 375 width
  static double setHeight(double height) => blockSizeVertical * (height / 8.12); // based on 812 height
  static double setSp(double fontSize) => blockSizeHorizontal * (fontSize / 3.75);
}
