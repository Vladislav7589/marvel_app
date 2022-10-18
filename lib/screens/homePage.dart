
import 'package:flutter/material.dart';
import '../constants.dart';
import '../widgets/carouselSlider.dart';


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
                    padding:  EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.15),
                    child: const FittedBox(
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
                const Expanded(flex: 12, child: Carousel()),
                const Expanded(
                    flex: 1,
                    child: SizedBox())
              ],
            )
        ),
      ),
    );
  }

}

