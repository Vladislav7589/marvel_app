import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../translations/locale_keys.g.dart';


class NetworkErrorWidget extends ConsumerWidget {
  final String text;
  const NetworkErrorWidget({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView(
        children: [
          Center(child: Text(text,style: const TextStyle(fontSize: 30 , color:
          Colors.red,fontWeight: FontWeight.bold),)),
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