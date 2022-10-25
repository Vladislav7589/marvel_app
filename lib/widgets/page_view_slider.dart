import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import '../constants.dart';
import '../models/hero_marvel.dart';
import '../providers/color_provider.dart';
import '../providers/dio_provider.dart';
import '../widgets/hero_card.dart';

class PageViewSlider extends StatefulWidget {
  final List<int> idHeroes;

  const PageViewSlider({super.key, required this.idHeroes});

  @override
  State<PageViewSlider> createState() => _PageViewSliderState();
}

class _PageViewSliderState extends State<PageViewSlider> {
  PageController pageController = PageController(viewportFraction: 0.80);
  int activePage = 0;

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
    ColorProvider colorState = Provider.of<ColorProvider>(context);
    return PageView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: widget.idHeroes.length,
        controller: pageController,
        onPageChanged: (page) {
          setState(() {
            activePage = page;
            colorState.updateColor();
          });
        },
        itemBuilder: (context, pagePosition) =>
            pageViewAnimation(pagePosition));
  }

  // маштабирование страниц
  Widget pageViewAnimation(int position) {
    //ColorProvider colorState = Provider.of<ColorProvider>(context);

    Matrix4 matrix = Matrix4.identity();
    double currentScale;
    currentScale = scaleFactor;
    if (position == currentPageValue.floor()) {
      currentScale = 1 - (currentPageValue - position) * (1 - scaleFactor);
    }
    if (position == currentPageValue.floor() + 1) {
      currentScale =
          scaleFactor + (currentPageValue - position + 1) * (1 - scaleFactor);
    }
    if (position == currentPageValue.floor() - 1) {
      currentScale = 1 - (currentPageValue - position) * (1 - scaleFactor);
    }
    matrix = Matrix4.diagonal3Values(currentScale, currentScale, 1.0);
    return Transform(
        //transformHitTests: true,
        alignment: Alignment.center,
        transform: matrix,
        child: FutureProvider<HeroMarvel?>(
            create: (context) => DioProvider().getHeroInfo(widget.idHeroes[position]),
            initialData: null,
            child: Consumer<HeroMarvel?>(builder: (context, hero, _) {
              /*if( currentPageValue % 10 == 0) {
                colorState.changeColor(hero?.color != null? hero!.color : colorState.color);
              }*/
              return hero != null
                  ? HeroCard(pagePosition: position, hero: hero)
                  : Shimmer.fromColors(
                      baseColor: Colors.transparent,
                      highlightColor: Colors.white10,
                      child: Container(
                        color: backgroundColor,
                      ));
            })));
  }
}
