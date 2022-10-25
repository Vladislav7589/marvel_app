
import 'package:flutter/material.dart';
import 'package:marvel_app/constants.dart';
import 'package:palette_generator/palette_generator.dart';


class HeroMarvel {
  int? id;
  String? name;
  String? description;
  String? modified;
  String? imageUrl;
  Color? color;
  HeroMarvel(
      {this.id,
        this.name,
        this.description,
        this.modified,
        this.imageUrl,
        this.color,
      });

  HeroMarvel.fromJson(Map<String, dynamic> json)  {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    modified = json['modified'];
    imageUrl = json['thumbnail']['path'] + "." + json['thumbnail']['extension'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['modified'] = modified;
    data['imageUrl'] = imageUrl;
    data['color'] = color;
    return data;
  }

  static Future<Color> updatePaletteGenerator (String url) async
  {
    PaletteGenerator paletteGenerator = await PaletteGenerator.fromImageProvider(Image.network(url).image,);
    return paletteGenerator.dominantColor!= null ? paletteGenerator.dominantColor!.color : triangleColor;
  }
}

