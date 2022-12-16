import 'dart:async';
import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:marvel_app/translations/locale_keys.g.dart';


import '../../constants.dart';
import '../../main.dart';
import '../providers/color_provider.dart';
import '../providers/database_provider.dart';
import '../providers/dio_provider.dart';
import '../utils/draw_triangle.dart';
import '../widgets/page_view_slider.dart';
import '../widgets/error_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late bool isInternet = false;
  ConnectivityResult connectionStatus = ConnectivityResult.none;
  final Connectivity connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> connectivitySubscription;

  @override
  void initState() {
    connectivitySubscription = connectivity.onConnectivityChanged.listen(updateConnectionStatus);
    super.initState();
  }
  @override
  void dispose() {
    connectivitySubscription.cancel();
    super.dispose();
  }

  Future<void> initConnectivity() async {
    late ConnectivityResult result;
    try {
      result = await connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      log('Couldn\'t check connectivity status', error: e);
      return;
    }
    if (!mounted) {
      return Future.value(null);
    }

    return updateConnectionStatus(result);
  }
  Future<void> updateConnectionStatus(ConnectivityResult result) async {
    setState(() {
      connectionStatus = result;
      switch(result){
        case ConnectivityResult.wifi:
          isInternet = true;
          break;
        case ConnectivityResult.ethernet:
          isInternet = true;
          break;
        case ConnectivityResult.mobile:
          isInternet = true;
          break;
        case ConnectivityResult.none:
          isInternet = false;
          break;
        default: break;
      }
      var snackBar = SnackBar(
        duration: const Duration(seconds: 5),
        backgroundColor: isInternet?Colors.green: Colors.grey,
        content: isInternet?  Text(LocaleKeys.connectionConnected.tr(), style: const TextStyle(fontWeight: FontWeight.bold),): Text(LocaleKeys.connectionNotConnected.tr()),
      );
      scaffoldKey.currentState?.showSnackBar(snackBar);

    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: SafeArea(
              child: Stack(children: [
                Consumer(
                  builder: (_, WidgetRef ref, __) {
                    return CustomPaint(
                        painter: DrawTriangle(color: ref.watch(colorProvider)),
                        child: Container());
                  },
                ),
                Column(
                  children: [
                    Visibility(
                      visible: MediaQuery.of(context).orientation == Orientation.portrait,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset(
                          Theme.of(context).brightness ==Brightness.light? marvelLogoDark:marvelLogo,
                          width: MediaQuery.of(context).size.width * 0.5,
                        ),
                      ),
                    ),
                    Visibility(
                      visible: MediaQuery.of(context).orientation == Orientation.portrait,
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Text(
                          textAlign: TextAlign.center,
                          LocaleKeys.mainText.tr(),
                          style: const TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: SizedBox(),
                    ),
                    Expanded(
                        child:  Consumer(
                          builder: (_, WidgetRef ref, __) {
                            var db = ref.watch(allDataBase);
                            return RefreshIndicator(

                              onRefresh: ()  {
                                  return ref.refresh(fetchAllHeroesInfo.future);
                              },
                              child:  ref.watch(fetchAllHeroesInfo).when(
                                  data: (data) {
                                  return PageViewSlider(heroes: data);
                          },
                                  error: (error, stack) => db.value != null? const PageViewSlider(heroes: null):
                                     NetworkErrorWidget(
                                        text: LocaleKeys.errorsErrorLoadData.tr(),
                                  ),

                                  loading: () => const Center(
                                      child: CircularProgressIndicator(
                                        color: Colors.red,
                                      ))),
                            );

                          },
                        )
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).orientation == Orientation.portrait?10:0),
                      child: const SizedBox(),
                    )
                  ],
                ),
              ]))),
    );
  }
}