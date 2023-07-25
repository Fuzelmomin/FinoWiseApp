import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../constants/app_constants.dart';

class AppStyles {

  static const appColor = Color(0xff00C8BC);
  static const grey800Color = Color(0xff1E293B);
  static const borderColor = Color(0xff686868);
  static const orangeColor = Color(0xffC86C00);

  static Color whiteOpacityColor = const Color(0xffffffff).withOpacity(0.5);
  static Color blackOpacityColor = const Color(0xff171717).withOpacity(0.5);
  static Color orangeOpacityColor = const Color(0xffC86C00).withOpacity(0.10);
  static Color appOpacityColor = const Color(0xff00C8BC).withOpacity(0.5);


  static TextStyle poppinsRegular =
  TextStyle(color: blackOpacityColor, fontSize: 13.sp, fontWeight: FontWeight.w300, fontFamily: 'Poppins_Regular');

  static TextStyle interRegular =
  TextStyle(color: Colors.black, fontSize: 13.sp, fontWeight: FontWeight.w300, fontFamily: 'Inter_Regular');
}
