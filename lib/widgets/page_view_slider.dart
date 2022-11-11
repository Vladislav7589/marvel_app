

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marvel_app/screens/home_page.dart';
import 'package:marvel_app/widgets/shimmer.dart';
import '../constants.dart';
import '../database/database.dart';
import '../models/hero_marvel.dart';
import '../providers/color_provider.dart';
import '../providers/dio_provider.dart';
import '../providers/providers.dart';
import '../widgets/hero_card.dart';


class PageViewSlider extends ConsumerStatefulWidget {
  final List<int>? idHeroes;

  const PageViewSlider({super.key, required this.idHeroes});

  @override
  ConsumerState<PageViewSlider> createState() => _PageViewSliderState();
}

class _PageViewSliderState extends ConsumerState<PageViewSlider> {
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
    final fetchAllHeroesInfo = FutureProvider<List<HeroMarvel>?>((ref) async {
      return ref.watch(dio).getAllHeroesInfo(
          widget.idHeroes,
          ref.watch(colorProvider),
          ref.watch(database));
    });
    if(widget.idHeroes != null) {
      return  ref.watch(fetchAllHeroesInfo).when(
          data: (data){
            return PageView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: data!.length,
                controller: pageController,
                onPageChanged: (page) {
                  setState(() {
                    //ref.read(colorProvider).changeColor(heroes[page].color);
                  });
                },
                itemBuilder: (context, pagePosition) {
                  return pageViewAnimation( pagePosition, hero: data[pagePosition]);
                });
          },
          error: (error, stack) {
          return Text(
          "Перезапустите приложение или попробуйте снова");
          },
          loading:() => Container(child: Center(child: pageViewShimmer())));
   } else {
        return ref.watch(DBData).when(
            data: (data){
              return PageView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: data.length,
                  controller: pageController,
                  onPageChanged: (page) {
                    setState(() {
                      //ref.read(colorProvider).changeColor(heroes[page].color);
                    });
                  },
                  itemBuilder: (context, pagePosition) {
                    return pageViewAnimation( pagePosition, heroDB: data[pagePosition]);
                  });
            },
            error: (error, stack) {
              return Text(
                  "Перезапустите приложение или попробуйте снова");
            },
            loading:() => Container(child: Center(child: pageViewShimmer())));
    }
  }

  // маштабирование страниц
  Widget pageViewAnimation(int position,{ HeroMarvel? hero, MarvelHeroData? heroDB}) {
    Matrix4 matrix = Matrix4.identity();
    double currentScale;
    currentScale = scaleFactor;
    if (position == currentPageValue.floor()) currentScale = 1 - (currentPageValue - position) * (1 - scaleFactor);
    if (position == currentPageValue.floor() + 1) currentScale = scaleFactor + (currentPageValue - position + 1) * (1 - scaleFactor);
    if (position == currentPageValue.floor() - 1) currentScale = 1 - (currentPageValue - position) * (1 - scaleFactor);

    matrix = Matrix4.diagonal3Values(currentScale, currentScale, 1.0);
    return Transform(
        alignment: Alignment.center,
        transform: matrix,
        child: HeroCard(pagePosition: position, hero: hero, heroDB: heroDB));
  }


  Widget pageViewShimmer(){
    Matrix4 matrix2 = Matrix4.identity();
    return PageView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 2,
        controller: pageController,
        itemBuilder: (context, pagePosition) {
          double currentScale;
          currentScale = scaleFactor;
          if (pagePosition == currentPageValue.floor()) currentScale = 1 - (currentPageValue - pagePosition) * (1 - scaleFactor);
          if (pagePosition == currentPageValue.floor() + 1) currentScale = scaleFactor + (currentPageValue - pagePosition + 1) * (1 - scaleFactor);

          matrix2 = Matrix4.diagonal3Values(currentScale, currentScale, 1.0);
          return Transform(
              alignment: Alignment.center,
              transform: matrix2,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: const ShimmerWidget()));
        });
  }
}
