

import 'package:flutter/material.dart';
import 'package:marvel_app/widgets/shimmer.dart';
import 'package:provider/provider.dart';
import '../constants.dart';
import '../database/database.dart';
import '../models/hero_marvel.dart';
import '../providers/color_provider.dart';
import '../providers/dio_provider.dart';
import '../widgets/hero_card.dart';


class PageViewSlider extends StatefulWidget {
  final List<int>? idHeroes;

  const PageViewSlider({super.key, required this.idHeroes});

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
    ColorProvider colorState = Provider.of<ColorProvider>(context);
    var db = Provider.of<MyDatabase>(context);
    if(widget.idHeroes != null) {

      print(widget.idHeroes);
      return FutureProvider<List<HeroMarvel>?>(
        create: (context) => DioProvider().getAllHeroesInfo(widget.idHeroes!, colorState, db),
        initialData: null,
        child: Consumer<List<HeroMarvel>?>(builder: (context, heroes, _) {
          return heroes != null
              ? PageView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: heroes.length,
              controller: pageController,
              onPageChanged: (page) {
                setState(() {
                  colorState.changeColor((heroes[page].color ?? colorState.color));
                });
              },
              itemBuilder: (context, pagePosition) {
                return pageViewAnimation(pagePosition, hero: heroes[pagePosition]);
              })
              : pageViewShimmer();
        }));
   } else {
    return  FutureBuilder(
      future: db.getAllHeroes(),
      builder: (context, snapshot) {
        List<MarvelHeroData>? heroes = snapshot.data;
        if (heroes == null) {
          return Container(
              child: Center(
                child: CircularProgressIndicator(color: Color(0xDF290505),),
              ));
        } else if (snapshot.hasError) {
          return Center(child: Text(snapshot.error.toString()));
        } else {
          colorState.color = heroes[0].color;
          //colorState.update();
        return PageView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: heroes.length,
            controller: pageController,
            onPageChanged: (page) {
              setState(() {
                colorState.changeColor((heroes[page].color));
              });
            },
            itemBuilder: (context, pagePosition) {
              return pageViewAnimation( pagePosition, heroDB: heroes[pagePosition]);
            });}
      }
    );
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
