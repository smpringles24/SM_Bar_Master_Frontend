class AlbumModel {
  int? albumId;
  String? imageUrl;
  String? title;
  String? date;
  String? backgroundColor;
  List<SongEntities>? songEntities;

  AlbumModel(
      {this.imageUrl = 'lib/assets/placeholder.png',
      this.title = 'No Title',
      this.date = '2099.99.99',
      this.backgroundColor = '0xFF475C66',
      this.songEntities = const <SongEntities>[]});

  AlbumModel.fromJson(Map<String, dynamic> json) {
    albumId = json['album_id'];
    imageUrl = json['image_url'];
    title = json['title'];
    date = json['date'];
    backgroundColor = json['backgroundColor'];
    if (json['songEntities'] != null) {
      songEntities = <SongEntities>[];
      json['songEntities'].forEach((v) {
        songEntities!.add(SongEntities.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['album_id'] = albumId;
    data['image_url'] = imageUrl;
    data['title'] = title;
    data['date'] = date;
    data['backgroundColor'] = backgroundColor;
    if (songEntities != null) {
      data['songEntities'] = songEntities!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SongEntities {
  int? songId;
  String? imageUrl;
  String? imageData;    //TODO - 아직 사용 안함
  String? title;
  String? content;
  int? score;           //TODO - 아직 사용 안함

  SongEntities(
      {this.songId,
      this.imageUrl,
      this.imageData = 'some image data',
      this.title,
      this.content,
      this.score = 5});

  SongEntities.fromJson(Map<String, dynamic> json) {
    songId = json['song_id'];
    imageUrl = json['image_url'];
    imageData = json['image_data'];
    title = json['title'];
    content = json['content'];
    score = json['score'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['song_id'] = songId;
    data['image_url'] = imageUrl;
    data['image_data'] = imageData;
    data['title'] = title;
    data['content'] = content;
    data['score'] = score;
    return data;
  }
}
