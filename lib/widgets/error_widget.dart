import 'package:flutter/material.dart';

class NetworkErrorWidget extends StatelessWidget {
  final String text;
  const NetworkErrorWidget({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(child: Text(text,style: const TextStyle(color:
    Colors.blue),));
  }
}