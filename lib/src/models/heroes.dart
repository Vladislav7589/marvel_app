import 'package:flutter/material.dart';
import 'package:marvel_app/constants.dart';
import 'package:palette_generator/palette_generator.dart';

class Heroes {
  List<HeroMarvel>? heroMarvel;

  Heroes({this.heroMarvel});

  Heroes.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      heroMarvel = <HeroMarvel>[];
      json['results'].forEach((v) {
        heroMarvel!.add(HeroMarvel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (heroMarvel != null) {
      data['results'] = heroMarvel!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class HeroMarvel {
  int? id;
  String? name;
  String? description;
  String? imageUrl;
  int? color;
  HeroMarvel(
      {this.id,
        this.name,
        this.description,
        this.imageUrl,
        this.color,
      });

  HeroMarvel.fromJson(Map<String, dynamic> json)  {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    imageUrl = json['thumbnail']['path'] + "." + json['thumbnail']['extension'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['imageUrl'] = imageUrl;
    data['color'] = color;
    return data;
  }

  static Future<int> updatePaletteGenerator (String url) async
  {
    PaletteGenerator paletteGenerator = await PaletteGenerator.fromImageProvider(Image.network(url).image,);
    return paletteGenerator.dominantColor!= null ? paletteGenerator.dominantColor!.color.value : triangleColor.value;
  }

}

