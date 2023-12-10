import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sm_bar_master_frontend/data/model/album_model.dart';
import 'package:sm_bar_master_frontend/utils/types.dart';
import 'package:sm_bar_master_frontend/data/model/song_entity.dart';

class NewAlbumViewModel with ChangeNotifier {
  AlbumSelectedOption _nowSelected = AlbumSelectedOption.albumTitle;
  AlbumSelectedOption get nowSelected => _nowSelected;

  changeSelectedOption(AlbumSelectedOption option) {
    _nowSelected = option;
    notifyListeners();
  }

  //############

  int _nowSongIndex = 0;
    ///nowSongIndex   0: 앨범 타이틀페이지, 1 ~ : 노래 페이지
  int get nowSongIndex => _nowSongIndex;

  setNowSongIndex(int index) {
    _nowSongIndex = index;
    notifyListeners();
  }

  //############

  AlbumModel _albumModel = AlbumModel();
  AlbumModel get albumModel => _albumModel;

  //############
  
  final List<XFile?> _newAlbumPreviewImages = [null,null];
  List<XFile?> get newAlbumPreviewImages => _newAlbumPreviewImages;

  setNewAlbumPreviewImages(XFile? image, int index) {
    _newAlbumPreviewImages[index] = image;
    notifyListeners();
  }

  void changeAlbumData() {
    _albumModel = AlbumModel();
    notifyListeners();
  }

  void addSongEntity(SongEntity songEntity) {
    _albumModel.songEntities!.add(songEntity);
    _newAlbumPreviewImages.add(null);
    notifyListeners();
  }

  void removeSongEntity(int index) {
    _albumModel.songEntities!.removeAt(index);
    _newAlbumPreviewImages.removeAt(index);
    notifyListeners();
  }
}
