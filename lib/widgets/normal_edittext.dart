import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../utils/app_styles.dart';

class NormalTextFieldWidget extends StatelessWidget {
  final TextEditingController? controller;
  final String hint;
  Function(String)? onChanged;
  Function()? search;

   NormalTextFieldWidget({
    this.controller,
    required this.hint,
    this.onChanged,
     this.search,
    Key? key,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius:
        BorderRadius.circular(9),
        border: Border.all(
          width: 1,
          color: AppStyles.blackOpacityColor,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: controller,
            obscureText: false,
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
            style: AppStyles.poppinsRegular.copyWith(
                color: AppStyles.blackOpacityColor,
                fontSize: 15.sp),
            onChanged: (val){
              if(onChanged != null){
                onChanged!(val);
              }
            },
            decoration: InputDecoration(
              suffixIcon: InkWell(
                onTap: (){
                  search!();
                },
                child: Icon(controller!.text.isEmpty ? Icons.search : Icons.close, size: 20.0,),
              ),
              contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
              fillColor: Colors.transparent,
              hintText: hint,

              hintStyle: AppStyles.poppinsRegular.copyWith(
                  color: Colors.grey,),
              focusedErrorBorder:
              InputBorder.none,
              focusedBorder:
              InputBorder.none,
              enabledBorder:
              InputBorder.none,
              errorBorder:
              InputBorder.none,
              border:
              InputBorder.none,
              disabledBorder:
              InputBorder.none,
            ),
          ),
        ],
      ),
    );
  }
}