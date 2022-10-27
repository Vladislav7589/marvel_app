
import 'package:flutter/material.dart';


Map<String, String> heroes = {
  "Deadpool": "assets/deadpool.jpg",
  "Spider-man": "assets/spider-man.jpg",
  "Thanos": "assets/thanos.jpg",
  "Tor":"assets/tor.jpg"
};
Map<String, String> description = {
  "Deadpool": "He possesses inhuman strength, agility, and an incredible ability to regenerate.",
  "Spider-man": "Throws a web",
  "Thanos": "Supervillain marvel universe of heroes",
  "Tor":"god of thunder"
};

Map<String, String> heroImageNetwork = {
  "Deadpool": "https://drive.google.com/uc?export=view&id=1Df0KHKJa3cDPUcEoHpYB4eb7l8zlwdNx",
  "Spider-man": "https://drive.google.com/uc?export=view&id=1a-RP2pAAaqIMcybM9n8nCgJRm0znwr47",
  "Thanos": "https://drive.google.com/uc?export=view&id=1VG0fVnZDvhsfKpJ4WtfGoFnPggVYntaX",
  "Tor":"https://drive.google.com/uc?export=view&id=1r21bZlocTKKXMz-g_5JoYD4lb3lwJr-j"
};

const String imageNotAvailable = "http://i.annihil.us/u/prod/marvel/i/mg/b/40/image_not_available.jpg";
const String noImage = "assets/no_image.png";
const String marvelLogo = "assets/marvel.png";

const double scaleFactor = 0.8;
const Color backgroundColor = Color(0xff2a262b);

Color triangleColor = Colors.blue;

const String scheme = "http://";
const String domain = "gateway.marvel.com";
const String pathGettingHeroes = "/v1/public/characters";
const String hash = "27bd3f64b1bcb316e2ca4040142600de";
const String apikey = "cb61977455abaddbf11ec15f021e8f1b";
const int offset = 200;
const int ts = 1;
const int amountHeroes = 8;

const baseUrl = scheme + domain + pathGettingHeroes;

