import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../constants/image_asset_path.dart';
import '../utils/app_styles.dart';


class AppButtonWidget extends StatelessWidget {
  final String text1;
  final Function() press1;

  const AppButtonWidget({
    Key? key,
    required this.text1,
    required this.press1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return InkWell(
      onTap: () {
        press1();
      },
      child: Container(
        height: 40.sp,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Color(0xff00C8BC),
                Color(0xff03988F),
              ],
            )
        ),


        child: Center(
          child: Text(
              text1,
              style: AppStyles.poppinsRegular.copyWith(
                  color: Colors.white,
                fontSize: 15.sp,
                fontWeight: FontWeight.w600
              )
          ),
        ),
      ),
    );
  }
}