import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sm_bar_master_frontend/data/model/album_model.dart';
import 'package:sm_bar_master_frontend/data/model/album_preview_image_model.dart';

Future<bool> createAlbum(AlbumModel albumModel) async {
  final url = Uri.parse("http://localhost:3003/album");

  final response = await http.post(
    url,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(albumModel.toJson()),
  );

  if (response.statusCode == 201) {
    print('create album success');
    return true;
  } else {
    return false;
    // throw Exception(
    //     'Failed to create album. Status code: ${response.statusCode}');
  }
}
Future<List<AlbumPreviewImageModel>> fetchAllAlbumPreviewImage() async {
  final url = Uri.parse("http://localhost:3003/album/preview");

  final response = await http.get(url);

  if (response.statusCode == 200) {
    List<dynamic> jsonData = jsonDecode(response.body);
    List<AlbumPreviewImageModel> albumList = jsonData
        .map((jsonItem) =>
            AlbumPreviewImageModel.fromJson(jsonItem as Map<String, dynamic>))
        .toList();
    return albumList;
  } else {
    throw Exception(
        'Failed to load preview images. Status code: ${response.statusCode}');
  }
}

Future<bool> deleteAlbum(int id) async {
  final url = Uri.parse("http://localhost:3003/album/$id");

  final response = await http.delete(url);

  if (response.statusCode == 200) {
    return true;
  } else {
    return true;
  }
}
