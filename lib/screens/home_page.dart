import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import '../constants.dart';
import '../providers/dio_provider.dart';
import '../providers/color_provider.dart';
import '../utils/draw_triangle.dart';
import '../widgets/page_view_slider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ColorProvider(),
        ),
        FutureProvider<List<int>?>(
          create: (context) => DioProvider().getIDHeroes(),
          initialData: null,
        ),
      ],
      child: Builder(builder: (context) {
        var heroes = Provider.of<List<int>?>(context);
        return Scaffold(
          body: Container(
            width: MediaQuery.of(context).size.width,
            color: backgroundColor,
            child: SafeArea(child: Consumer<ColorProvider>(
              builder: (context, colorState, child) {
                return CustomPaint(
                  painter: DrawTriangle(color: colorState.color),
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
                      //const Expanded(child: SizedBox()),
                      Expanded(
                          child: heroes != null
                              ? PageViewSlider(
                                  idHeroes: heroes,
                                )
                              : const Center(
                                  child:
                                      CircularProgressIndicator()) // - реализация с помощью PageView
                          ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: SizedBox(),
                      )
                    ],
                  ),
                );
              },
            )),
          ),
        );
      }),
    );
  }
}
