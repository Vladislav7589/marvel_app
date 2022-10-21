
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';
import '../constants.dart';
import '../utils/colorProvider.dart';
import 'heroCard.dart';


class CarouselCustom extends StatefulWidget {
  const CarouselCustom({super.key});

  @override
  State<CarouselCustom> createState() => CarouselCustomState();
}

class CarouselCustomState extends State<CarouselCustom> {

  @override
  Widget build(BuildContext context) {
    ColorProvider state = Provider.of<ColorProvider>(context);
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
                  state.changeColor();
                });
              },
            ),
            itemCount: heroes.length,
            itemBuilder: (BuildContext context, int pagePosition,
                int realIndex) {
              return HeroCard(pagePosition: pagePosition,);
            },

          );

  }
}
