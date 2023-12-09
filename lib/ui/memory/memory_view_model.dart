import 'package:flutter/material.dart';
import 'package:sm_bar_master_frontend/data/model/album_preview_image_model.dart';
import 'package:sm_bar_master_frontend/data/datasource/remote_datasource.dart';

///변수 목록: memoryPreviewImages
class MemoryViewModel with ChangeNotifier {
  MemoryViewModel() {
    _memoryPreviewImages = fetchAllAlbumPreviewImage();
  }

  Future<List<AlbumPreviewImageModel>>? _memoryPreviewImages;
  Future<List<AlbumPreviewImageModel>>? get memoryPreviewImages =>
      _memoryPreviewImages;

  Future<void> fetchdata() async {
    _memoryPreviewImages = fetchAllAlbumPreviewImage();
    await _memoryPreviewImages;
    notifyListeners();
  }
}
