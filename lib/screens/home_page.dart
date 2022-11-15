import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import '../constants.dart';
import '../providers/color_provider.dart';
import '../providers/dio_provider.dart';
import '../utils/draw_triangle.dart';
import '../widgets/page_view_slider.dart';
import '../widgets/error_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class HomePage  extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late bool result = true;
  @override
  void initState() {
    checkInternetConnection();
    super.initState();
  }
  Future<void> checkInternetConnection() async => result = await InternetConnectionChecker().hasConnection;

  @override
  Widget build(BuildContext context) {
    return   Scaffold(
          body: Container(
            width: MediaQuery.of(context).size.width,
            color: backgroundColor,
            child: SafeArea(child:
            Stack(
                children: [
                  Consumer(
                    builder: (_, WidgetRef ref, __) {
                      return CustomPaint(
                          painter: DrawTriangle(color:  ref.watch(colorProvider)),
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
                          result?"Choose your hero": "No internet",
                          style: const TextStyle(
                            fontSize: 30,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Expanded(
                          child:
                          Consumer(
                            builder: (_, WidgetRef ref, __) {
                              return  ref.watch(fetchAllHeroesInfo(ref)).when(
                                  data: (data) => PageViewSlider(heroes: data),
                                  error: (error, stack) => NetworkErrorWidget(text: "load data"),
                                  loading:() => const Center(child: CircularProgressIndicator(color: Colors.red,))
                              );
                            },
                          ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: SizedBox(),
                      )
                    ],
                  ),

                ]
            )
            )
          ),
        );

  }
}
