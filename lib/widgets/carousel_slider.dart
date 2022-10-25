
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../constants.dart';

class CarouselCustom extends StatefulWidget {
  final List<int> idHeroes;
  const CarouselCustom({super.key, required this.idHeroes});

  @override
  State<CarouselCustom> createState() => CarouselCustomState();
}

class CarouselCustomState extends State<CarouselCustom> {

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    //ColorProvider colorState = Provider.of<ColorProvider>(context);
    return   CarouselSlider.builder(
            options: CarouselOptions(
              viewportFraction: 0.85,
              height: double.infinity,
              initialPage: 0,
              scrollPhysics:  const BouncingScrollPhysics(),
              enlargeStrategy: CenterPageEnlargeStrategy.scale,
              enableInfiniteScroll: false,
              enlargeCenterPage: true,
              scrollDirection: Axis.horizontal,
              onPageChanged: (index, reason) {
                setState(() {

                  //colorState.changeColor();
                });
              },
            ),
            itemCount: heroes.length,
            itemBuilder: (BuildContext context, int pagePosition,
                int realIndex) {
              return SizedBox();//HeroCard(pagePosition: pagePosition,hero: ,);
            },

          );

  }
}
