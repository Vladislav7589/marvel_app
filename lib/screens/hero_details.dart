import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../constants.dart';
import 'package:marvel_app/models/hero_marvel.dart';
import 'package:marvel_app/styles/styles.dart';

class HeroDetails extends StatelessWidget {
  final int pagePosition;
  final HeroMarvel? hero;

  const HeroDetails({Key? key, required this.pagePosition, required this.hero})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      appBar: AppBar(elevation: 0.0, backgroundColor: Colors.transparent),
      body: Hero(
        transitionOnUserGestures: true,
        tag: "${hero?.id}",
        child: Material(
            type: MaterialType.transparency, // likely needed
            child: page()),
      ),
    );
  }

  Widget page() {
    return Container(
      color: backgroundColor,
      child: Stack(
        children: [
          "${hero?.imageUrl}" != imageNotAvailable
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
                  errorWidget: (context, url, error) => const Icon(Icons.error),
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
                Text(
                  "${hero?.name}",
                  style: textStyle(30, FontWeight.bold)
                ),
                const SizedBox(
                  height: 8,
                ),
                 Text(
                  hero?.description != "" ? "${hero?.description}" : "Missing",
                        style: textStyle(25, null)
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
