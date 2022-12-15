import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:marvel_app/src/database/database.dart';
import 'package:marvel_app/translations/locale_keys.g.dart';

import '../../constants.dart';
import '../screens/hero_details.dart';
import 'package:marvel_app/src/models/heroes.dart';
import 'package:marvel_app/src/widgets/shimmer.dart';
import '../styles/styles.dart';
import 'dart:convert';

class HeroCard extends StatelessWidget {

  final HeroMarvel? hero;
  final MarvelHeroData? heroDB;
  final bool details;

  const HeroCard({Key? key, this.hero,  this.heroDB, required this.details})
      : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Hero(
            transitionOnUserGestures: true,
            tag:  hero?.id !=null ? '${hero?.id}' :  '${heroDB?.id}',
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    border: details? Border.all(width: 0): Border.all(color: Colors.white10)
                ),
                child: Material(
                    type: MaterialType.transparency, // likely needed
                    child: Stack(
                      children: [
                        '${hero?.imageUrl}' != imageNotAvailable
                            ? hero?.imageUrl != null ? CachedNetworkImage(
                                  fit: BoxFit.cover,
                                  height: double.infinity,
                                  width: double.infinity,
                                  imageUrl: "${hero?.imageUrl}",
                                  placeholder: (context, url) =>
                                      const ShimmerWidget(),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                ):
                                Image.memory(base64Decode('${heroDB?.image}'),
                                  fit: BoxFit.cover,
                                  height: double.infinity,
                                  width: double.infinity,
                                  gaplessPlayback: true,
                                  excludeFromSemantics: true,
                                )
                            : Transform.scale(
                              scale: 0.8,
                              child: Image.asset(
                                  noImage,
                                  fit: BoxFit.contain,
                                  height: double.infinity,
                                  width: double.infinity,
                                ),
                            ),
                        Positioned(

                          child: Container(
                            padding:  EdgeInsets.only(left: 30,bottom: MediaQuery.of(context).orientation == Orientation.portrait?30:20,right: 30),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text( hero?.name !=null ? '${hero?.name}' :  '${heroDB?.name}',
                                    style: textStyle(MediaQuery.of(context).orientation == Orientation.portrait?30:25, FontWeight.bold)),
                                const SizedBox(
                                  height: 8,
                                ),
                                if(details) Flexible(
                                  child: Text(
                                      hero?.description !=null ? hero?.description != '' ? '${hero?.description}' : LocaleKeys.missing.tr() :  heroDB?.description != '' ? '${heroDB?.description}' : LocaleKeys.missing.tr(),
                                      style: textStyle( MediaQuery.of(context).orientation == Orientation.portrait?25:20, null),
                                      maxLines: MediaQuery.of(context).orientation == Orientation.portrait?18:7,
                                    textAlign: TextAlign.justify,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        if(!details)Positioned.fill(
                            child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  highlightColor: Color(hero !=null ? hero!.color! :  heroDB!.color).withOpacity(.6),
                                  splashColor: Color(hero !=null ? hero!.color! :  heroDB!.color).withOpacity(.3),
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => HeroDetails(
                                                heroId: hero?.id,
                                                heroDb: heroDB?.id,
                                            )));
                                  },
                                ))),
                      ],
                    ),
                  ),
              ),
            ),

          );
  }
}
