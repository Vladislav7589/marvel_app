import 'package:flutter/material.dart';


const String imageNotAvailable = 'http://i.annihil.us/u/prod/marvel/i/mg/b/40/image_not_available.jpg';
const String noImage = 'assets/no_image.png';
const String marvelLogo = 'assets/marvel.png';
const String marvelLogoDark = 'assets/marvelDark.png';

const double scaleFactor = 0.8;
const Color backgroundColor = Color(0xff2a262b);

Color triangleColor = Colors.blue;
String firebaseToken = '';
const String scheme = 'http://';
const String domain = 'gateway.marvel.com';
const String pathGettingHeroes = '/v1/public/characters';

const int offset = 950;
const int amountHeroes = 8;

const baseUrl = scheme + domain + pathGettingHeroes;
