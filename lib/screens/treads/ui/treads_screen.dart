import 'dart:async';

import 'package:fino_wise/screens/treads/bloc/treads_bloc.dart';
import 'package:fino_wise/utils/alert_utils.dart';
import 'package:fino_wise/utils/app_utils.dart';
import 'package:fino_wise/widgets/custom_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sizer/sizer.dart';

import '../../../utils/StreamUtils.dart';
import '../../../utils/app_styles.dart';
import '../../../widgets/normal_edittext.dart';
import '../../../widgets/rounded_view.dart';
import '../../../widgets/tread_item.dart';
import '../model/treads_model.dart';


class TreadsScreen extends StatefulWidget {
  const TreadsScreen({Key? key}) : super(key: key);

  static Widget create() {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TreadsBloc>(
          create: (_) => TreadsBloc(),
        ),

      ],
      child: TreadsScreen(),
    );
  }

  @override
  _TreadsScreenState createState() => _TreadsScreenState();
}

class _TreadsScreenState extends State<TreadsScreen> {
  TextEditingController controllerSearch = TextEditingController();
  BehaviorSubject<List<Data>> treadsOnGoingList = BehaviorSubject<List<Data>>.seeded([]);
  BehaviorSubject<List<Data>> treadsExpiredList = BehaviorSubject<List<Data>>.seeded([]);
  BehaviorSubject<List<Data>> treadsList = BehaviorSubject<List<Data>>.seeded([]);

  final ScrollController _scroll = ScrollController();
  bool isNextPage = true;
  bool isPagination = false;
  int listPageU = 1;
  int pageCount = 3;
  String filters = 'ongoing';


  @override
  void initState() {
    print('ATTEMPTED_API ContributionScreen');
    initValue();
    super.initState();
  }

  Future initValue() async {

    getTreadListAPI(filters, pageCount);

    _scroll.addListener(() async {
      if (_scroll.position.pixels == _scroll.position.maxScrollExtent) {
        print('ListView Scroll Here...... End Position');
        if (isNextPage) {

          if(StreamUtils.selectedPageSubject.value == 0){
            filters = 'ongoing';
            pageCount = pageCount + 2;
            getTreadListAPI(filters, pageCount);
          }else {
            filters = 'expired';
            pageCount = pageCount + 2;
            getTreadListAPI(filters, pageCount);
          }
          isPagination = true;
          setState(() {});

        }
      }
    });

  }

