

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
  final DioProvider dioClient = DioProvider();
@override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
        create: (context) => ColorProvider(),),
        /*ChangeNotifierProvider(
          create: (context) => DioClient(),),
         */
        FutureProvider<List<int>?>(
          create: (context) => DioProvider().getHeroes(), initialData: null,
        ),

      ],
      child: Builder(
        builder: (context) {
          var heroes = Provider.of<List<int>?>(context);
          return Scaffold(
            body: Container(
              width: MediaQuery.of(context).size.width,
              color: backgroundColor,
              child: SafeArea(
                child:  Consumer<ColorProvider>(
                    builder: (context,colorState,child){
                      return CustomPaint(
                        painter: DrawTriangle(color: colorState.color),
                        child: Column(
                          children: [
                             Padding(
                               padding: const EdgeInsets.all(8.0),
                               child: Image.asset(
                                  "assets/marvel.png",
                                  width: MediaQuery.of(context).size.width * 0.5,
                                ),
                             ),
                             Padding(
                               padding: const EdgeInsets.all(20),
                               child: Text(
                                        "Choose your hero",
                                        style: TextStyle(fontSize: 30,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),

                                      ),
                             ),
                            //const Expanded(child: SizedBox()),
                           Expanded(
                               child: heroes == null ? Center(child: Container(child: CircularProgressIndicator())):   PageViewSlider( idHeroes: heroes,)// - реализация с помощью PageView
                            ),
                             Padding(
                               padding: const EdgeInsets.symmetric(vertical: 10),
                               child: SizedBox(),
                             )
                          ],
                        ),
                  );
                },
              )

              ),
            ),
          );
        }
      ),
    );
  }

}

