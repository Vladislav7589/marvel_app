
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../constants.dart';
import 'heroCard.dart';


class CarouselCustom extends StatefulWidget {
  const CarouselCustom({super.key});

  @override
  State<CarouselCustom> createState() => CarouselCustomState();
}

class CarouselCustomState extends State<CarouselCustom> {
  late int activePage;
  double currPageValue = 0.0;


  @override
  void initState() {
    super.initState();
    activePage = 0;
  }

  @override
  Widget build(BuildContext context) {
    return  CarouselSlider.builder(
            options: CarouselOptions(
              viewportFraction: 0.85,
              height: double.infinity,
              initialPage: 0,
              enlargeStrategy: CenterPageEnlargeStrategy.scale,
              enableInfiniteScroll: false,
              enlargeCenterPage: true,
              scrollDirection: Axis.horizontal,
              onPageChanged: (index, reason) {
                setState(() {
                  activePage = index;
                });
              },
            ),
            itemCount: map.length,
            itemBuilder: (BuildContext context, int pagePosition,
                int realIndex) {
              return HeroCard(pagePosition: pagePosition,);
            },

          );

  }
}
