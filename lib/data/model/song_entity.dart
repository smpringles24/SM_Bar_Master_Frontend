class SongEntity {
  int? songId;
  String? imageUrl;
  String? imageData;    //TODO - 아직 사용 안함
  String? title;
  String? content;
  int? score;           //TODO - 아직 사용 안함

  SongEntity(
      {this.songId,
      this.imageUrl = 'lib/assets/placeholder.png',
      this.imageData = 'some image data',
      this.title = 'No Title',
      this.content = 'No Content',
      this.score = 5});

  SongEntity.fromJson(Map<String, dynamic> json) {
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
