import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../utils/StreamUtils.dart';
import '../utils/app_styles.dart';

class MobileTextFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final String hint;

  const MobileTextFieldWidget({
    required this.controller,
    required this.hint,
    Key? key,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Container(

      child: StreamBuilder<SelectCountry>(
        stream: StreamUtils.selectedCountrySubject,
        builder: (context, snapshot) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              Flexible(
                flex: 8,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    Align(
                      alignment: Alignment.center,
                      child: InkWell(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(width: 1.w,),
                            Text(
                              snapshot.hasData ? snapshot.data!.flag : '🇮🇳',
                              textScaleFactor: 1.5,
                            ),
                            SizedBox(width: 2.w,),
                            Text(
                              snapshot.hasData ? snapshot.data!.countryName : '(+91)',
                              style: AppStyles.poppinsRegular.copyWith(
                                fontSize: 13.sp,
                              ),
                            ),
                            SizedBox(width: 3.w,),
                            Icon(Icons.arrow_drop_down,
                            size: 15.0,)

                          ],
                        ),
                        onTap: () {
                          showCountryPicker(
                            context: context,
                            favorite: <String>['IN'],
                            showPhoneCode: true,
                            onSelect: (Country country) {
                              String name = ' (+${country.phoneCode})';
                              String countryCode = '+${country.phoneCode}';
                              SelectCountry selectCountry = SelectCountry(
                                  country.flagEmoji, name, countryCode);
                              StreamUtils.selectedCountrySubject.add(selectCountry);
                            },
                            // Optional. Sets the theme for the country list picker.
                            countryListTheme: CountryListThemeData(
                              flagSize: 30.0,
                              bottomSheetHeight:550,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(40.0),
                                topRight: Radius.circular(40.0),
                              ),
                              // Optional. Styles the search field.
                              inputDecoration: InputDecoration(
                                labelText: 'Search',
                                hintText: 'Start typing to search',
                                prefixIcon: const Icon(Icons.search),
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: const Color(0xFF8C98A8).withOpacity(0.2),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Divider(
                      color: Color(0xffC4C4C4),
                      thickness: 1.0,
                    )
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(),
              ),
              Expanded(
                flex: 12,
                child: Column(
                  children: [
                    TextField(
                      controller: controller,
                      keyboardType: TextInputType.phone,
                      maxLength: 10,
                      textInputAction: TextInputAction.next,
                      style: AppStyles.poppinsRegular.copyWith(
                          fontSize: 15.sp),
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.symmetric(vertical: 7.0, horizontal: 10.0),
                        counterText: "",
                        fillColor: Colors.transparent,
                        hintText: hint,
                        hintStyle: AppStyles.poppinsRegular.copyWith(
                          color: Colors.grey,),
                        focusedErrorBorder:
                        InputBorder.none,
                        focusedBorder:
          UnderlineInputBorder( //<-- SEE HERE
          borderSide: BorderSide(
          width: 1, color: Color(0xffC4C4C4)),
          ),
                        enabledBorder:
                        UnderlineInputBorder( //<-- SEE HERE
                          borderSide: BorderSide(
                              width: 1, color: Color(0xffC4C4C4)),
                        ),
                        errorBorder:
                        InputBorder.none,
                        border:
                        InputBorder.none,
                        disabledBorder:
                        InputBorder.none,
                      ),
                    ),
                    Divider(
                      color: Colors.white,
                      thickness: 1.0,
                    )
                  ],
                ),
              )
            ],
          );
        }
      ),
    );
  }
}