  Future searchData(String text) async{

    treadsList.value.clear();
    List<Data> treadsItems = [];
    if(text.isEmpty){
      print('TreadsData Empty');
      controllerSearch.clear();
      treadsList.value.clear();
      setState(() {});
      return;
    }

    print('SearchData $text');
    if(StreamUtils.selectedPageSubject.value == 0){
      treadsOnGoingList.value.forEach((item) {
        if (item.stock!.contains(text) || item.user!.name!.contains(text))
          treadsItems.add(item);
        treadsList.add(treadsItems);
      });
    }else {
      treadsExpiredList.value.forEach((item) {
        if (item.stock!.contains(text) || item.user!.name!.contains(text))
          treadsItems.add(item);
        treadsList.add(treadsItems);
      });
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Trade Recommendations',
      ),
      body: BlocConsumer<TreadsBloc, TreadsState>(
        listener: (context, state) {
          if(state.isCompleted){
            if(state.treadsModel != null){
              if(isPagination){
                List<Data> list = [];
                for(int i = pageCount-2; i < state.treadsModel!.data!.length; i++){
                  list.add(state.treadsModel!.data![i]);
                }
                if(StreamUtils.selectedPageSubject.value == 0){
                  treadsOnGoingList.value.addAll(list);
                }else {
                  treadsExpiredList.value.addAll(list);
                }
              }else{
                if(StreamUtils.selectedPageSubject.value == 0){
                  treadsOnGoingList.add(state.treadsModel!.data!);
                }else {
                  treadsExpiredList.add(state.treadsModel!.data!);
                }
              }


            }

          }else if(state.isFailed){
            AlertUtils.showToast(state.errorMsg ?? '');
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            controller: _scroll,
            child: Padding(
              padding: EdgeInsets.all(15.0),
              child: Stack(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RoundedViewWidget(
                        press1: () {

                          if(StreamUtils.selectedPageSubject.value != 0){
                            StreamUtils.selectedPageSubject.add(0);
                            filters = 'ongoing';
                            isPagination = false;
                            getTreadListAPI(filters, pageCount);

                          }
                        },
                        text1: 'Ongoing Trades',
                        press2: () {
                          if(StreamUtils.selectedPageSubject.value != 1){
                            StreamUtils.selectedPageSubject.add(1);
                            filters = 'expired';
                            isPagination = false;
                            getTreadListAPI(filters, pageCount);
                          }
                        },
                        text2: 'Expired Trades',
                      ),
                      SizedBox(height: 2.h,),
                      NormalTextFieldWidget(
                        hint: 'Search by stock or mentor name',
                        controller: controllerSearch,
                        onChanged: (value) {
                          searchData(value);
                        },
                      ),
                      StreamBuilder<List<Data>>(
                          stream: treadsList,
                          builder: (context, snapshot) {
                            return controllerSearch.text.isNotEmpty ? StreamBuilder<List<Data>>(
                                stream: treadsList,
                                builder: (context, snapshot) {
                                  return snapshot.data == null ? noData() :
                                  snapshot.data!.isEmpty ? noData():
                                  Container(
                                    child: ListView.builder(
                                      physics: NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: snapshot.data!.length,
                                      itemBuilder: (context, index) {

                                        Data item =snapshot.data![index];

                                        return TreadItemWidget(
                                          item: item,
                                        );
                                      },
                                    ),
                                  );
                                }
                            ):
                            Container(
                              child: StreamBuilder<int>(
                                  stream: StreamUtils.selectedPageSubject,
                                  builder: (context, snapshot) {
                                    return Container(
                                      child: snapshot.data == 0 ?
                                      StreamBuilder<List<Data>>(
                                          stream: treadsOnGoingList,
                                          builder: (context, snapshot) {
                                            return snapshot.data == null ? noData() :
                                            snapshot.data!.isEmpty ? noData():
                                            Container(
                                              child: ListView.builder(
                                                physics: NeverScrollableScrollPhysics(),
                                                shrinkWrap: true,
                                                itemCount: snapshot.data!.length,
                                                itemBuilder: (context, index) {

                                                  Data item =snapshot.data![index];

                                                  return TreadItemWidget(
                                                    item: item,
                                                  );
                                                },
                                              ),
                                            );
                                          }
                                      ) : Container(
                                        child: StreamBuilder<List<Data>>(
                                            stream: treadsExpiredList,
                                            builder: (context, snapshot) {
                                              return snapshot.data == null ? noData() :
                                              snapshot.data!.isEmpty ? noData():
                                              Container(
                                                child: ListView.builder(
                                                  physics: NeverScrollableScrollPhysics(),
                                                  shrinkWrap: true,
                                                  itemCount: snapshot.data!.length,
                                                  itemBuilder: (context, index) {

                                                    Data item =snapshot.data![index];

                                                    return TreadItemWidget(
                                                      item: item,
                                                    );
                                                  },
                                                ),
                                              );
                                            }
                                        ),
                                      ),
                                    );
                                  }
                              ),
                            );
                          }
                      ),

                    ],
                  ),
                  Positioned(
                    bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        color: Colors.white,
                    height: state.isLoading && isPagination ? 35.0 : 0,
                    child: Center(
                        child: CircularProgressIndicator(
                          backgroundColor: Colors.white,
                          color: Colors.black12,
                        )
                    ),
                  ))
                ],
              ),
            ),
          );
        },
      ),
    );
  }


  Widget noData() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 20.sp,
          ),

          Text(
            'No Data Found',
            style: AppStyles.poppinsRegular.copyWith(color: AppStyles.borderColor, fontSize: 20.sp, fontWeight: FontWeight.w800),
          )
        ],
      ),
    );
  }

  Future getTreadListAPI(String filters, int pageCount) async{

    bool isInternet = await AppUtils.checkInternet();

    if(isInternet){
      var data = {
        "filters": filters,
        "limit": pageCount.toString(),
        "offset": '',
      };
      BlocProvider.of<TreadsBloc>(context).add(PerformTreadsEvent(data: data));
    }else {
      AlertUtils.showToast('Please check your internet connectivity');
    }


  }
}
