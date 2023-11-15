import 'package:flutter/material.dart';
import 'package:sm_bar_master_frontend/data/model/album_preview_image_model.dart';
import 'package:sm_bar_master_frontend/data/datasource/remote_datasource.dart';

class MemoryViewModel with ChangeNotifier {
  MemoryViewModel() {
    _memoryPreviewImages = fetchAllAlbumPreviewImage();
  }

  Future<List<AlbumPreviewImageModel>>? _memoryPreviewImages;

  Future<List<AlbumPreviewImageModel>>? get memoryPreviewImages =>
      _memoryPreviewImages;

  Future<void> fetchdata() async {
    _memoryPreviewImages = fetchAllAlbumPreviewImage();
    await _memoryPreviewImages; // 데이터 로딩 완료 대기
    notifyListeners(); // 데이터 변경 알림
  }
}
