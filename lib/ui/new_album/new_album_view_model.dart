import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sm_bar_master_frontend/data/model/album_model.dart';
import 'package:sm_bar_master_frontend/data/model/etc_model.dart';
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
    ///nowSongIndex   -1: 앨범 타이틀페이지, 0~: 노래 페이지
  int get nowSongIndex => _nowSongIndex;

  setNowSongIndex(int index) {
    _nowSongIndex = index;
    notifyListeners();
  }

  //############

  AlbumModel _albumModel = AlbumModel();
  AlbumModel get albumModel => _albumModel;

  //############

  XFile? _newAlbumTitlePreviewImage;
  XFile? get newAlbumTitlePreviewImage => _newAlbumTitlePreviewImage;

  setNewAlbumTitlePreviewImage(XFile image) {
    _newAlbumTitlePreviewImage = image;
    notifyListeners();
  }

  void changeAlbumData() {
    _albumModel = AlbumModel();
    notifyListeners();
  }

  void addSongEntity(SongEntity songEntity) {
    _albumModel.songEntities!.add(songEntity);
    notifyListeners();
  }

  void removeSongEntity(int index) {
    _albumModel.songEntities!.removeAt(index);
    notifyListeners();
  }
}
