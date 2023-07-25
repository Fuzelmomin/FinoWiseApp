import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';


class ButtonLoaderWidget extends StatelessWidget {

  const ButtonLoaderWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Container(
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
        child: CircularProgressIndicator(
          backgroundColor: Colors.white,
          color: Colors.black12,
        )
      ),
    );
  }
}