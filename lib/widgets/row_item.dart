import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../utils/app_styles.dart';

class RowItemWidget extends StatelessWidget {

  String? title;
  String? value;

  RowItemWidget({

    this.title,
    this.value,
    Key? key,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title ??'', style: AppStyles.interRegular.copyWith(color: Color(0xff888888), fontSize: 11.sp, fontWeight: FontWeight.w400),),
        SizedBox(height: 0.1.h,),
        Text(value ??'', style: AppStyles.interRegular.copyWith(color: Colors.black, fontSize: 13.sp, fontWeight: FontWeight.w500),),
      ],
    );
  }
}