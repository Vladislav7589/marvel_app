import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marvel_app/src/providers/database_provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:marvel_app/src/models/heroes.dart';
import 'package:marvel_app/src/styles/styles.dart';

import '../../constants.dart';
import '../database/database.dart';
import '../providers/dio_provider.dart';
import '../widgets/error_widget.dart';
import '../widgets/shimmer.dart';

class HeroDetails extends ConsumerWidget {
  final int? heroId;
  final int? heroDb;
  const HeroDetails(
      {Key? key, required this.heroId, this.heroDb})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      appBar: AppBar(elevation: 0.0, backgroundColor: Colors.transparent),
      body:  heroId !=null?  ref.watch(fetchHeroInfo(heroId!)).when(
              data: (data) => hero(hero: data),
              error: (error, stack) =>  const NetworkErrorWidget(text: "load data internet"),
              loading:() => Container(
                  color: backgroundColor,
                  child:  const ShimmerWidget())
          ) : ref.watch(dataHero(heroDb!)).when(
              data: (data) => hero(heroDB: data),
              error: (error, stack) =>  const NetworkErrorWidget(text: "load database error"),
              loading:() => Container(
                  color: backgroundColor,
                  child: const ShimmerWidget())
      )

    );
  }
}
Hero hero({HeroMarvel? hero, MarvelHeroData? heroDB}) {
  return Hero(
    transitionOnUserGestures: true,
    tag: hero?.id != null? "${hero?.id}" : "${heroDB?.id}",
    child: Material(
        type: MaterialType.transparency, // likely needed
        child: Container(
          color: backgroundColor,
          child: Stack(
            children: [
              "${hero?.imageUrl}" != imageNotAvailable
                  ? hero?.imageUrl != null
                  ? CachedNetworkImage(
                fit: BoxFit.cover,
                height: double.infinity,
                width: double.infinity,
                imageUrl: "${hero?.imageUrl}",
                placeholder: (context, url) => Shimmer.fromColors(
                    baseColor: Colors.transparent,
                    highlightColor: Colors.white10,
                    child: Container(
                      color: backgroundColor,
                    )),
                errorWidget: (context, url, error) =>
                const Icon(Icons.error),
              )
                  : Image.memory(
                base64Decode("${heroDB?.image}"),
                fit: BoxFit.cover,
                height: double.infinity,
                width: double.infinity,
                gaplessPlayback: true,
              )
                  : Image.asset(
                noImage,
                fit: BoxFit.contain,
                height: double.infinity,
                width: double.infinity,
              ),
              Container(
                margin: const EdgeInsets.only(left: 30, bottom: 30, right: 30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text( hero?.name !=null ? "${hero?.name}" :  "${heroDB?.name}",
                        style: textStyle(30, FontWeight.bold)),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                        hero?.name !=null ? hero?.description != "" ? "${hero?.description}" : "Missing" :  "${heroDB?.name}",
                        style: textStyle(25, null)),
                  ],
                ),
              ),
            ],
          ),
        )),
  );
}