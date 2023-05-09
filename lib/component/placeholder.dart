
import 'package:flutter/cupertino.dart';

class ImagePlaceHolder extends StatelessWidget {
  static String defaultPath = 'images/pixabay_logo_square.png';
  
  const ImagePlaceHolder({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(defaultPath);
  }
}