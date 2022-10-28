import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../constants.dart';
import 'package:cached_network_image/cached_network_image.dart';

class HeroDetails extends StatelessWidget {
  final int pagePosition;

  const HeroDetails({Key? key, required this.pagePosition}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      appBar: AppBar(elevation: 0.0, backgroundColor: Colors.transparent),
      body: Hero(
        transitionOnUserGestures: true,
        tag: heroes.keys.elementAt(pagePosition),
        child: Material(
            //color: Theme.of(context).primaryColor.withOpacity(0.25),
            type: MaterialType.transparency, // likely needed
            child: widget()),
      ),
    );
  }

  Widget widget() {
    return Stack(
      children: [
        CachedNetworkImage(
          fit: BoxFit.cover,
          height: double.infinity,
          width: double.infinity,
          imageUrl: heroImageNetwork.values.elementAt(pagePosition),
          placeholder: (context, url) => Shimmer.fromColors(
              baseColor: backgroundColor,
              highlightColor: Colors.white10,
              child: Container(
                color: backgroundColor,
              )),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
        Container(
          margin: const EdgeInsets.only(left: 30, bottom: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                heroes.keys.elementAt(pagePosition),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                description.values.elementAt(pagePosition),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 25,
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
