import 'package:fino_wise/widgets/row_item.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../screens/treads/model/treads_model.dart';
import '../utils/app_styles.dart';

class TreadItemWidget extends StatelessWidget {

  Data? item;
  TreadItemWidget({
    this.item,
    Key? key,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: const BorderSide(width: 1, color: Colors.white)),
      color: Colors.white,
      child: Column(
        children: [
          Container(
            decoration:
            BoxDecoration(
              color: Color(0xff00C8BC),
              borderRadius:
              BorderRadius
                  .only(
                topLeft: Radius
                    .circular(
                    10),
                topRight: Radius
                    .circular(
                    10),
              ),
            ),
            padding: EdgeInsets.only(left: 13.0, right: 13.0, top: 8.0, bottom: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(item!.name ?? '', style: AppStyles.poppinsRegular.copyWith(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 16.sp),),

                Row(
                  children: [
                    Text(item!.postedDate ?? '', style: AppStyles.interRegular.copyWith(color: Colors.white, fontWeight: FontWeight.w400, fontSize: 12.sp),),
                    SizedBox(width: 10.0,),
                    Icon(Icons.arrow_circle_right_outlined, size: 25.0, color: Colors.white,)
                  ],
                )
              ],
            ),
          ),
          SizedBox(height: 1.h,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  children: [

                    Expanded(
                      flex: 1,
                      child: Container(
                        child: RowItemWidget(title: 'Type:', value: item!.type ?? ''),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        child: RowItemWidget(title: 'Entry:', value: item!.entryPrice.toString()),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        child: RowItemWidget(title: 'Exit:', value: '${item!.exitPrice.toString()} - ${item!.exitHigh.toString()}'),
                      ),
                    ),

                  ],
                ),
                SizedBox(height: 1.h,),
                Row(

                  children: [

                    Expanded(
                      flex: 1,
                      child: Container(
                        child: RowItemWidget(title: 'Stop Loss:', value: item!.stopLossPrice.toString()),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        child: RowItemWidget(title: 'Stock Name:', value: item!.stock ?? ''),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        child: RowItemWidget(title: 'Action:', value: item!.action ?? ''),
                      ),
                    ),




                  ],
                ),
                SizedBox(height: 1.h,),
                Row(
                  children: [

                    Expanded(
                      flex: 2,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Status:', style: AppStyles.interRegular.copyWith(color: Color(0xff888888), fontSize: 11.sp, fontWeight: FontWeight.w400),),
                          SizedBox(height: 0.1.h,),
                          Container(
                            padding: EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: item!.status == 'Open' ? AppStyles.appOpacityColor : AppStyles.orangeOpacityColor
                            ),
                            child: Text(item!.status ?? '', style: AppStyles.interRegular.copyWith(
                                    color: item!.status == 'Open' ? AppStyles.appColor : AppStyles.orangeColor, fontSize: 11.sp, fontWeight: FontWeight.w300),),
                          )
                        ],
                      ),
                    ),

                    Expanded(
                      flex: 2,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Posted By:', style: AppStyles.interRegular.copyWith(color: Color(0xff888888), fontSize: 11.sp, fontWeight: FontWeight.w400),),
                          SizedBox(height: 0.1.h,),
                          Container(
                            padding: EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: AppStyles.appOpacityColor
                            ),
                            child: Text(item!.user!.name ?? '', style: AppStyles.interRegular.copyWith(color: AppStyles.appColor, fontSize: 11.sp, fontWeight: FontWeight.w300),),
                          )
                        ],
                      ),
                    ),

                    Expanded(flex: 1,child: RowItemWidget(title: '', value: '')),
                  ],
                ),
              ],
            ),
          )

        ],
      ),
    );
  }
}