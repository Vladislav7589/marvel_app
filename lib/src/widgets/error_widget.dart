import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../translations/locale_keys.g.dart';


class NetworkErrorWidget extends StatelessWidget {
  final String text;
  const NetworkErrorWidget({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
        children: [
          Center(child: Text(text,textAlign:TextAlign.center, style: const TextStyle(fontSize: 30 , color:
          Colors.red,fontWeight: FontWeight.bold),)),
          const Padding(padding: EdgeInsets.symmetric(vertical: 5)),
          Text(
            LocaleKeys.connectionSwipeConnection.tr(),
            style: const TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ],
    );


  }
}