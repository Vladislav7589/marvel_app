
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants.dart';
import '../utils/color_provider.dart';
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
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        color: backgroundColor,
        child: SafeArea(
          child: ChangeNotifierProvider(
            create: (context) => ColorProvider(),
              child: Consumer<ColorProvider>(
              builder: (context,state,child){
                return CustomPaint(
                  painter: DrawTriangle(color: state.color),
                  child: Column(
                    children: [
                       Padding(
                         padding: const EdgeInsets.all(8.0),
                         child: Image.asset(
                            "assets/marvel.png",
                            width: MediaQuery.of(context).size.width * 0.5,
                          ),
                       ),
                       Container(
                         width: MediaQuery.of(context).size.width * 0.7,
                          margin:  EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.width * 0.05),
                          child: const FittedBox(
                              alignment: Alignment.topCenter,
                              child:  Text(
                                "Choose your hero",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),

                              )),
                        ),
                      //const Expanded(child: SizedBox()),
                     Expanded(
                         child: //CarouselCustom()    - кастомная реализация через CarouselSlider
                                   PageViewSlider() // - реализация с помощью PageView
                      ),
                       SizedBox(height: MediaQuery.of(context).size.width * 0.05,)
                    ],
                  ),
            );
          },
        )
    ),
        ),
      ),
    );
  }

}
