


class SearchImageData {
  int? frameCount;
  String? error;
  List<Result>? result;

  SearchImageData.fromJson(Map<String, dynamic> json) {
    frameCount = json['frameCount'] as int;
    error = json['error'] as String;
    if (json['result'] != null) {
      result = <Result>[];
      json['result'].forEach((v) {
        result!.add(Result.fromJson(v));
      });
    }
  }
}

class Result {
  int? id;
  int? anilist;
  String? filename;
  num? episode;
  num? from;
  num? to;
  num? similarity;
  String? video;
  String? image;

  Result.fromJson(Map<String, dynamic> json) {
    anilist = json['anilist'];
    filename = json['filename'];
    episode = json['episode'];
    from = json['from'];
    to = json['to'];
    similarity = json['similarity'];
    video = json['video'];
    image = json['image'];
  }
  Map<String, dynamic> toJson() {
    return {
      "anilist": anilist,
      "filename": filename,
      "episode": episode,
      "from": from,
      "to": to,
      "similarity": similarity,
      "video": video,
      "image": image,
      "id": id
    };
  }
}

