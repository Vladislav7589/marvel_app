import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants.dart';
import '../utils/colorProvider.dart';
import '../widgets/heroCard.dart';

class PageViewSlider extends StatefulWidget {
  const PageViewSlider({super.key});

  @override
  State<PageViewSlider> createState() => _PageViewSliderState();
}

class _PageViewSliderState extends State<PageViewSlider> {
  PageController pageController = PageController(viewportFraction: 0.80);

  // значение текущей страницы
  double currentPageValue = 0.0;

  @override
  void initState() {
    super.initState();
    //слушатель изменения страницы
    pageController.addListener(() {
      setState(() {
        currentPageValue = pageController.page!;
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
    ColorProvider state = Provider.of<ColorProvider>(context);
    return PageView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: heroes.length,
        controller: pageController,
        onPageChanged: (page) {
          setState(() {
            state.changeColor();
          });
        },
        itemBuilder: (context, pagePosition) =>
            pageViewAnimation(pagePosition));
  }

  // маштабирование страниц
  Widget pageViewAnimation(int position) {
    Matrix4 matrix = Matrix4.identity();
    double currentScale;

    if (position == currentPageValue.floor()) {
      currentScale = 1 - (currentPageValue - position) * (1 - scaleFactor);
    } else if (position == currentPageValue.floor() + 1) {
      currentScale =
          scaleFactor + (currentPageValue - position + 1) * (1 - scaleFactor);
    } else if (position == currentPageValue.floor() - 1) {
      currentScale = 1 - (currentPageValue - position) * (1 - scaleFactor);
    } else {
      currentScale = scaleFactor;
    }
    matrix = Matrix4.diagonal3Values(currentScale, currentScale, 1.0);
    return Transform(
      alignment: Alignment.center,
      transform: matrix,
      child: HeroCard(pagePosition: position),
    );
  }
}
