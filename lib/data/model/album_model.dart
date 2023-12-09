import 'package:sm_bar_master_frontend/data/model/song_entity.dart';

class AlbumModel {
  int? albumId;
  String? imageUrl;
  String? title;
  String? date;
  String? backgroundColor;
  List<SongEntity>? songEntities;

  AlbumModel({
    this.imageUrl = 'lib/assets/image_placeholder_no_image.png',
    this.title = 'No Title',
    this.date = '2099.99.99',
    this.backgroundColor = '0xFF475C66',
    List<SongEntity>? songEntities,
  }) : songEntities = songEntities ?? [SongEntity()];

  AlbumModel.fromJson(Map<String, dynamic> json) {
    albumId = json['album_id'];
    imageUrl = json['image_url'];
    title = json['title'];
    date = json['date'];
    backgroundColor = json['backgroundColor'];
    if (json['songEntities'] != null) {
      songEntities = <SongEntity>[];
      json['songEntities'].forEach((v) {
        songEntities!.add(SongEntity.fromJson(v));
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
