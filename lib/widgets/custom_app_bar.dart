import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../constants/image_asset_path.dart';
import '../utils/app_styles.dart';


class CustomAppBar extends StatelessWidget implements PreferredSizeWidget{

  final String title;


  const CustomAppBar({
    required this.title,

    Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      elevation: 0,
      backgroundColor: Color(0xff00C8BC),
      titleSpacing: 0,
      centerTitle: true,
      shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(15),
              ),
            ),
      title: Text(
        title,
        style: AppStyles.poppinsRegular.copyWith(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: Colors.white
        ),
      ),
      actions: [
        InkWell(
            child: Image.asset(
              ImageAssetPath.icFilter,
              width: 35.sp,
              height: 35.sp,
            ),
            onTap: () {

            })
      ],

    );
  }
}

