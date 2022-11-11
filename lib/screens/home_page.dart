
import 'package:flutter/material.dart';

import '../constants.dart';
import '../database/database.dart';
import '../providers/dio_provider.dart';
import '../providers/color_provider.dart';
import '../providers/providers.dart';
import '../utils/draw_triangle.dart';
import '../widgets/page_view_slider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class HomePage extends ConsumerWidget {
  const HomePage({super.key});


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return   Scaffold(
          body: Container(
            width: MediaQuery.of(context).size.width,
            color: backgroundColor,
            child: SafeArea(child:
             ref.watch(fetchIdHeroes).when(
                    data: (data) {
                      return CustomPaint(
                          painter: DrawTriangle(color: ref.watch(colorProvider).color),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image.asset(
                                  marvelLogo,
                                  width: MediaQuery.of(context).size.width * 0.5,
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.all(20),
                                child: Text(
                                  "Choose your hero",
                                  style: TextStyle(
                                    fontSize: 30,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                               Expanded(
                                  child: PageViewSlider(
                                    idHeroes: data,
                                  )
                              )
                            ,
                              const Padding(
                                padding: EdgeInsets.symmetric(vertical: 10),
                                child: SizedBox(),
                              )
                            ],
                          ));
                    },
                    error: (error, stack) {
                      return Text(
                          "Перезапустите приложение или попробуйте снова");
                    },
                    loading:() => Container(child: Center(child: CircularProgressIndicator()))
                )
            )
          ),
        );

  }
}
