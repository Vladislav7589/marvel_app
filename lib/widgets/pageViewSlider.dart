

import 'package:flutter/material.dart';
import '../constants.dart';
import '../widgets/heroCard.dart';

class PageViewSlider extends StatefulWidget {
  const PageViewSlider({super.key});

  @override
  State<PageViewSlider> createState() => _PageViewSliderState();
}

class _PageViewSliderState extends State<PageViewSlider> {

  PageController pageController = PageController(viewportFraction: 0.80);
  late int activePage;
  double currPageValue = 0.0;

  @override
  void initState() {
    super.initState();
    activePage = 0;
    pageController.addListener(() {
      setState(() {
        currPageValue = pageController.page!;
      });
    });
  }

  @override
  dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: map.length,
          controller: pageController,
          onPageChanged: (page) {
            setState(() {
              activePage = page;
            });
          },
          itemBuilder: (context, pagePosition) => pageViewAnimation(pagePosition));
        }
  Widget pageViewAnimation(int position) {
    Matrix4 matrix = Matrix4.identity();
    double currentScale;

    if (position == currPageValue.floor()) {
      currentScale = 1 - (currPageValue - position) * (1 - scaleFactor);
    } else if (position == currPageValue.floor() + 1) {
      currentScale = scaleFactor + (currPageValue - position + 1) * (1 - scaleFactor);
    } else if (position == currPageValue.floor() - 1) {
      currentScale = 1 - (currPageValue - position) * (1 - scaleFactor);
    } else {
      currentScale = scaleFactor;
    }
    matrix = Matrix4.diagonal3Values(currentScale, currentScale, 1.0);
    return Transform(
      transformHitTests : true,
      alignment: Alignment.center,
      transform: matrix,
      child: HeroCard(pagePosition: position),
    );
  }

}
