import 'package:flutter/material.dart';
import 'package:marvel_app/models/hero_marvel.dart';
import 'package:shimmer/shimmer.dart';
import '../constants.dart';
import 'package:cached_network_image/cached_network_image.dart';

class HeroDetails extends StatelessWidget {
  final int pagePosition;
  final HeroMarvel? hero;
  const HeroDetails({Key? key, required this.pagePosition, required this.hero}) : super(key: key);

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
            child: widget()),
      ),
    );
  }

  Widget widget() {
    return  Stack(
        children: [
          "${hero?.imageUrl}" != "http://i.annihil.us/u/prod/marvel/i/mg/b/40/image_not_available.jpg"
              ? CachedNetworkImage(
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
            imageUrl: "${hero?.imageUrl}",
            placeholder: (context, url) =>
                Shimmer.fromColors(
                    baseColor: Colors.transparent,
                    highlightColor: Colors.white10,
                    child: Container(
                      color: backgroundColor,
                    )),
            errorWidget: (context, url, error) =>
                Icon(Icons.error),
          )
              : Image.asset(
            "assets/no_image.png",
            fit: BoxFit.contain,
            height: double.infinity,
            width: double.infinity,
          ),
          Container(
            margin: const EdgeInsets.only(left: 30, bottom: 30,right: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${hero?.name}",
                  //overflow: TextOverflow.clip,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    shadows: [
                      Shadow(
                        blurRadius: 5.0,
                        color: Colors.black,
                        offset: Offset(2.0, 0.0),
                      ),
                    ],
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8,),
                Text(
                  "${hero?.description}",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    shadows: [
                      Shadow(
                        blurRadius: 5.0,
                        color: Colors.black,
                        offset: Offset(2.0, 0.0),
                      ),
                    ],
                    //fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      );
  }
}
