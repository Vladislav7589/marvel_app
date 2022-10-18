import 'package:flutter/material.dart';

import '../constants.dart';

class HeroCard extends StatelessWidget {

  final int pagePosition;

  const HeroCard({Key? key, required this.pagePosition}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Card(
      color: Colors.transparent,
      margin: const EdgeInsets.only(bottom: 20),
      semanticContainer: true,
      clipBehavior: Clip.hardEdge,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 10,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            map.values.elementAt(pagePosition),
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
          ),
          Positioned(
            left: 30,
            bottom: 30,
            child: Text(
              map.keys.elementAt(pagePosition),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        ],
      ),
    );
  }
}
