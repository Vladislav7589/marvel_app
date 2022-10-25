

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:marvel_app/models/hero_marvel.dart';

import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../constants.dart';
import '../screens/hero_details.dart';

import '../providers/color_provider.dart';

class HeroCard extends StatelessWidget {
  final int pagePosition;
  //final int idHero;
  final HeroMarvel? hero;

  const HeroCard({Key? key, required this.pagePosition, required this.hero})
      : super(key: key);

/*  Future<PaletteGenerator?> updatePaletteGenerator(String url) async {
    paletteGenerator = await PaletteGenerator.fromImageProvider(
      Image.network(url).image,
    );
    return paletteGenerator;
  }*/

  @override
  Widget build(BuildContext context) {
    ColorProvider colorState = Provider.of<ColorProvider>(context);

    return Card(
        color: Colors.transparent,
        margin: const EdgeInsets.only(bottom: 20),
        semanticContainer: true,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 10,
        child: hero == null
            ? Center(
            child: Container(
              child: Shimmer.fromColors(
                  baseColor: Colors.transparent,
                  highlightColor: Colors.white10,
                  child: Container(
                    color: backgroundColor,
                  )),
            ))
            : Hero(
          transitionOnUserGestures: true,
          tag: "${hero?.id}",
          child: Material(
            type: MaterialType.transparency, // likely needed
            child: Stack(
              fit: StackFit.expand,
              children: [
                "${hero?.imageUrl}" !=
                    "http://i.annihil.us/u/prod/marvel/i/mg/b/40/image_not_available.jpg"
                    ? Builder(
                    builder: (context) {
                      //colorState.url = "${hero.imageUrl}";
                      return CachedNetworkImage(
                        fit: BoxFit.cover,
                        height: double.infinity,
                        width: double.infinity,
                        imageUrl: "${hero?.imageUrl}",

                        placeholder: (context, url) =>
                            Shimmer.fromColors(
                                baseColor:
                                Colors.transparent,
                                highlightColor:
                                Colors.white10,
                                child: Container(
                                  color: backgroundColor,
                                )),
                        errorWidget:
                            (context, url, error) =>
                            Icon(Icons.error),
                      );
                    }
                )
                    : Image.asset(
                  "assets/no_image.png",
                  fit: BoxFit.contain,
                  height: double.infinity,
                  width: double.infinity,
                ),
                //Text('color: ${snapshot.data?.dominantColor?.color.toString()}'),
                Positioned(
                  left: 30,
                  bottom: 30,
                  child: Container(
                    width: MediaQuery.of(context)
                        .size
                        .width *
                        0.6,
                    child: Text(
                      "${hero?.name}",
                      style: TextStyle(
                        color: hero?.color,
                        fontSize: 30,
                        shadows: const [
                          Shadow(
                            blurRadius: 5.0,
                            color: Colors.black,
                            offset: Offset(2.0, 0.0),
                          ),
                        ],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Positioned.fill(
                    child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          highlightColor: colorState.color.withOpacity(.3),
                          splashColor: colorState.color.withOpacity(.3),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        HeroDetails(
                                            pagePosition:
                                            pagePosition,
                                            hero: hero)));
                          },
                        ))),
              ],
            ),
          ),
        ));
  }
}
