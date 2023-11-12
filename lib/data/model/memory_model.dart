class AlbumPreviewImageModel {
  int? albumId;
  String? imageUrl;

  AlbumPreviewImageModel({this.albumId, this.imageUrl});

  AlbumPreviewImageModel.fromJson(Map<String, dynamic> json) {
    albumId = json['album_id'];
    imageUrl = json['image_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['album_id'] = albumId;
    data['image_url'] = imageUrl;
    return data;
  }
}