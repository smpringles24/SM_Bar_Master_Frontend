import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sm_bar_master_frontend/data/model/memory_model.dart';

Future<List<AlbumPreviewImageModel>> fetchAllAlbumPreviewImage() async {
  final url = Uri.parse("http://localhost:3003/album/preview");

  final response = await http.get(url);

  if (response.statusCode == 200) {
    List<dynamic> jsonData = jsonDecode(response.body);
    List<AlbumPreviewImageModel> albumList = jsonData.map((jsonItem) => 
      AlbumPreviewImageModel.fromJson(jsonItem as Map<String, dynamic>))
      .toList();
    return albumList;
  } else {
    throw Exception('Failed to load preview images. Status code: ${response.statusCode}');
  }
}
