import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import '../screens/heroDetails.dart';
import '../utils/colorProvider.dart';

class HeroCard extends StatelessWidget {

  final int pagePosition;

  const HeroCard({Key? key, required this.pagePosition}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ColorProvider state = Provider.of<ColorProvider>(context);
    return  Card(
        color: Colors.transparent,
        margin: const EdgeInsets.only(bottom: 20),
        semanticContainer: true,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 10,
        child: Hero(
          transitionOnUserGestures: true,
          tag: heroes.keys.elementAt(pagePosition),
          child: Material(
            type: MaterialType.transparency, // likely needed
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.asset(
                  heroes.values.elementAt(pagePosition),
                  fit: BoxFit.cover,
                  height: double.infinity,
                  width: double.infinity,
                ),
                Positioned(
                  left: 30,
                  bottom: 30,
                  child: Text(
                    heroes.keys.elementAt(pagePosition),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Positioned.fill(
                    child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          highlightColor: state.color.withOpacity(.3),
                          splashColor: state.color.withOpacity(.3),
                          onTap: () {
                            Navigator.push(
                                context, MaterialPageRoute(builder: (context) => HeroDetails(
                                pagePosition: pagePosition)));
                          },
                        ))),
              ],
            ),
          ),
        ));
  }
}
