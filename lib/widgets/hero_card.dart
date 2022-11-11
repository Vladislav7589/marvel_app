import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:marvel_app/database/database.dart';
import 'package:provider/provider.dart';
import '../constants.dart';
import '../screens/hero_details.dart';
import 'package:marvel_app/models/hero_marvel.dart';
import 'package:marvel_app/widgets/shimmer.dart';
import '../providers/color_provider.dart';
import '../styles/styles.dart';
import 'dart:convert';

class HeroCard extends StatelessWidget {
  final int pagePosition;
  final HeroMarvel? hero;
  final MarvelHeroData? heroDB;

  const HeroCard({Key? key, required this.pagePosition, required this.hero, this.heroDB})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    ColorProvider colorState = Provider.of<ColorProvider>(context);

    return heroDB != null
        ? Hero(
            transitionOnUserGestures: true,
            tag:  hero?.id !=null ? "${hero?.id}" :  "${heroDB?.id}",
            child: Card(
              color: Colors.transparent,
              margin: const EdgeInsets.only(bottom: 20),
              semanticContainer: true,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              elevation: 10,
              child: Material(
                type: MaterialType.transparency, // likely needed
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    "${hero?.imageUrl}" != imageNotAvailable
                        ? Builder(builder: (context) {
                            return hero?.imageUrl != null ? CachedNetworkImage(
                              fit: BoxFit.cover,
                              height: double.infinity,
                              width: double.infinity,
                              imageUrl: "${hero?.imageUrl}",
                              placeholder: (context, url) =>
                                  const ShimmerWidget(),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ): 
                            Image.memory(base64Decode("${heroDB?.image}"),
                              fit: BoxFit.cover,
                              height: double.infinity,
                              width: double.infinity,
                              gaplessPlayback: true,
                              excludeFromSemantics: true,
                            );
                          })
                        : Image.asset(
                            noImage,
                            fit: BoxFit.contain,
                            height: double.infinity,
                            width: double.infinity,
                          ),
                    Positioned(
                      left: 30,
                      bottom: 30,
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.6,
                        child: Text(
                            hero?.name !=null ? "${hero?.name}" :  "${heroDB?.name}",
                          style: textStyle(30, FontWeight.bold)
                        ),
                      ),
                    ),
                    Positioned.fill(
                        child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              highlightColor: Color(colorState.color).withOpacity(.6),
                              splashColor: Color(colorState.color).withOpacity(.3),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => HeroDetails(
                                            pagePosition: pagePosition,
                                            hero: hero,
                                            heroDB: heroDB)));
                              },
                            ))),
                  ],
                ),
              ),
            ),
          )
        : const ShimmerWidget();
  }
}
