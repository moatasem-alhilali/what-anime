import 'dart:convert';
import 'dart:io';

import 'package:anime_finder/core/resources/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AnimeModel {
  int? id;
  int? frameCount;
  String? imageGallery;
  String? createdAt;

  AnimeModel({this.frameCount, this.id, this.imageGallery, this.createdAt});
  AnimeModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    frameCount = json['frameCount'];
    imageGallery = json['image'];
    createdAt = json['date'];
  }
  Map<String, dynamic> toJson() {
    return {
      "frameCount": frameCount,
      "image": imageGallery,
      "id": id,
      "date": createdAt,
    };
  }
}

class InfoModel {
  int? id;
  int? animeId;
  int? anilist;
  String? filename;
  num? episode;
  num? from;
  num? to;
  num? similarity;
  String? video;
  String? image;
  InfoModel({
    this.anilist,
    this.id,
    this.filename,
    this.episode,
    this.from,
    this.to,
    this.similarity,
    this.video,
    this.image,
    this.animeId,
  });

  InfoModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    animeId = json['animeId'];
    anilist = json['anilist'];
    filename = json['filename'];
    episode = json['episode'];
    from = json['froms'];
    to = json['tos'];
    similarity = json['similarity'];
    video = json['video'];
    image = json['image'];
  }
  Map<String, dynamic> toJson() {
    return {
      "animeId": animeId,
      "id": id,
      "anilist": anilist,
      "filename": filename,
      "episode": episode,
      "froms": from,
      "tos": to,
      "similarity": similarity,
      "video": video,
      "image": image,
    };
  }
}

class Utility {
  static Image imageFromBase64String(String base64String) {
    return Image.memory(
      base64Decode(base64String),
      fit: BoxFit.cover,
      height: SizeConfig.vertical! * 20,
      errorBuilder: (context, error, stackTrace) {
        return Container(
          height: SizeConfig.vertical! * 20,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Theme.of(context).splashColor,
          ),
        );
      },
    );
  }

  static Uint8List dataFromBase64String(String base64String) {
    return base64Decode(base64String);
  }

  static String base64String(Uint8List data) {
    return base64Encode(data);
  }
}
