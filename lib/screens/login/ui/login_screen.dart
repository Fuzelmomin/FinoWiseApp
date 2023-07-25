import 'package:fino_wise/utils/alert_utils.dart';
import 'package:fino_wise/utils/app_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import '../../../constants/app_constants.dart';
import '../../../constants/app_screens.dart';
import '../../../constants/image_asset_path.dart';
import '../../../utils/StreamUtils.dart';
import '../../../utils/app_styles.dart';
import '../../../widgets/app_button.dart';
import '../../../widgets/button_loader.dart';
import '../../../widgets/mobile_textfield.dart';
import '../bloc/login_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  static Widget create() {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginBloc>(
          create: (_) => LoginBloc(),
        ),

      ],
      child: LoginScreen(),
    );
  }

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController controllerMobile = TextEditingController();
  SharedPreferences? prefs;
  String? token;

  @override
  void initState() {
    initValue();
    super.initState();
  }

  Future initValue() async {
    prefs = await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<LoginBloc, LoginState>(
        listener: (context, state) {
          if(state.isCompleted){

            prefs!.setString(AppConstants.token, state.loginModel!.data!.token ?? '');
            Navigator.pushNamed(
              context,
              AppScreens.treads,
            );
          }else if(state.isFailed){
            print('');
            AlertUtils.showToast(state.errorMsg ?? 'Please try again!');
          }

        },
        builder: (context, state) {
          return Container(
            width: double.maxFinite,
            height: double.maxFinite,
            decoration: BoxDecoration(
              color: AppStyles.appColor,
              image: DecorationImage(
                image: AssetImage(ImageAssetPath.icBackground),
                fit: BoxFit.cover,
              ),
            ),



            child: Column(
              children: [
                Expanded(
                  flex: 3,
                  child: Container(
                    child: Center(
                      child: Image.asset(ImageAssetPath.icFinoWise),
                    ),
                  ),
                ),

                Expanded(
                  flex: 5,
                  child: Container(
                    decoration:
                    BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                      BorderRadius
                          .only(
                        topLeft: Radius
                            .circular(
                            30),
                        topRight: Radius
                            .circular(
                            30),
                      ),
                    ),
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            SizedBox(height: 5.h,),
                            Text(
                              'Mobile Number',
                              style: AppStyles.poppinsRegular.copyWith(fontWeight: FontWeight.w500),
                            ),
                            SizedBox(height: 2.h,),
                            MobileTextFieldWidget(
                              controller: controllerMobile,
                              hint: 'Enter Phone Number',
                            ),
                            SizedBox(height: 3.h,),
                            state.isLoading ? ButtonLoaderWidget() : AppButtonWidget(
                              text1: 'Log In',
                              press1: (){
                                validationCheck();

                              },
                            ),

                            SizedBox(height: 5.h,),
                            Padding(
                              padding: const EdgeInsets.all(15.0).copyWith(left: 25.0, right: 25.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    flex: 3,
                                    child: Container(
                                      color: AppStyles.borderColor,
                                      height: 1.0,
                                      width: double.infinity,
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Center(
                                      child: Text(
                                        'With',
                                        style:
                                        AppStyles.poppinsRegular.copyWith(fontSize: 14.sp),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: Container(
                                      color: AppStyles.borderColor,
                                      height: 1.0,
                                      width: double.infinity,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 5.h,),

                            InkWell(
                              onTap: () {
                                //press1();
                              },
                              child: Container(
                                height: 40.sp,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  color: Color(0xffDC4E41)
                                ),

                                child: Stack(

                                  children: [

                                    Positioned(

                                      child: Padding(
                                        padding: EdgeInsets.only(left: 15.0),
                                        child: Image.asset(ImageAssetPath.icGoogle, height: 25.0, width: 25.0,),
                                      ),
                                      left: 0,
                                      top: 15,
                                    ),

                                    Center(
                                      child: Text(
                                          'Google',
                                          style: AppStyles.poppinsRegular.copyWith(
                                              color: Colors.white,
                                              fontSize: 15.sp,
                                              fontWeight: FontWeight.w600
                                          )
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )


                          ],
                        ),
                      ),
                    ),
                  )
                )
              ],
            ),
          );
        },
      ),
    );
  }

  Future validationCheck() async{
    if(controllerMobile.text.isEmpty){
      AlertUtils.showToast('Please enter your phone number');
    }else if(controllerMobile.text.length < 10){
      AlertUtils.showToast('Please enter valid phone number');
    }else {
      bool isInternet = await AppUtils.checkInternet();
      if(isInternet){
        loginAPICall();
      }else {
        AlertUtils.showToast('Please check your internet connectivity');
      }
    }
  }

  Future loginAPICall() async{

    String countryCode = '';

    SelectCountry selectCountry = StreamUtils.selectedCountrySubject.value;
    countryCode = selectCountry.countryCode;

    var data = {
      "country_code":countryCode,
      "mobile": controllerMobile.text,
      "otp": '6729',
      "device_id": '123444',
      "device_type": 'android'
    };
    print('Request_SendData $data');
    BlocProvider.of<LoginBloc>(context).add(
      PerformLoginEvent(data: data),
    );
  }
}