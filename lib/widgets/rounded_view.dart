import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../utils/StreamUtils.dart';
import '../utils/app_styles.dart';


class RoundedViewWidget extends StatelessWidget {
  final String text1;
  final String text2;
  final Function() press1;
  final Function() press2;

  const RoundedViewWidget({
    Key? key,
    required this.text1,
    required this.text2,
    required this.press1,
    required this.press2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return StreamBuilder<int>(
      stream: StreamUtils.selectedPageSubject,
      builder: (context, snapshot) {
        return Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              side: const BorderSide(width: 1, color: Colors.white)),
          color: Colors.white,
          child: Container(
            height: 6.h,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Padding(
                    padding:
                    EdgeInsets.fromLTRB(5.0, 4.0, 0.0, 4.0),
                    child: GestureDetector(
                      onTap: () {
                        press1();
                      },
                      child: Container(
                        decoration: snapshot.data == 0 ? BoxDecoration(
                            borderRadius:  BorderRadius.circular(20.0),
                            gradient: LinearGradient(
                              begin: Alignment.topRight,
                              end: Alignment.bottomLeft,
                              colors: [
                                Color(0xff00C8BC),
                                Color(0xff03988F),
                              ],
                            )
                        ) : BoxDecoration(
                          color: Colors.transparent
                        ),
                        child: Center(
                          child: Text(
                            text1,
                            style: AppStyles.poppinsRegular.copyWith(
                                fontWeight: FontWeight.w600,
                                fontSize: 11.sp,
                                color: snapshot.data == 0 ? Colors.white : Colors.black
                            )
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding:
                    EdgeInsets.fromLTRB(0.0, 4.0, 4.0, 5.0),
                    child: GestureDetector(
                      onTap: () {

                        press2();

                      },
                      child: Container(
                        decoration: snapshot.data == 1 ? BoxDecoration(
                            borderRadius:  BorderRadius.circular(20.0),
                            gradient: LinearGradient(
                              begin: Alignment.topRight,
                              end: Alignment.bottomLeft,
                              colors: [
                                Color(0xff00C8BC),
                                Color(0xff03988F),
                              ],
                            )
                        ) : BoxDecoration(
                            color: Colors.transparent
                        ),
                        child: Center(
                          child: Text(
                            text2,
                            style: AppStyles.poppinsRegular.copyWith(
                              fontWeight: FontWeight.w600,
                              fontSize: 11.sp,
                              color: snapshot.data == 1 ? Colors.white : Colors.black
                            )
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }
    );
  }
}