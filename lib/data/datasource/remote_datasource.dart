import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:sm_bar_master_frontend/data/model/album_model.dart';
import 'package:sm_bar_master_frontend/data/model/album_preview_image_model.dart';

Future<void> uploadImageToS3(XFile? imageFile) async {
  if (imageFile == null) return;

  final Uri url = Uri.parse("http://localhost:3003/album/img");

  http.MultipartRequest request = http.MultipartRequest('POST', url);

  Uint8List imageData = await imageFile.readAsBytes();
  request.files.add(http.MultipartFile.fromBytes(
    'file',
    imageData,
    filename: imageFile.name,
  ));

  try {
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 201) {
      print('Uploaded!');
    } else {
      print('Failed. Status code: ${response.statusCode}');
    }
  } catch (e) {
    print('Error: $e');
  }
}

Future<bool> createAlbum(AlbumModel albumModel) async {
  final url = Uri.parse("http://localhost:3003/album");

  // S3에 이미지 업로드

  // 앨범 정보에 이미지 url 저장

  // DB에 앨범 데이터 저장

  final response = await http.post(
    url,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(albumModel.toJson()),
  );

  // 결과 반환
  if (response.statusCode == 201) {
    return true;
  } else {
    return false;
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

Future<AlbumModel> getAlbumById(int id) async {
  final url = Uri.parse("http://localhost:3003/album/$id");

  final response = await http.get(url);

  if (response.statusCode == 200) {
    AlbumModel albumModel = AlbumModel.fromJson(jsonDecode(response.body));
    return albumModel;
  } else {
    throw Exception(
        'Failed to load album. Status code: ${response.statusCode}');
  }
}

Future<bool> deleteAlbum(int id) async {
  final url = Uri.parse("http://localhost:3003/album/$id");

  final response = await http.delete(url);

  if (response.statusCode == 200) {
    return true;
  } else {
    return false;
  }
}
