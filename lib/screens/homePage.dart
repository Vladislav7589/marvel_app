
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants.dart';
import '../utils/colorProvider.dart';
import '../utils/drawTriangle.dart';
import '../widgets/carouselSlider.dart';
import '../widgets/pageViewSlider.dart';



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
                      Expanded(
                        flex: 2,
                        child: Image.asset(
                          "assets/marvel.png",
                          width: MediaQuery.of(context).size.width * 0.4,
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Padding(
                          padding:  EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.2),
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
                      ),
                      //const Expanded(child: SizedBox()),
                     Expanded(flex: 12,
                          child: CarouselCustom()
                                  //PageViewSlider()
                      ),
                      const Expanded(
                          flex: 1,
                          child: SizedBox())
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

