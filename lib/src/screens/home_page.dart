import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
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
  late bool result = false;

  @override
  void initState() {
    checkInternetConnection();
    super.initState();
  }

  Future<void> checkInternetConnection() async {
    result = await InternetConnectionChecker().hasConnection;
    var snackBar = SnackBar(
      backgroundColor: result?Colors.green: Colors.grey,
      content: result?  Text(LocaleKeys.connectionConnected.tr()): Text(LocaleKeys.connectionNotConnected.tr()),
    );
    scaffoldKey.currentState?.showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          width: MediaQuery.of(context).size.width,
          color: backgroundColor,
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
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(
                        marvelLogo,
                        width: MediaQuery.of(context).size.width * 0.5,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Text(
                        textAlign: TextAlign.center,
                        LocaleKeys.mainText.tr(),
                        style: const TextStyle(
                          fontSize: 30,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Expanded(
                        child:  Consumer(
                          builder: (_, WidgetRef ref, __) {
                            var dB = ref.watch(allDataBase);
                            return ref.watch(fetchAllHeroesInfo).when(
                                data: (data) {
                                return RefreshIndicator(
                                  onRefresh: ()  {
                                    checkInternetConnection();
                                    return ref.refresh(fetchAllHeroesInfo.future);
                                  },
                                  child: (result |  ( dB.value?.length !=null) )? PageViewSlider(heroes: data):ListView(
                                    children: [
                                      Text(
                                        LocaleKeys.connectionNotConnected.tr(),
                                        style: const TextStyle(
                                          fontSize: 30,
                                          color: Colors.blue,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                       Text(
                                        LocaleKeys.connectionSwipeConnection.tr(),
                                        style: const TextStyle(
                                          fontSize: 20,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                );
                          },
                                error: (error, stack) =>
                                NetworkErrorWidget(
                                    text: LocaleKeys.errorsErrorLoadData.tr()),
                                loading: () => const Center(
                                    child: CircularProgressIndicator(
                                      color: Colors.red,
                                    )));

                          },
                        )
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: SizedBox(),
                    )
                  ],
                ),
              ]))),
    );
  }
}