import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants.dart';
import '../screens/hero_details.dart';
import 'package:marvel_app/models/hero_marvel.dart';
import 'package:marvel_app/widgets/shimmer.dart';
import '../providers/color_provider.dart';
import '../styles/styles.dart';

class HeroCard extends StatelessWidget {
  final int pagePosition;
  final HeroMarvel? hero;

  const HeroCard({Key? key, required this.pagePosition, required this.hero})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    ColorProvider colorState = Provider.of<ColorProvider>(context);

    return hero != null
        ? Hero(
            transitionOnUserGestures: true,
            tag: "${hero?.id}",
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
                            return CachedNetworkImage(
                              fit: BoxFit.cover,
                              height: double.infinity,
                              width: double.infinity,
                              imageUrl: "${hero?.imageUrl}",
                              placeholder: (context, url) =>
                                  const ShimmerWidget(),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
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
                          "${hero?.name}",
                          style: textStyle(30, FontWeight.bold)
                        ),
                      ),
                    ),
                    Positioned.fill(
                        child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              highlightColor: colorState.color.withOpacity(.6),
                              splashColor: colorState.color.withOpacity(.3),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => HeroDetails(
                                            pagePosition: pagePosition,
                                            hero: hero)));
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
