class AlbumModel {
  int? albumId;
  String? imageUrl;
  String? title;
  String? date;
  String? backgroundColor;
  List<SongEntities>? songEntities;

  AlbumModel(
      {this.albumId,
      this.imageUrl = 'lib/assets/placeholder.png',
      this.title = 'No Title',
      this.date = '2099.99.99',
      this.backgroundColor = '0xFF475C66',
      this.songEntities = const <SongEntities>[]});


/*
class NewAlbumData {
  late String albumTitle;
  late String date;
  late String backgroundColor;

  late String cdImage;
  late String cocktailName;
  late String review;

  NewAlbumData({
    this.date = '123',
    this.albumTitle = '132',
    this.backgroundColor = '0xFF475C66',
    this.cdImage = 'lib/assets/user_img01.jpg',
    this.cocktailName = '234235',
    this.review = 'asd',
  });
}
*/

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
  String? imageData;
  String? title;
  String? content;
  int? score;

  SongEntities(
      {this.songId,
      this.imageUrl,
      this.imageData,
      this.title,
      this.content,
      this.score});

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